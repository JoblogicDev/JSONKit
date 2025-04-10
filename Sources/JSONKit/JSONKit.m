// ARC-Compatible JSONKit.m

#import "JSONKit.h"

// Private interfaces
@interface JSONDecoder ()
@property (nonatomic, assign) JKParseOptionFlags parseOptionFlags;
@end

@interface JSONEncoder ()
@property (nonatomic, assign) JKSerializeOptionFlags serializeOptionFlags;
@end

@implementation JSONDecoder

+ (instancetype)decoder {
    return [[self alloc] init];
}

+ (instancetype)decoderWithParseOptions:(JKParseOptionFlags)parseOptionFlags {
    return [[self alloc] initWithParseOptions:parseOptionFlags];
}

- (instancetype)init {
    return [self initWithParseOptions:JKParseOptionStrict];
}

- (instancetype)initWithParseOptions:(JKParseOptionFlags)parseOptionFlags {
    if ((self = [super init])) {
        _parseOptionFlags = parseOptionFlags;
    }
    return self;
}

- (void)clearCache {
    // No cache to clear in this implementation
}

// Convenience methods for NSString
- (id)objectFromJSONString:(NSString *)jsonString {
    return [self objectFromJSONString:jsonString error:NULL];
}

- (id)objectFromJSONString:(NSString *)jsonString error:(NSError **)error {
    NSData *jsonData = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    return [self objectWithData:jsonData error:error];
}

- (id)objectFromJSONStringWithParseOptions:(JKParseOptionFlags)parseOptionFlags {
    return [self objectFromJSONStringWithParseOptions:parseOptionFlags error:NULL];
}

- (id)objectFromJSONStringWithParseOptions:(JKParseOptionFlags)parseOptionFlags error:(NSError **)error {
    // This method should be called on a NSString instance, not JSONDecoder
    // So we need to get the string from somewhere else
    // This implementation is incorrect and should be removed
    return nil;
}

+ (id)objectFromJSONString:(NSString *)jsonString {
    return [self objectFromJSONString:jsonString error:NULL];
}

+ (id)objectFromJSONString:(NSString *)jsonString error:(NSError **)error {
    return [self objectFromJSONString:jsonString error:error];
}

+ (id)objectFromJSONStringWithParseOptions:(JKParseOptionFlags)parseOptionFlags string:(NSString *)jsonString {
    return [self objectFromJSONStringWithParseOptions:parseOptionFlags string:jsonString error:NULL];
}

+ (id)objectFromJSONStringWithParseOptions:(JKParseOptionFlags)parseOptionFlags string:(NSString *)jsonString error:(NSError **)error {
    JSONDecoder *decoder = [self decoderWithParseOptions:parseOptionFlags];
    return [decoder objectFromJSONString:jsonString error:error];
}

// Original JSONKit methods
- (id)objectWithUTF8String:(const unsigned char *)string length:(NSUInteger)length {
    return [self objectWithUTF8String:string length:length error:NULL];
}

- (id)objectWithUTF8String:(const unsigned char *)string length:(NSUInteger)length error:(NSError **)error {
    NSData *data = [NSData dataWithBytes:string length:length];
    return [self objectWithData:data error:error];
}

- (id)objectWithData:(NSData *)jsonData {
    return [self objectWithData:jsonData error:NULL];
}

- (id)objectWithData:(NSData *)jsonData error:(NSError **)error {
    NSJSONReadingOptions options = 0;
    if (_parseOptionFlags & JKParseOptionMutableContainers) {
        options |= NSJSONReadingMutableContainers;
    }
    if (_parseOptionFlags & JKParseOptionMutableLeaves) {
        options |= NSJSONReadingMutableLeaves;
    }
    
    return [NSJSONSerialization JSONObjectWithData:jsonData options:options error:error];
}

// Additional convenience methods
- (NSArray *)arrayFromJSONString:(NSString *)jsonString {
    return [self arrayFromJSONString:jsonString error:NULL];
}

- (NSArray *)arrayFromJSONString:(NSString *)jsonString error:(NSError **)error {
    id object = [self objectFromJSONString:jsonString error:error];
    return [object isKindOfClass:[NSArray class]] ? object : nil;
}

- (NSDictionary *)dictionaryFromJSONString:(NSString *)jsonString {
    return [self dictionaryFromJSONString:jsonString error:NULL];
}

- (NSDictionary *)dictionaryFromJSONString:(NSString *)jsonString error:(NSError **)error {
    id object = [self objectFromJSONString:jsonString error:error];
    return [object isKindOfClass:[NSDictionary class]] ? object : nil;
}

@end

@implementation JSONEncoder

+ (instancetype)encoder {
    return [[self alloc] init];
}

+ (instancetype)encoderWithSerializeOptions:(JKSerializeOptionFlags)serializeOptionFlags {
    return [[self alloc] initWithSerializeOptions:serializeOptionFlags];
}

- (instancetype)init {
    return [self initWithSerializeOptions:JKSerializeOptionNone];
}

- (instancetype)initWithSerializeOptions:(JKSerializeOptionFlags)serializeOptionFlags {
    if ((self = [super init])) {
        _serializeOptionFlags = serializeOptionFlags;
    }
    return self;
}

// Original JSONKit methods
- (NSData *)dataWithObject:(id)object {
    return [self dataWithObject:object error:NULL];
}

- (NSData *)dataWithObject:(id)object error:(NSError **)error {
    NSJSONWritingOptions options = 0;
    if (_serializeOptionFlags & JKSerializeOptionPretty) {
        options |= NSJSONWritingPrettyPrinted;
    }
    
    return [NSJSONSerialization dataWithJSONObject:object options:options error:error];
}

- (NSString *)stringWithObject:(id)object {
    return [self stringWithObject:object error:NULL];
}

- (NSString *)stringWithObject:(id)object error:(NSError **)error {
    NSData *data = [self dataWithObject:object error:error];
    if (!data) {
        return nil;
    }
    return [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
}

// Additional convenience methods
- (NSString *)JSONStringFromObject:(id)object {
    return [self stringWithObject:object];
}

- (NSString *)JSONStringFromObject:(id)object error:(NSError **)error {
    return [self stringWithObject:object error:error];
}

@end
