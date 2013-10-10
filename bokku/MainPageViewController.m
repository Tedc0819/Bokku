//
//  MainPageViewController.m
//  bokku
//
//  Created by Ted Cheng on 10/10/13.
//  Copyright (c) 2013 Ted Cheng. All rights reserved.
//

#import "MainPageViewController.h"
#import "Story.h"
#import "StoryTableViewCell.h"

@interface MainPageViewController ()

@end

@implementation MainPageViewController

- (void)refresh
{
    [Story getFeaturedStoriesWithCompletion:^(NSArray *stories) {
        [self.segmentingManager setItems:(stories ? stories : @[]) ForIndex:0];
        [self.tableView reloadData];
    }];
    [Story getFeaturedStoriesWithCompletion:^(NSArray *stories) {
        [self.segmentingManager setItems:(stories ? stories : @[]) ForIndex:1];
    }];
    [Story getFeaturedStoriesWithCompletion:^(NSArray *stories) {
        [self.segmentingManager setItems:(stories ? stories : @[]) ForIndex:2];
    }];
}

- (NSUInteger)numberOfSegmentedButtons
{
    return 3;
}

- (CGFloat)numberOfButtonDisplay
{
    return 3;
}

- (NSArray *)buttonTitles
{
    return @[@"Featured", @"Hit", @"New"];
}

@end
