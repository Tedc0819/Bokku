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

@interface Story : TCJsonObject<TCStorable>

@property (nonatomic, strong) NSString *title;
@property (nonatomic, strong) Author *author;
@property (nonatomic, strong) NSArray *storyPartIds;
@property (nonatomic, strong) NSDictionary *stats;

+ (void)getFeaturedStoriesWithCompletion:(void(^)(NSArray *stories))completion;
- (void)loadStoryPartWithID:(NSNumber *)storyPartID withCompletion:(void(^)(StoryPart *storyPart))completion;

@end
