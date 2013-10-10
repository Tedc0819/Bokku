//
//  RandomStoryViewController.m
//  bokku
//
//  Created by Ted Cheng on 10/10/13.
//  Copyright (c) 2013 Ted Cheng. All rights reserved.
//

#import "RandomStoryViewController.h"

@interface RandomStoryViewController ()

@end

@implementation RandomStoryViewController

- (void)refresh
{
    
}

- (BOOL)segmentedControlButtonsShouldShow
{
    return NO;
}

- (void)tabBarController:(UITabBarController *)tabBarController didSelectViewController:(UIViewController *)viewController
{
    if (((UINavigationController *)viewController).topViewController == self) {
        NSLog(@"halo");
    }
}

//- (NSUInteger)numberOfSegmentedButtons
//{
//    return 1;
//}
//
//- (CGFloat)numberOfButtonDisplay
//
//{
//    return 1;
//}
//
//- (NSArray *)buttonTitles
//{
//    return @[@"Favorite", @"History", @"Vote"];
//}

@end
