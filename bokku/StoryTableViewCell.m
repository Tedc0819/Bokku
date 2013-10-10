//
//  StoryTableViewCell.m
//  bokku
//
//  Created by Ted Cheng on 10/10/13.
//  Copyright (c) 2013 Ted Cheng. All rights reserved.
//

#import "StoryTableViewCell.h"
#import "Story.h"

@implementation StoryTableViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setToDefaultView
{
    [self.textLabel setText:@""];
}

- (void)updateWithJsonObject:(TCJsonObject *)jsonObject
{
    [super updateWithJsonObject:jsonObject];
    
    Story *tmpStory = (Story *)jsonObject;
    [self.textLabel setText:tmpStory.title];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/

@end
