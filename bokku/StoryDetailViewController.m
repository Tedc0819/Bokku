//
//  StoryDetailViewController.m
//  bokku
//
//  Created by Ted Cheng on 10/10/13.
//  Copyright (c) 2013 Ted Cheng. All rights reserved.
//

#import "StoryDetailViewController.h"

@interface StoryDetailViewController ()

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *specialZone;

@end

@implementation StoryDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.tableView = [[UITableView alloc] init];
        self.specialZone = [[UIView alloc] init];
        [self.specialZone setBackgroundColor:[UIColor greenColor]];
    }
    return self;
}

- (BOOL)hidesBottomBarWhenPushed
{
    return YES;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.view addSubview:self.tableView];
    [self.view addSubview:self.specialZone];
	// Do any additional setup after loading the view.
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    CGFloat specialZoneHeight = 50;
    [self.tableView setFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - specialZoneHeight)];
    [self.specialZone setFrame:CGRectMake(0, CGRectGetMaxY(self.tableView.frame), self.view.frame.size.width, specialZoneHeight)];
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
