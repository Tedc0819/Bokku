//
//  StoryPart.m
//  bokku
//
//  Created by Ted Cheng on 19/10/13.
//  Copyright (c) 2013 Ted Cheng. All rights reserved.
//

#import "StoryPart.h"

NSString *const StoryPartStoreKey = @"StoryPartStoreKey";

@implementation StoryPart

+ (void)getStoryPartsByIDs:(NSArray *)IDs withCompletion:(void(^)(NSArray *storyParts)) completion
{
    NSMutableString *params = [[NSMutableString alloc] init];
    [IDs enumerateObjectsUsingBlock:^(NSNumber *number, NSUInteger idx, BOOL *stop) {
    if (params.length != 0) [params appendString:@"&"];
        [params appendString:[NSString stringWithFormat:@"ids[]=%@", number.stringValue]];
    }];

    NSString *urlString = [NSString stringWithFormat:@"http://bokkuapi.herokuapp.com/api/story_parts?%@", params];
    [self getObjectsFromURL:[NSURL URLWithString:urlString] ParsingKeyPath:@[@"story_parts"] Completion:^(NSArray *objects) {
        completion(objects);
    }];
}

#pragma mark - storable protocolgg

- (NSString *)storableKey
{
    return ((NSNumber *)self.objID).stringValue;
}

- (NSDictionary *)storableContentDictionary
{
    return @{};
}

- (void)cacheStorable
{
    [[TCStoreManager sharedManager] storeObject:self ToStoreWithKey:StoryPartStoreKey];
}

- (NSString *)description
{
    return ((NSNumber *)self.objID).stringValue;
}

@end
