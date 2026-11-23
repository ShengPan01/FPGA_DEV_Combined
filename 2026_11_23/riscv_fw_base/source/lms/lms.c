/* LMS/LMOTS SHA-256/192, all SP 800-208 section 4.2 combinations.
 * Hash outputs are truncated after EVERY SHA-256 operation. */
#include "lms.h"
#include "sha256.h"
#include "endian.h"
#include <string.h>
static void wipe(void* v, size_t n)
{
  volatile unsigned char* p = v;
  while (n--) *p++ = 0;
}
static void update(SHA256_CTX* c, const void* v, size_t n)
{
  const unsigned char* p = v;
  while (n) {
    unsigned k = n > 1048576 ? 1048576 : (unsigned)n;
    SHA256_Update(c, p, k);
    p += k;
    n -= k;
  }
}

// SHA-256/192: Finalize SHA-256 and truncate output to 24 bytes (192 bits).
static void final24(SHA256_CTX* c, unsigned char out[24])
{
  unsigned char full[32];
  SHA256_Final(full, c);
  memcpy(out, full, 24);
  wipe(full, sizeof full);
  wipe(c, sizeof *c);
}
static void hash24(unsigned char out[24], const void* v, size_t n)
{
  SHA256_CTX c;
  SHA256_Init(&c);
  update(&c, v, n);
  final24(&c, out);
}
static void prefix(unsigned char* b, const unsigned char* id, uint32_t q, unsigned d)
{
  memcpy(b, id, 16);
  put_bigendian(b + 16, q, 4);
  put_bigendian(b + 20, d, 2);
}
int lms_params(unsigned h, unsigned w, lms_parameters* out)
{
  static const unsigned ws[4] = {1, 2, 4, 8}, ps[4] = {200, 101, 51, 26}, ls[4] = {8, 6, 4, 0};
  unsigned i;
  if (!out || h < 5 || h > 25 || h % 5) return 0;
  for (i = 0; i < 4; i++)
    if (w == ws[i]) {
      out->h = h;
      out->w = w;
      out->p = ps[i];
      out->ls = ls[i];
      out->lms_type = 9 + h / 5;
      out->ots_type = 5 + i;
      out->capacity = UINT32_C(1) << h;
      out->signature_bytes = 12 + 24 * (size_t)(1 + ps[i] + h);
      return 1;
    }
  return 0;
}

//从公钥参数得到树高h和Winternitz 参数W值
int lms_params_from_types(uint32_t lm, uint32_t ots, lms_parameters* out)
{
  static const unsigned ws[4] = {1, 2, 4, 8};
  if (lm < 10 || lm > 14 || ots < 5 || ots > 8) return 0;
  return lms_params((lm - 9) * 5, ws[ots - 5], out);
}
static unsigned coef(const unsigned char* a, unsigned i, unsigned w)
{
  return (a[(i * w) / 8] >> (8 - w - (i * w) % 8)) & ((1u << w) - 1);
}
static int digest(unsigned char a[26], const unsigned char* id, uint32_t q, const unsigned char* c,
                   lms_read_message read, void* user, size_t len, const lms_parameters* p)
{
  unsigned char b[46];
  unsigned sum = 0, i;
  SHA256_CTX ctx;

  //id: 公钥标识符：16 bytes
  //q: 叶子索引，4 bytes
  //c: 随机数C，24 bytes
  prefix(b, id, q, 0x8181);
  memcpy(b + 22, c, 24);
  SHA256_Init(&ctx);
  update(&ctx, b, sizeof b);
  {
    unsigned char chunk[256];
    size_t offset = 0;
    while (offset < len) {
      size_t n = len - offset;
      if (n > sizeof chunk) n = sizeof chunk;
      if (!read(user, offset, chunk, n)) return 0;
      update(&ctx, chunk, n);
      offset += n;
    }
  }
  final24(&ctx, a);

  //digest checksum calculation
  for (i = 0; i < 192 / p->w; i++) 
    sum += ((1u << p->w) - 1) - coef(a, i, p->w);

  put_bigendian(a + 24, sum << p->ls, 2);
  return 1;
}
static void chain(unsigned char x[24], const unsigned char* id, uint32_t q, unsigned i,
                  unsigned start, unsigned end)
{
  unsigned char b[47];
  unsigned j;
  memcpy(b, id, 16);
  put_bigendian(b + 16, q, 4);
  put_bigendian(b + 20, i, 2);
  for (j = start; j < end; j++) {
    b[22] = (unsigned char)j;
    memcpy(b + 23, x, 24);
    hash24(x, b, sizeof b);
  }
  wipe(b, sizeof b);
}
static void node(unsigned char out[24], const unsigned char* id, uint32_t r, unsigned d,
                 const unsigned char* a, const unsigned char* b)
{
  unsigned char buf[70];
  prefix(buf, id, r, d);
  memcpy(buf + 22, a, 24);
  if (b) memcpy(buf + 46, b, 24);
  hash24(out, buf, b ? 70 : 46);
}

/* Verify one LMS signature against its message and 48-byte public key.
 * Return 1 only when the reconstructed Merkle root matches the public root. */
int lms_verify_stream(const unsigned char* pub, size_t plen, lms_read_message read, void* user, size_t len,
               const unsigned char* sig, size_t slen)
{
  uint32_t q, r;
  unsigned i, diff = 0;
  size_t type_offset;
  unsigned char a[26], x[24], k[24], v[24], b[22];
  SHA256_CTX ctx;
  lms_parameters p;

  /* Reject missing buffers and malformed public-key size before reading fields.
   * A NULL reader is valid only for the zero-length message. */
  if (!pub || !sig || (!read && len) || plen != 48) return 0;

  /* The public key selects the supported LMS/LM-OTS parameter set. Its p and h
   * values determine the exact signature layout and expected byte length. */
  if (!lms_params_from_types((uint32_t)get_bigendian(pub, 4), (uint32_t)get_bigendian(pub + 4, 4),
                             &p) ||
      slen != p.signature_bytes)
    return 0;

  /* The signature repeats both type codes. Require them to agree with the key
   * before using the parameter-derived offsets below. */
  //检查签名中的类型码是否与公钥参数一致
  type_offset = 32 + 24 * (size_t)p.p;
  if (get_bigendian(sig + 4, 4) != p.ots_type || get_bigendian(sig + type_offset, 4) != p.lms_type)
    return 0;

  /* q selects the one-time signing key (leaf) and must fit in this LMS tree. */
  //从签名中提取叶子索引q，并检查其是否在树的容量范围内
  q = (uint32_t)get_bigendian(sig, 4);
  if (q >= p.capacity) return 0;

  /* Hash the domain prefix, randomizer C, and message; append the LM-OTS
   * checksum so digest coefficients cover the complete chain lengths. */
  //计算消息摘要a，包含域前缀、随机数C、消息和LM-OTS校验和
  /*
  a：返回值：消息摘要，包含域前缀、随机数C、消息和LM-OTS校验和
  pub + 8: 输入：公钥 标识符
  q: 输入：叶子索引， 4字节
  sig + 8: 输入：随机数C
  msg: 输入：消息
  len: 输入：消息长度
  &p: 输入：LMS参数结构体
  */
  if (!digest(a, pub + 8, q, sig + 8, read, user, len, &p)) return 0;

  /* Reconstruct the LM-OTS public value K. Each signature element y[i] is
   * advanced from its message-derived coefficient to the end of its chain. */
  prefix(b, pub + 8, q, 0x8080);
  SHA256_Init(&ctx);
  update(&ctx, b, 22);
  for (i = 0; i < p.p; i++) {
    memcpy(x, sig + 32 + 24 * i, 24);
    chain(x, pub + 8, q, i, coef(a, i, p.w), (1u << p.w) - 1);
    update(&ctx, x, 24);
  }
  final24(&ctx, k);

  /* Hash K as leaf q. LMS numbers leaves starting at capacity, so the heap
   * index is capacity + q; the domain-separation value identifies a leaf. */
  r = p.capacity + q;
  node(v, pub + 8, r, 0x8282, k, 0);

  /* Walk from that leaf to the root using the h authentication nodes in the
   * signature. The low bit of r tells whether the current node is the right
   * child (sibling goes first) or the left child (current hash goes first). */
  for (i = 0; i < p.h; i++) {
    const unsigned char* path = sig + type_offset + 4 + 24 * i;
    if (r & 1) node(v, pub + 8, r >> 1, 0x8383, path, v);
    else node(v, pub + 8, r >> 1, 0x8383, v, path);
    r >>= 1;
  }

  /* Compare all root bytes without exiting early, then accept only an exact
   * match with T[1] stored at public-key offset 24. */
  for (i = 0; i < 24; i++) diff |= v[i] ^ pub[24 + i];
  return diff == 0;
}

static int memory_read(void* user, size_t offset, unsigned char* dst, size_t len)
{
  memcpy(dst, (const unsigned char*)user + offset, len);
  return 1;
}
int lms_verify(const unsigned char* pub, size_t plen, const void* msg, size_t len,
               const unsigned char* sig, size_t slen)
{
  if (!msg && len) return 0;
  return lms_verify_stream(pub, plen, memory_read, (void*)msg, len, sig, slen);
}
