#ifndef LMS_SELFTEST_H
#define LMS_SELFTEST_H

#include <stdint.h>
#include <stddef.h>

#ifndef LMS_BENCHMARK_REPETITIONS
#define LMS_BENCHMARK_REPETITIONS 3
#endif

#if LMS_BENCHMARK_REPETITIONS < 1
#error LMS_BENCHMARK_REPETITIONS must be positive
#endif

typedef struct {
	unsigned int height, width, repetitions;
	size_t message_bytes, signature_bytes;
	uint64_t minimum_ticks, maximum_ticks, total_ticks;
	int verified, timer_valid;
} lms_benchmark_result;

int lms_verify_selftest(void);
int lms_verify_selftest_timed(uint64_t (*read_ticks)(void), uint64_t *verification_ticks);
int lms_verify_benchmark(uint64_t (*read_ticks)(void),
						 void (*report)(const lms_benchmark_result *result));

#endif