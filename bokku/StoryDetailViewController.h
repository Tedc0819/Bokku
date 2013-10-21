//
//  StoryDetailViewController.h
//  bokku
//
//  Created by Ted Cheng on 10/10/13.
//  Copyright (c) 2013 Ted Cheng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Story.h"

@interface StoryDetailViewController : UIViewController

- (id)initWithStory:(Story *)story;

@property (nonatomic, strong) Story *story;

@end
