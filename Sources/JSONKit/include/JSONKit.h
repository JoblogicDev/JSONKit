// ARC-Compatible JSONKit.h
// Original code mostly ARC-safe, no manual memory management here.
#ifndef _JSONKIT_H_
#define _JSONKIT_H_

#import <Foundation/Foundation.h>
#import <JSONKit/NSString+JSONKit.h>

typedef NSUInteger JKFlags;

enum {
    JKParseOptionNone                     = 0,
    JKParseOptionStrict                   = 0,
    JKParseOptionComments                 = (1 << 0),
    JKParseOptionUnicodeNewlines          = (1 << 1),
    JKParseOptionLooseUnicode             = (1 << 2),
    JKParseOptionPermitTextAfterValidJSON = (1 << 3),
    JKParseOptionMutableContainers        = (1 << 4),
    JKParseOptionMutableLeaves            = (1 << 5),
    JKParseOptionValidFlags               = (JKParseOptionComments | JKParseOptionUnicodeNewlines | JKParseOptionLooseUnicode | JKParseOptionPermitTextAfterValidJSON | JKParseOptionMutableContainers | JKParseOptionMutableLeaves),
};
typedef JKFlags JKParseOptionFlags;

enum {
    JKSerializeOptionNone                 = 0,
    JKSerializeOptionPretty               = (1 << 0),
    JKSerializeOptionEscapeUnicode        = (1 << 1),
    JKSerializeOptionEscapeForwardSlashes = (1 << 4),
    JKSerializeOptionValidFlags           = (JKSerializeOptionPretty | JKSerializeOptionEscapeUnicode | JKSerializeOptionEscapeForwardSlashes),
};
typedef JKFlags JKSerializeOptionFlags;

@interface JSONDecoder : NSObject
+ (instancetype)decoder;
+ (instancetype)decoderWithParseOptions:(JKParseOptionFlags)parseOptionFlags;
- (instancetype)initWithParseOptions:(JKParseOptionFlags)parseOptionFlags;
- (void)clearCache;
- (id)objectWithUTF8String:(const unsigned char *)string length:(NSUInteger)length;
- (id)objectWithUTF8String:(const unsigned char *)string length:(NSUInteger)length error:(NSError **)error;
- (id)objectWithData:(NSData *)jsonData;
- (id)objectWithData:(NSData *)jsonData error:(NSError **)error;

// Convenience methods
+ (id)objectFromJSONString:(NSString *)jsonString;
+ (id)objectFromJSONString:(NSString *)jsonString error:(NSError **)error;
+ (id)objectFromJSONStringWithParseOptions:(JKParseOptionFlags)parseOptionFlags string:(NSString *)jsonString;
+ (id)objectFromJSONStringWithParseOptions:(JKParseOptionFlags)parseOptionFlags string:(NSString *)jsonString error:(NSError **)error;
- (id)objectFromJSONString:(NSString *)jsonString;
- (id)objectFromJSONString:(NSString *)jsonString error:(NSError **)error;
- (id)objectFromJSONStringWithParseOptions:(JKParseOptionFlags)parseOptionFlags;
- (id)objectFromJSONStringWithParseOptions:(JKParseOptionFlags)parseOptionFlags error:(NSError **)error;
- (NSArray *)arrayFromJSONString:(NSString *)jsonString;
- (NSArray *)arrayFromJSONString:(NSString *)jsonString error:(NSError **)error;
- (NSDictionary *)dictionaryFromJSONString:(NSString *)jsonString;
- (NSDictionary *)dictionaryFromJSONString:(NSString *)jsonString error:(NSError **)error;
@end

@interface JSONEncoder : NSObject
+ (instancetype)encoder;
+ (instancetype)encoderWithSerializeOptions:(JKSerializeOptionFlags)serializeOptionFlags;
- (instancetype)initWithSerializeOptions:(JKSerializeOptionFlags)serializeOptionFlags;
- (NSData *)dataWithObject:(id)object;
- (NSData *)dataWithObject:(id)object error:(NSError **)error;
- (NSString *)stringWithObject:(id)object;
- (NSString *)stringWithObject:(id)object error:(NSError **)error;
- (NSString *)JSONStringFromObject:(id)object;
- (NSString *)JSONStringFromObject:(id)object error:(NSError **)error;
@end

#endif // _JSONKIT_H_
