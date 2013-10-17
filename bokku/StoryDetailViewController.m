//
//  StoryDetailViewController.m
//  bokku
//
//  Created by Ted Cheng on 10/10/13.
//  Copyright (c) 2013 Ted Cheng. All rights reserved.
//

#import "StoryDetailViewController.h"
#import "NSString+FontAwesome.h"

@interface StoryDetailViewController()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *specialZone;

@property (nonatomic, strong) UITableViewCell *thumbnailCell;
@property (nonatomic, strong) UITableViewCell *storyDescriptionCell;
@property (nonatomic, strong) UITableViewCell *questionCell;

@property (nonatomic, strong) UILabel *descriptionLabel;
@property (nonatomic, strong) UILabel *questionLabel;

@end

@implementation StoryDetailViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        self.tableView = [[UITableView alloc] init];
        [self.tableView setDataSource:self];
        [self.tableView setDelegate:self];
        self.tableView.tableFooterView = [[UIView alloc] init];
        self.specialZone = [[UIView alloc] init];
        [self.specialZone setBackgroundColor:[UIColor greenColor]];
        [self setTitle:@"我在看首你"];
        [self.descriptionLabel setText:@"「你在哪？」穿著白色連身長裙的少女惶惑地叫喊著。孤單的身影漫無目的地在漆黑中，像在逃避似地奔跑。「噠！噠！噠！噠……」帶著水點的腳踏聲追隨著她纖細的雙腿，長至肩膀的黑髮亦隨著步伐左右搖曳。\n\n踏步的聲音漸漸緩下來，由小跑步變成踱步。少女一邊走，一邊左右掃視著，她下意識地撅著嘴，苦笑著向著空氣發嘮叨：「每次也是這樣！你不會悶啊！」沒有東西回應她。\n\n她眉頭一鎖，把原本可愛的面容都收起了：「出來吧！不要再玩了！」徬徨的叫聲在這個鬼地方回響著，似在嘲笑她一樣。 "];
        [self.questionLabel setText:@"究竟嘲笑她的，是甚麼呢？"];
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
    [self.specialZone setFrame:CGRectMake(0, self.view.frame.size.height - specialZoneHeight, self.view.frame.size.width, specialZoneHeight)];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *array = @[self.thumbnailCell, self.storyDescriptionCell, self.questionCell];
    return array[indexPath.row];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSArray *array = @[@150, @([self descriptionLabelSize].height + 20), @([self questionLabelSize].height + 25)];
    return (((NSNumber *)array[indexPath.row]).floatValue);
}

#pragma mark - target

- (void)forwardButtonDidClick:(UIButton *)button
{
    NSLog(@"button = %@", button);
}

- (void)reverseButtonDidClick:(UIButton *)button
{
    NSLog(@"button = %@", button);
}

- (void)favButtonDidClick:(UIButton *)button
{
    NSLog(@"button = %@", button);
}

- (void)listButtonDidClick:(UIButton *)button
{
    NSLog(@"button = %@", button);
}

#pragma mark - lazy loading

- (UITableViewCell *)thumbnailCell
{
    if (!_thumbnailCell) {
        _thumbnailCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ThumbnailCell"];
        [_thumbnailCell setSelectionStyle:UITableViewCellSelectionStyleNone];
        [_thumbnailCell setFrame:CGRectMake(0, 0, self.view.frame.size.width, 150)];
        
        UIImageView *thumbnailView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width * 0.75, self.view.frame.size.width * 0.75 * (9.0 /16.0))];
        [thumbnailView setCenter:CGPointMake(CGRectGetMidX(_thumbnailCell.bounds), CGRectGetMidY(_thumbnailCell.bounds))];
        [thumbnailView setImage:[UIImage imageNamed:@"demoThumbnail.jpg"]];
        [thumbnailView setBackgroundColor:[UIColor blackColor]];
        [_thumbnailCell.contentView addSubview:thumbnailView];
        
        UIButton *reverseButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 25, 35, 50)];
        [reverseButton setTitle:[NSString fontAwesomeIconStringForEnum:FAIconBackward] forState:UIControlStateNormal];
        [reverseButton addTarget:self action:@selector(reverseButtonDidClick:) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton *favButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 75, 35, 50)];
        [favButton setTitle:[NSString fontAwesomeIconStringForEnum:FAIconBookmark] forState:UIControlStateNormal];
        [favButton addTarget:self action:@selector(favButtonDidClick:) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton *forwardButton = [[UIButton alloc] initWithFrame:CGRectMake(self.view.bounds.size.width - 35, 25, 35, 50)];
        [forwardButton setTitle:[NSString fontAwesomeIconStringForEnum:FAIconForward] forState:UIControlStateNormal];
        [forwardButton addTarget:self action:@selector(forwardButtonDidClick:) forControlEvents:UIControlEventTouchUpInside];
        
        UIButton *listButton = [[UIButton alloc] initWithFrame:CGRectMake(self.view.bounds.size.width - 35, 75, 35, 50)];
        [listButton setTitle:[NSString fontAwesomeIconStringForEnum:FAIconList] forState:UIControlStateNormal];
        [listButton addTarget:self action:@selector(listButtonDidClick:) forControlEvents:UIControlEventTouchUpInside];
        
        [@[reverseButton, favButton, forwardButton, listButton] enumerateObjectsUsingBlock:^(UIButton *button, NSUInteger idx, BOOL *stop) {
            [button.titleLabel setFont:[UIFont fontWithName:kFontAwesomeFamilyName size:12]];
            [button setTitleColor:[UIColor colorWithHex:@"#95a5a6" alpha:1] forState:UIControlStateNormal];
            [button setBackgroundColor:[UIColor colorWithHex:@"#ecf0f1" alpha:1] forState:UIControlStateNormal];
            [_thumbnailCell.contentView addSubview:button];
        }];
        
    }
    return _thumbnailCell;
}

- (CGSize)descriptionLabelSize
{
    CGRect labelSize = [self.descriptionLabel.text boundingRectWithSize:CGSizeMake(self.view.bounds.size.width - 20 * 2, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.descriptionLabel.font} context:nil];

    return labelSize.size;
}

- (CGSize)questionLabelSize
{
    CGRect labelSize = [self.questionLabel.text boundingRectWithSize:CGSizeMake(self.view.bounds.size.width - 28 * 2, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:self.questionLabel.font} context:nil];
    
    return labelSize.size;
}

- (UITableViewCell *)storyDescriptionCell
{
    if (!_storyDescriptionCell) {
        _storyDescriptionCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"DescriptionCell"];
        [_storyDescriptionCell setSelectionStyle:UITableViewCellSelectionStyleNone];
        [_storyDescriptionCell addSubview:self.descriptionLabel];
    }
    
    CGSize labelSize = [self descriptionLabelSize];
    [self.descriptionLabel setFrame:CGRectMake(20, 10, labelSize.width, labelSize.height)];
//    self.descriptionCellHeight = CGRectGetMaxY(self.descriptionLabel.frame) + 20;
    return _storyDescriptionCell;
}

- (UITableViewCell *)questionCell
{
    if (!_questionCell) {
        _questionCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"QuestionCell"];
        [_questionCell setSelectionStyle:UITableViewCellSelectionStyleNone];
        [_questionCell addSubview:self.questionLabel];
    }
    
    CGSize labelSize = [self questionLabelSize];
    [self.questionLabel setFrame:CGRectMake(28, 12.5, labelSize.width, labelSize.height)];
    
    return _questionCell;
}

- (UILabel *)descriptionLabel
{
    if (!_descriptionLabel) {
        _descriptionLabel = [[UILabel alloc] init];
        [_descriptionLabel setBackgroundColor:[UIColor clearColor]];
        [_descriptionLabel setNumberOfLines:0];
    }
    return _descriptionLabel;
}

- (UILabel *)questionLabel
{
    if (!_questionLabel) {
        _questionLabel = [[UILabel alloc] init];
        [_questionLabel setBackgroundColor:[UIColor clearColor]];
        [_questionLabel setNumberOfLines:0];
    }
    return _questionLabel;
}

@end
