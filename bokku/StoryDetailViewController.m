//
//  StoryDetailViewController.m
//  bokku
//
//  Created by Ted Cheng on 10/10/13.
//  Copyright (c) 2013 Ted Cheng. All rights reserved.
//

#import "StoryDetailViewController.h"
#import "NSString+FontAwesome.h"
#import "ChoiceCell.h"

@interface StoryDetailViewController()<UITableViewDataSource, UITableViewDelegate>

@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UIView *specialZone;

@property (nonatomic, strong) UITableViewCell *thumbnailCell;
@property (nonatomic, strong) UITableViewCell *storyDescriptionCell;
@property (nonatomic, strong) UITableViewCell *questionCell;
@property (nonatomic, strong) ChoiceCell *choiceACell;
@property (nonatomic, strong) ChoiceCell *choiceBCell;
@property (nonatomic, strong) ChoiceCell *choiceCCell;
@property (nonatomic, strong) ChoiceCell *choiceDCell;

@property (nonatomic, strong) NSArray *cells;

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

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self loadStoryPart];
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

- (void)loadStoryPart
{
    [self setTitle:@"我在看首你"];
    [self.storyDescriptionCell.textLabel setText:@"「你在哪？」穿著白色連身長裙的少女惶惑地叫喊著。孤單的身影漫無目的地在漆黑中，像在逃避似地奔跑。「噠！噠！噠！噠……」帶著水點的腳踏聲追隨著她纖細的雙腿，長至肩膀的黑髮亦隨著步伐左右搖曳。\n\n踏步的聲音漸漸緩下來，由小跑步變成踱步。少女一邊走，一邊左右掃視著，她下意識地撅著嘴，苦笑著向著空氣發嘮叨：「每次也是這樣！你不會悶啊！」沒有東西回應她。\n\n她眉頭一鎖，把原本可愛的面容都收起了：「出來吧！不要再玩了！」徬徨的叫聲在這個鬼地方回響著，似在嘲笑她一樣。 "];
    [self.questionCell.textLabel setText:@"究竟嘲笑她的，是甚麼呢？"];
    [self.choiceACell.textLabel setText:@"1. 你好"];
    [self.choiceBCell.textLabel setText:@"2. Omg! 佢係我上司個朋友個朋友個朋友個朋友個朋友個朋友個朋友個朋友個朋友"];
    [self.choiceCCell.textLabel setText:@"3. 你好"];
    [self.choiceDCell.textLabel setText:@"4. 你好"];
    
    [self.tableView reloadData];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 3 + 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return self.cells[indexPath.row];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) return 150;
    
    UITableViewCell *cell = self.cells[indexPath.row];
    CGSize size = [self labelSizeOfLabel:cell.textLabel WithMargin:0];
    return size.height + [self verticalMarginOfCell:cell];
}

- (CGFloat)verticalMarginOfCell:(UITableViewCell *)cell
{
    if (cell == self.questionCell) return 40;
    if (cell == self.storyDescriptionCell) return 10;
    return 25;
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

- (NSArray *)cells
{
    if (!_cells) {
        _cells = @[self.thumbnailCell, self.storyDescriptionCell, self.questionCell, self.choiceACell, self.choiceBCell, self.choiceCCell, self.choiceDCell];
    }
    return _cells;
}

- (ChoiceCell *)newChoiceThumbnailCell
{
    ChoiceCell *cell = [[ChoiceCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ChoiceCell"];
    [cell.textLabel setNumberOfLines: 0];
    
    return cell;
}

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

- (CGSize)labelSizeOfLabel:(UILabel *)label WithMargin:(CGFloat) margin
{
    CGRect labelSize = [label.text boundingRectWithSize:CGSizeMake(self.view.bounds.size.width - margin * 2, 1000) options:NSStringDrawingUsesLineFragmentOrigin attributes:@{NSFontAttributeName:label.font} context:nil];
    
    return labelSize.size;
}

#pragma mark - lazy loading of tableviewcell

- (UITableViewCell *)storyDescriptionCell
{
    if (!_storyDescriptionCell) {
        _storyDescriptionCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"DescriptionCell"];
        [_storyDescriptionCell setSelectionStyle:UITableViewCellSelectionStyleNone];
        [_storyDescriptionCell.textLabel setNumberOfLines:0];
    }
    return _storyDescriptionCell;
}

- (UITableViewCell *)questionCell
{
    if (!_questionCell) {
        _questionCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"QuestionCell"];
        [_questionCell setSelectionStyle:UITableViewCellSelectionStyleNone];
        [_questionCell.textLabel setNumberOfLines:0];
    }
    
    return _questionCell;
}

- (ChoiceCell *)choiceACell
{
    if (!_choiceACell) {
        _choiceACell = [self newChoiceThumbnailCell];
        [_choiceACell setBasicColorHex:@"#e74c3c"];
    }
    return _choiceACell;
}

- (ChoiceCell *)choiceBCell
{
    if (!_choiceBCell) {
        _choiceBCell = [self newChoiceThumbnailCell];
        [_choiceBCell setBasicColorHex:@"#f1c40f"];
    }
    return _choiceBCell;
}

- (ChoiceCell *)choiceCCell
{
    if (!_choiceCCell) {
        _choiceCCell = [self newChoiceThumbnailCell];
        [_choiceCCell setBasicColorHex:@"#3498db"];
    }
    return _choiceCCell;
}

- (ChoiceCell *)choiceDCell
{
    if (!_choiceDCell) {
        _choiceDCell = [self newChoiceThumbnailCell];
        [_choiceDCell setBasicColorHex:@"#2ecc71"];
    }
    return _choiceDCell;
}
@end
