#ifndef LMS192_H
#define LMS192_H
#include <stddef.h>
#include <stdint.h>
#define LMS_PUBLIC_BYTES 48
#define LMS_MAX_SIGNATURE_BYTES 5436
#define LMS_PRIVATE_BYTES 68

/* NIST SP 800-208 section 4.2 Tables 3/4; assigned IDs from RFC 9858. */
typedef struct {
  unsigned h, w, p, ls;
  uint32_t lms_type, ots_type, capacity;
  size_t signature_bytes;
} lms_parameters;

int lms_params(unsigned h, unsigned w, lms_parameters* out);
int lms_params_from_types(uint32_t lms_type, uint32_t ots_type, lms_parameters* out);

/* Callback must fill exactly len bytes and return 1; return 0 on read failure.
 * Offsets are relative to the message; no complete message buffer is needed. */
typedef int (*lms_read_message)(void* user, size_t offset, unsigned char* dst, size_t len);
int lms_verify_stream(const unsigned char* pub, size_t plen, lms_read_message read,
                      void* user, size_t len, const unsigned char* sig, size_t slen);
int lms_verify(const unsigned char* pub, size_t plen, const void* msg, size_t len,
               const unsigned char* sig, size_t slen);
#endif
