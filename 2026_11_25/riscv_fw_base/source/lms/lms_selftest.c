#include "lms.h"
#include "lms_selftest.h"
#include "lms_selftest_vector.h"
#include "lms_benchmark_vectors.h"
#include <string.h>

int lms_verify_selftest_timed(uint64_t (*read_ticks)(void), uint64_t *verification_ticks)
{
    unsigned char modified_message[sizeof lms_test_message];
    unsigned char modified_public_key[sizeof lms_test_public_key];
    uint64_t start_ticks = 0;
    int verified;

    if ((read_ticks == NULL) != (verification_ticks == NULL))
        return 0;

    if (read_ticks != NULL)
        start_ticks = read_ticks();
    verified = lms_verify(lms_test_public_key, sizeof lms_test_public_key,
                    lms_test_message, sizeof lms_test_message,
                    lms_test_signature, sizeof lms_test_signature);
    if (read_ticks != NULL)
        *verification_ticks = read_ticks() - start_ticks;
    if (!verified)
        return 0;

    memcpy(modified_message, lms_test_message, sizeof modified_message);
    modified_message[0] ^= 1;
    if (lms_verify(lms_test_public_key, sizeof lms_test_public_key,
                   modified_message, sizeof modified_message,
                   lms_test_signature, sizeof lms_test_signature))
        return 0;

    memcpy(modified_public_key, lms_test_public_key, sizeof modified_public_key);
    modified_public_key[sizeof modified_public_key - 1] ^= 1;
    if (lms_verify(modified_public_key, sizeof modified_public_key,
                   lms_test_message, sizeof lms_test_message,
                   lms_test_signature, sizeof lms_test_signature))
        return 0;

    if (lms_verify(lms_test_public_key, sizeof lms_test_public_key,
                   lms_test_message, sizeof lms_test_message,
                   lms_test_signature, sizeof lms_test_signature - 1))
        return 0;

    return 1;
}

int lms_verify_selftest(void)
{
    return lms_verify_selftest_timed(NULL, NULL);
}

int lms_verify_benchmark(uint64_t (*read_ticks)(void),
                         void (*report)(const lms_benchmark_result *result))
{
    size_t index;
    int all_passed = 1;

    if (read_ticks == NULL)
        return 0;

    for (index = 0; index < sizeof lms_benchmark_vectors / sizeof lms_benchmark_vectors[0]; index++) {
        const lms_benchmark_vector *vector = &lms_benchmark_vectors[index];
        lms_benchmark_result result;
        unsigned int repetition;

        result.height = vector->height;
        result.width = vector->width;
        result.repetitions = 0;
        result.message_bytes = sizeof lms_benchmark_message;
        result.signature_bytes = vector->signature_bytes;
        result.minimum_ticks = UINT64_MAX;
        result.maximum_ticks = 0;
        result.total_ticks = 0;
        result.verified = 1;
        result.timer_valid = 1;

        for (repetition = 0; repetition < LMS_BENCHMARK_REPETITIONS; repetition++) {
            uint64_t start_ticks = read_ticks();
            int verified = lms_verify(vector->public_key, LMS_PUBLIC_BYTES,
                                      lms_benchmark_message, sizeof lms_benchmark_message,
                                      vector->signature, vector->signature_bytes);
            uint64_t elapsed = read_ticks() - start_ticks;

            result.repetitions++;
            result.total_ticks += elapsed;
            if (elapsed < result.minimum_ticks)
                result.minimum_ticks = elapsed;
            if (elapsed > result.maximum_ticks)
                result.maximum_ticks = elapsed;
            if (elapsed == 0)
                result.timer_valid = 0;
            if (!verified) {
                result.verified = 0;
                break;
            }
        }

        if (!result.verified || !result.timer_valid)
            all_passed = 0;
        if (report != NULL)
            report(&result);
    }

    return all_passed;
}