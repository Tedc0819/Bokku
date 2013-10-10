//
//  CustomJsonObjectTableViewController.h
//  bokku
//
//  Created by Ted Cheng on 10/10/13.
//  Copyright (c) 2013 Ted Cheng. All rights reserved.
//

#import "TCJsonObjectTableViewController.h"

@interface CustomJsonObjectTableViewController : TCJsonObjectTableViewController

@property (nonatomic, strong) NSArray *segmentedControlButtons;

- (NSArray *)generateButtons;
- (NSUInteger)numberOfSegmentedButtons;
- (NSArray *)buttonTitles;


@end
