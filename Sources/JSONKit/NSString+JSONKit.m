#import "NSString+JSONKit.h"
#import "JSONKit.h"

@implementation NSString (JSONKit)

- (id)objectFromJSONStringWithParseOptions:(JKParseOptionFlags)parseOptionFlags {
    return [self objectFromJSONStringWithParseOptions:parseOptionFlags error:NULL];
}

- (id)objectFromJSONStringWithParseOptions:(JKParseOptionFlags)parseOptionFlags error:(NSError **)error {
    JSONDecoder *decoder = [[JSONDecoder alloc] initWithParseOptions:parseOptionFlags];
    id result = [decoder objectWithData:[self dataUsingEncoding:NSUTF8StringEncoding] error:error];
    return result;
}

@end 