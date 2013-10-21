//
//  CustomJsonObjectTableViewController.m
//  bokku
//
//  Created by Ted Cheng on 10/10/13.
//  Copyright (c) 2013 Ted Cheng. All rights reserved.
//

#import "CustomJsonObjectTableViewController.h"
#import "Story.h"
#import "StoryDetailViewController.h"

@interface CustomJsonObjectTableViewController ()

@end

@implementation CustomJsonObjectTableViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self refresh];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    TCJsonObject *item = self.segmentingManager.currentItems[indexPath.row];
    if ([item isKindOfClass:[Story class]]) {
        StoryDetailViewController *detailViewController = [[StoryDetailViewController alloc] initWithStory:(Story *)item];
        [self.navigationController pushViewController:detailViewController animated:YES];
    }
}

- (void)refresh
{

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (CGFloat)segmentedControlsHeight
{
    return 30;
}

- (NSUInteger)numberOfSegmentedButtons
{
    return 1;
}

- (NSArray *)buttonTitles
{
    return @[@""];
}

- (NSArray *)generateButtons
{
    NSMutableArray *buttons = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < [self numberOfSegmentedButtons] ; i++) {
        UIButton *tmpButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width / [self numberOfButtonDisplay] , self.segmentedControlsHeight)];
        [tmpButton setBackgroundColor:[UIColor colorWithHex:@"#27ae60" alpha:1] forState:UIControlStateNormal];
        [tmpButton setBackgroundColor:[UIColor colorWithHex:@"#16a085" alpha:1] forState:UIControlStateSelected];
        [tmpButton.titleLabel setFont:[UIFont systemFontOfSize:18]];
        
        [tmpButton setTitle:self.buttonTitles[i] forState:UIControlStateNormal];
        [buttons addObject:tmpButton];
    }
    
    return buttons.copy;
}

- (NSString *)cellClassStringForJsonObjectClassString:(NSString *)classString
{
    if ([classString isEqualToString:@"Story"]) {
        return @"StoryTableViewCell";
    }
    return @"TCJsonObjectTableViewCell";
}

- (NSArray *)segmentedControlButtons
{
    if (!_segmentedControlButtons) {
        NSArray *buttons = [self generateButtons];
        _segmentedControlButtons = buttons;
    }
    return _segmentedControlButtons;
}

@end
