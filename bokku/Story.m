//
//  Story.m
//  bokku
//
//  Created by Ted Cheng on 10/10/13.
//  Copyright (c) 2013 Ted Cheng. All rights reserved.
//

#import "Story.h"

@implementation Story

+ (void)getFeaturedStoriesWithCompletion:(void(^)(NSArray *stories))completion
{
    [self getObjectsFromURL:[NSURL URLWithString:@"http://bokkuapi.herokuapp.com/api/stories"] ParsingKeyPath:@[@"stories"] Completion:^(NSArray *objects) {
        completion(objects);
    }];
}

@end