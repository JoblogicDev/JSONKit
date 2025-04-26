#ifndef _NSString_JSONKit_h_
#define _NSString_JSONKit_h_

#import <Foundation/Foundation.h>
#import <JSONKit/JSONKit.h>

typedef NSUInteger JKParseOptionFlags;

@interface NSString (JSONKit)

- (id)objectFromJSONStringWithParseOptions:(JKParseOptionFlags)parseOptionFlags;
- (id)objectFromJSONStringWithParseOptions:(JKParseOptionFlags)parseOptionFlags error:(NSError **)error;

@end

#endif // _NSString_JSONKit_h_ 
