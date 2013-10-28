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
    [self getObjectsFromURL:[NSURL URLWithString:@"http://bokkuapi.herokuapp.com/api/stories/81"] ParsingKeyPath:@[@"stroy_parts"] Completion:^(NSArray *objects) {
        completion(objects);
    }];
}

+ (void)getStoryPartsByID:(NSNumber *)storyPartID withCompletion:(void (^)(StoryPart *storyPart))completion
{
    
}

#pragma mark - storable protocol

- (NSString *)storableKey
{
    return self.objID;
}

- (NSDictionary *)storableContentDictionary
{
    return @{};
}

- (void)cacheStorable
{
    [[TCStoreManager sharedManager] storeObject:self ToStoreWithKey:StoryPartStoreKey];
}

@end
