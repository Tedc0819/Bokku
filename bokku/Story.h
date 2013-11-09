//
//  Story.h
//  bokku
//
//  Created by Ted Cheng on 10/10/13.
//  Copyright (c) 2013 Ted Cheng. All rights reserved.
//

#import "TCJsonObject.h"
#import "Author.h"
#import "StoryPart.h"

#define StoryPartBuffer 4

typedef enum {
    StoryLikeStatusDislike = -1,
    StoryLikeStatusNormal,
    StoryLikeStatusLike
} StoryLikeStatus;

@interface Story : TCJsonObject<TCStorable>

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) Author *author;
@property (nonatomic, strong) NSArray *storyPartIds;
@property (nonatomic, strong) NSDictionary *stats;

@property (nonatomic, assign) StoryLikeStatus likeStatus;

+ (void)getFeaturedStoriesWithCompletion:(void(^)(NSArray *stories))completion;
- (void)loadStoryPartWithIndex:(NSInteger)index withCompletion:(void(^)(NSArray *relatedParts, StoryPart *storyPart))completion;

- (NSUInteger)maxPage;
- (void)bookmark;


@end
