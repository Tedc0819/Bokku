//
//  Story.m
//  bokku
//
//  Created by Ted Cheng on 10/10/13.
//  Copyright (c) 2013 Ted Cheng. All rights reserved.
//

#import "Story.h"
#import "TCStoreManager.h"

@implementation Story

+ (void)getFeaturedStoriesWithCompletion:(void(^)(NSArray *stories))completion
{
    [self getObjectsFromURL:[NSURL URLWithString:@"http://bokkuapi.herokuapp.com/api/stories"] ParsingKeyPath:@[@"stories"] Completion:^(NSArray *objects) {
        completion(objects);
    }];
}

- (void)getPropertyValuesFromDictionary:(NSDictionary *)dict
{
    self.author = (Author *)[self parsingOwningObjectWithKeyPath:@[@"author"] AsClass:@"Author" FromJsonObjectDictionary:dict];
    [super getPropertyValuesFromDictionary:dict];
}

- (NSDictionary *)mappingDictionary
{
    return @{@"story_part_ids" : @"storyPartIds"};
}

- (void)loadStoryPartWithID:(NSNumber *)storyPartID withCompletion:(void(^)(StoryPart *storyPart))completion
{
    StoryPart *storyPart = [[TCStoreManager sharedManager]objectWithKey:storyPartID.stringValue inStoreWithKey:StoryPartStoreKey];
    if (storyPart) completion(storyPart);
    return;
    
    [StoryPart getStoryPartsByID:storyPartID withCompletion:^(StoryPart *storyPart) {
        if (storyPart) [storyPart cacheStorable];
        completion(storyPart);
    }];
}

@end
