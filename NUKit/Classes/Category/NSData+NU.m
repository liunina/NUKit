//
//  NSData+NU.m
//  NUKit
//
//  Created by liu nian on 2019/12/5.
//

#import "NSData+NU.h"

static const char _nlbase64EncodingTable[64] = "ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789+/";
static const short _nlbase64DecodingTable[256] = {
        -2, -2, -2, -2, -2, -2, -2, -2, -2, -1, -1, -2, -1, -1, -2, -2,
        -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,
        -1, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, 62, -2, -2, -2, 63,
        52, 53, 54, 55, 56, 57, 58, 59, 60, 61, -2, -2, -2, -2, -2, -2,
        -2, 0, 1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14,
        15, 16, 17, 18, 19, 20, 21, 22, 23, 24, 25, -2, -2, -2, -2, -2,
        -2, 26, 27, 28, 29, 30, 31, 32, 33, 34, 35, 36, 37, 38, 39, 40,
        41, 42, 43, 44, 45, 46, 47, 48, 49, 50, 51, -2, -2, -2, -2, -2,
        -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,
        -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,
        -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,
        -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,
        -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,
        -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,
        -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2,
        -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2, -2
};

@implementation NSData (NU)

- (NSString *)nl_base64EncodedString {
    const uint8_t *input = self.bytes;
    NSInteger length = self.length;

    NSMutableData *data = [NSMutableData dataWithLength:(NSUInteger) (((length + 2) / 3) * 4)];
    uint8_t *output = (uint8_t *) data.mutableBytes;

    for (NSInteger i = 0; i < length; i += 3) {
        NSInteger value = 0;
        for (NSInteger j = i; j < (i + 3); j++) {
            value <<= 8;

            if (j < length) {
                value |= (0xFF & input[j]);
            }
        }

        NSInteger index = (i / 3) * 4;
        output[index + 0] = (uint8_t) _nlbase64EncodingTable[(value >> 18) & 0x3F];
        output[index + 1] = (uint8_t) _nlbase64EncodingTable[(value >> 12) & 0x3F];
        output[index + 2] = (uint8_t) ((i + 1) < length ? _nlbase64EncodingTable[(value >> 6) & 0x3F] : '=');
        output[index + 3] = (uint8_t) ((i + 2) < length ? _nlbase64EncodingTable[(value >> 0) & 0x3F] : '=');
    }

    return [[NSString alloc] initWithData:data encoding:NSASCIIStringEncoding];
}

// Adapted from http://www.cocoadev.com/index.pl?BaseSixtyFour
+ (NSData *)nl_dataWithBase64String:(NSString *)base64String {
    const char *string = [base64String cStringUsingEncoding:NSASCIIStringEncoding];
    NSInteger inputLength = base64String.length;

    if (string == NULL/* || inputLength % 4 != 0*/) {
        return nil;
    }

    while (inputLength > 0 && string[inputLength - 1] == '=') {
        inputLength--;
    }

    NSInteger outputLength = inputLength * 3 / 4;
    NSMutableData *data = [NSMutableData dataWithLength:(NSUInteger) outputLength];
    uint8_t *output = data.mutableBytes;

    NSInteger inputPoint = 0;
    NSInteger outputPoint = 0;
    while (inputPoint < inputLength) {
        char i0 = string[inputPoint++];
        char i1 = string[inputPoint++];
        char i2 = inputPoint < inputLength ? string[inputPoint++] : 'A'; /* 'A' will decode to \0 */
        char i3 = inputPoint < inputLength ? string[inputPoint++] : 'A';

        output[outputPoint++] = (uint8_t) ((_nlbase64DecodingTable[i0] << 2) | (_nlbase64DecodingTable[i1] >> 4));
        if (outputPoint < outputLength) {
            output[outputPoint++] = (uint8_t) (((_nlbase64DecodingTable[i1] & 0xf) << 4) | (_nlbase64DecodingTable[i2] >> 2));
        }
        if (outputPoint < outputLength) {
            output[outputPoint++] = (uint8_t) (((_nlbase64DecodingTable[i2] & 0x3) << 6) | _nlbase64DecodingTable[i3]);
        }
    }

    return data;
}
@end
