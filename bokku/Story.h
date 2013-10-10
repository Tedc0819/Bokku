//
//  Story.h
//  bokku
//
//  Created by Ted Cheng on 10/10/13.
//  Copyright (c) 2013 Ted Cheng. All rights reserved.
//

#import "TCJsonObject.h"

@interface Story : TCJsonObject

@property (nonatomic, strong) NSString *title;

+ (void)getFeaturedStoriesWithCompletion:(void(^)(NSArray *stories))completion;

@end
