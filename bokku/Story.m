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

- (id)init
{
    self = [super init];
    if (self) {
        self.likeStatus = StoryLikeStatusNormal;
    }
    return self;
}

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

- (void)loadStoryPartWithIndex:(NSInteger)index withCompletion:(void(^)(NSArray *relatedParts, StoryPart *storyPart))completion
{
    NSNumber *indexedStoryPartID = self.storyPartIds[index];
    StoryPart *storyPart = [[TCStoreManager sharedManager] objectWithKey:indexedStoryPartID.stringValue inStoreWithKey:StoryPartStoreKey];
    if (storyPart) {
        NSLog(@"From local , part id = %@", indexedStoryPartID);
        completion(nil, storyPart);
        return;
    }
    
    NSInteger location = index - StoryPartBuffer < 0 ? 0 : index - StoryPartBuffer;
    NSInteger length = location + StoryPartBuffer * 2 > self.storyPartIds.count - 1 ? self.storyPartIds.count - location : StoryPartBuffer * 2 + 1;
    NSArray *storyPartIDs = [self.storyPartIds subarrayWithRange:NSMakeRange(location, length)];
    __block NSInteger target = [storyPartIDs indexOfObject:indexedStoryPartID];
    [StoryPart getStoryPartsByIDs:storyPartIDs withCompletion:^(NSArray *storyParts) {
        [storyParts enumerateObjectsUsingBlock:^(StoryPart *part, NSUInteger idx, BOOL *stop) {
            [part cacheStorable];
            NSLog(@"%@", [TCStoreManager sharedManager].description);
        }];
        NSLog(@"From server , part id = %@", indexedStoryPartID);
        completion(storyParts, storyParts[target]);
    }];
}

- (NSUInteger)maxPage
{
    return self.storyPartIds.count - 1;
}

@end
