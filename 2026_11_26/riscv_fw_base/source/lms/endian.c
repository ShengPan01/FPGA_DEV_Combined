/* Adapted from Cisco endian.c; see LICENSE-Cisco.txt. */
#include "endian.h"
void put_bigendian(void* target, unsigned long long value, size_t bytes)
{
  unsigned char* b = target;
  while (bytes) {
    b[--bytes] = (unsigned char)value;
    value >>= 8;
  }
}
unsigned long long get_bigendian(const void* target, size_t bytes)
{
  const unsigned char* b = target;
  unsigned long long value = 0;
  while (bytes--) value = (value << 8) | *b++;
  return value;
}
