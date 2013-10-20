//
//  StoryPart.h
//  bokku
//
//  Created by Ted Cheng on 19/10/13.
//  Copyright (c) 2013 Ted Cheng. All rights reserved.
//

#import "TCJsonObject.h"

@interface StoryPart : TCJsonObject

@property (nonatomic, strong) NSString *content;

+ (void)getStoryPartsByIDs:(NSArray *)IDs withCompletion:(void(^)(NSArray *storyParts)) completion;

@end
