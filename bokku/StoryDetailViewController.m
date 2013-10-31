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

#define StoryDescriptionFontSize 18.0

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
@property (nonatomic, assign) NSUInteger currentStoryPartIndex;

@property (nonatomic ,strong) UIButton *likeButton;
@property (nonatomic, strong) UIButton *dislikeButton;
@property (nonatomic, strong) UIButton *forwardButton;
@property (nonatomic, strong) UIButton *reverseButton;
@property (nonatomic, strong) UIButton *popButton;

@property (nonatomic, assign) BOOL isListingShown;
@property (nonatomic, assign) NSInteger popCount;
@property (nonatomic, assign) NSInteger acPopCount;

@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, assign) BOOL popButtonShouldFade;

@property (nonatomic, strong) UIView *paginationView;

@end

@implementation StoryDetailViewController

- (id)initWithStory:(Story *)story
{
    self = [self init];
    if (self) {
        self.story = story;
        self.currentStoryPartIndex = 0;
        [self setTitle:self.story.title];
    }
    return self;
}

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
    
    CGFloat specialZoneHeight = 50;
    CGFloat specialButtonWidth = 90;
    CGFloat width = (self.view.frame.size.width - specialButtonWidth) / 4.0;
    
    [self.tableView setFrame:CGRectMake(0, 0, self.view.frame.size.width, self.view.frame.size.height - specialZoneHeight)];
    [self.specialZone setFrame:CGRectMake(0, self.view.frame.size.height - specialZoneHeight, self.view.frame.size.width, specialZoneHeight)];
    
    self.paginationView = [[UIView alloc] initWithFrame:CGRectMake(0, self.view.center.y - 10, self.view.frame.size.width, specialZoneHeight + 10)];
    [self.paginationView setBackgroundColor:[UIColor colorWithHex:@"#ecf0f1" alpha:1]];
    [self.paginationView setAlpha:0];
    [self.view addSubview:self.paginationView];
    
    UIButton *reverseButton = [[UIButton alloc] initWithFrame:CGRectMake(0, self.view.center.y - 10, 30, specialZoneHeight + 10)];
    [reverseButton setTitle:[NSString fontAwesomeIconStringForEnum:FAIconBackward] forState:UIControlStateNormal];
    [reverseButton addTarget:self action:@selector(reverseButtonDidClick:) forControlEvents:UIControlEventTouchUpInside];
    [reverseButton setAlpha:0.75];
    
    UIButton *forwardButton = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width - 30, self.view.center.y - 10, 30, specialZoneHeight + 10)];
    [forwardButton setTitle:[NSString fontAwesomeIconStringForEnum:FAIconForward] forState:UIControlStateNormal];
    [forwardButton addTarget:self action:@selector(forwardButtonDidClick:) forControlEvents:UIControlEventTouchUpInside];
    [forwardButton setAlpha:0.75];
    
    UIButton *favButton = [[UIButton alloc] initWithFrame:CGRectMake(width, self.view.frame.size.height - specialZoneHeight, width, specialZoneHeight)];
    [favButton setTitle:[NSString fontAwesomeIconStringForEnum:FAIconBookmark] forState:UIControlStateNormal];
    [favButton addTarget:self action:@selector(favButtonDidClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *likeButton = [[UIButton alloc] initWithFrame:CGRectMake(0, self.view.frame.size.height - specialZoneHeight, width, specialZoneHeight)];
    [likeButton setTitle:[NSString fontAwesomeIconStringForEnum:FAIconThumbsUp] forState:UIControlStateNormal];
    [likeButton addTarget:self action:@selector(likeButtonDidClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *dislikeButton = [[UIButton alloc] initWithFrame:CGRectMake(self.view.frame.size.width - width, self.view.frame.size.height - specialZoneHeight, width, specialZoneHeight)];
    [dislikeButton setTitle:[NSString fontAwesomeIconStringForEnum:FAIconThumbsDown] forState:UIControlStateNormal];
    [dislikeButton addTarget:self action:@selector(dislikeButtonDidClick:) forControlEvents:UIControlEventTouchUpInside];
    
    UIButton *popButton = [[UIButton alloc] initWithFrame:CGRectMake(width * 2, self.view.frame.size.height - specialZoneHeight - 3, specialButtonWidth, specialZoneHeight + 3)];
    [popButton setTitle:[NSString fontAwesomeIconStringForEnum:FAIconCircle] forState:UIControlStateNormal];
    [popButton addTarget:self action:@selector(popButtonDidClick:) forControlEvents:UIControlEventTouchUpInside];
    [popButton setAdjustsImageWhenHighlighted:NO];
    
    UIButton *listButton = [[UIButton alloc] initWithFrame:CGRectMake(width * 2 + specialButtonWidth, self.view.frame.size.height - specialZoneHeight, width, specialZoneHeight)];
    [listButton setTitle:[NSString fontAwesomeIconStringForEnum:FAIconList] forState:UIControlStateNormal];
    [listButton addTarget:self action:@selector(listButtonDidClick:) forControlEvents:UIControlEventTouchUpInside];
    
    [@[reverseButton, favButton, forwardButton, listButton, popButton, likeButton, dislikeButton] enumerateObjectsUsingBlock:^(UIButton *button, NSUInteger idx, BOOL *stop) {
        [button.titleLabel setFont:[UIFont fontWithName:kFontAwesomeFamilyName size:14]];
        [button setTitleColor:[UIColor colorWithHex:@"#95a5a6" alpha:1] forState:UIControlStateNormal];
        if (button != popButton) {
            [button setBackgroundColor:[UIColor colorWithHex:@"#ecf0f1" alpha:1] forState:UIControlStateNormal];
        }
        [self.view addSubview:button];
    }];
    
    [popButton.titleLabel setFont:[UIFont fontWithName:kFontAwesomeFamilyName size:18]];
    [popButton setBackgroundColor:[UIColor colorWithHex:@"#ecf0f1" alpha:1]];
    
    [likeButton setTitleColor:[UIColor colorWithHex:@"#3498db" alpha:1] forState:UIControlStateNormal];
    [likeButton setTitleColor:[UIColor colorWithHex:@"#2980b9" alpha:1] forState:UIControlStateSelected];
    [likeButton setBackgroundColor:[UIColor colorWithHex:@"#3498db" alpha:1] forState:UIControlStateSelected];
    
    [dislikeButton setTitleColor:[UIColor colorWithHex:@"#e74c3c" alpha:1] forState:UIControlStateNormal];
    [dislikeButton setTitleColor:[UIColor colorWithHex:@"#c0392b" alpha:1] forState:UIControlStateSelected];
    [dislikeButton setBackgroundColor:[UIColor colorWithHex:@"#e74c3c" alpha:1] forState:UIControlStateSelected];
    
    self.likeButton = likeButton;
    self.dislikeButton = dislikeButton;
    self.forwardButton = forwardButton;
    self.reverseButton = reverseButton;
    self.popButton = popButton;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    [self loadCurrentStoryPart];
    [self startTimer];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)loadCurrentStoryPart
{
    if (self.story.storyPartIds.count == 0) return;

    [ActivityIndicatorManager showIndicatorForActivity:@"StoryPartLoading"];
    [self.story loadStoryPartWithIndex:self.currentStoryPartIndex withCompletion:^(NSArray *relatedParts, StoryPart *storyPart) {
        [self loadStoryPart:storyPart];
        [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:0 inSection:0] atScrollPosition:UITableViewScrollPositionTop animated:NO];
        [ActivityIndicatorManager dismissIndicatorForActivity:@"StoryPartLoading"];
    }];
}

- (void)loadStoryPart:(StoryPart *)storyPart
{
    [self.storyDescriptionCell.textLabel setText:storyPart.title];
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
    return 2 + 4;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = self.cells[indexPath.row];
//    cell.textLabel setf
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
//    if (indexPath.row == 0) return 150;
    
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

- (void)listingAnimation
{
    UIView *leftView = [[UIView alloc] initWithFrame:self.reverseButton.frame];
    UIView *rightView = [[UIView alloc] initWithFrame:self.forwardButton.frame];

    [@[leftView, rightView] enumerateObjectsUsingBlock:^(UIView *view, NSUInteger idx, BOOL *stop) {
        [view setBackgroundColor:[UIColor colorWithHex:@"#ecf0f1" alpha:1]];
        [self.view addSubview:view];
    }];
    
    [UIView animateWithDuration:0.2
                     animations:^{
                         CGRect leftViewFrame = leftView.frame;
                         leftViewFrame.size.width = self.view.frame.size.width / 2;
                         [leftView setFrame:leftViewFrame];
                         
                         CGRect rightViewFrame = rightView.frame;
                         rightViewFrame.size.width = self.view.frame.size.width / 2;
                         rightViewFrame.origin.x = self.view.frame.size.width / 2;
                         [rightView setFrame:rightViewFrame];
                         [self.paginationView setAlpha:1];
                     }
                     completion:^(BOOL finished) {
                         [leftView removeFromSuperview];
                         [rightView removeFromSuperview];
                         self.isListingShown = YES;
                     }];
}

- (void)removeListing
{
    if (!self.isListingShown) return;
    [self.paginationView setAlpha:0];
    self.isListingShown = NO;
}

- (void)updateStoryLikeStatus
{
    if (self.dislikeButton.selected) {
        self.story.likeStatus = StoryLikeStatusDislike;
        return;
    }
    
    if (self.likeButton.selected) {
        self.story.likeStatus = StoryLikeStatusLike;
        return;
    }
    self.likeButton = StoryLikeStatusNormal;
    return;
}

- (void)updatePopButtonStatus
{
    UIColor *color = [UIColor colorWithHex:@"#ecf0f1" alpha:1];
    CGFloat factor = ((float)self.popCount) / 20.0;
    factor = factor < 0 ? -factor : factor;
    factor = factor > 0.8 ? 0.8 : factor;

    if (self.popCount > 0) color = [UIColor colorWithHex:@"#3498db" alpha:factor + 0.2];
    if (self.popCount < 0) color = [UIColor colorWithHex:@"#e74c3c" alpha:factor + 0.2];
    
    [self.popButton setBackgroundColor:color];
}

#pragma mark - timer 

- (void)startTimer
{
    [self stopTimer];
    self.timer = [NSTimer scheduledTimerWithTimeInterval:0.5 target:self selector:@selector(regularAction) userInfo:nil repeats:YES];
}

- (void)stopTimer
{
    [self.timer invalidate];
    self.timer = nil;
}

- (void)regularAction
{
    if (self.popButtonShouldFade) {
        self.popButtonShouldFade = NO;
        self.popCount = 0;
        
        [UIView animateWithDuration:1 animations:^{
            [self updatePopButtonStatus];
        }];
    }
    self.popButtonShouldFade = !(self.popCount == 0);

}

#pragma mark - target

- (void)forwardButtonDidClick:(UIButton *)button
{
    NSLog(@"button = %@", button);
    if (self.currentStoryPartIndex >= self.story.maxPage) return;
    self.currentStoryPartIndex += 1;
    [self loadCurrentStoryPart];
}

- (void)reverseButtonDidClick:(UIButton *)button
{
    NSLog(@"button = %@", button);
    if (self.currentStoryPartIndex <= 0) return;
    self.currentStoryPartIndex -= 1;
    [self loadCurrentStoryPart];
}

- (void)favButtonDidClick:(UIButton *)button
{
    NSLog(@"button = %@", button);
}

- (void)listButtonDidClick:(UIButton *)button
{
    NSLog(@"button = %@", button);
    if (self.isListingShown) return;
    [self listingAnimation];
}

- (void)popButtonDidClick:(UIButton *)button
{
    NSLog(@"button = %@", button);
    self.popCount += self.story.likeStatus * 1;
    NSLog(@"clicked , count - %d", self.popCount);
    self.popButtonShouldFade = NO;
    [self updatePopButtonStatus];
}

- (void)likeButtonDidClick:(UIButton *)button
{
    NSLog(@"button = %@", button);
    [button setSelected:!button.selected];
    if (button.selected) {
        [self.dislikeButton setSelected:NO];
        self.popCount = 0;
        [self updatePopButtonStatus];
    }
    [self updateStoryLikeStatus];
}

- (void)dislikeButtonDidClick:(UIButton *)button
{
    NSLog(@"button = %@", button);
    [button setSelected:!button.selected];
    if (button.selected) {
        [self.likeButton setSelected:NO];
        self.popCount = 0;
        [self updatePopButtonStatus];
    }
    [self updateStoryLikeStatus];
}

#pragma mark - scrollView delegate

- (void)scrollViewDidScroll:(UIScrollView *)scrollView
{

}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self removeListing];
}

#pragma mark - lazy loading

- (NSArray *)cells
{
    if (!_cells) {
//        _cells = @[self.thumbnailCell, self.storyDescriptionCell, self.questionCell, self.choiceACell, self.choiceBCell, self.choiceCCell, self.choiceDCell];
        _cells = @[self.storyDescriptionCell, self.questionCell, self.choiceACell, self.choiceBCell, self.choiceCCell, self.choiceDCell];
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
    }
    return _thumbnailCell;
}

- (CGSize)labelSizeOfLabel:(UILabel *)label WithMargin:(CGFloat) margin
{
    CGRect labelSize = [label.text boundingRectWithSize:CGSizeMake(self.view.frame.size.width - 30 - margin * 2, CGFLOAT_MAX)
                                                options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                             attributes:@{NSFontAttributeName:label.font,
                                                          NSParagraphStyleAttributeName : [NSParagraphStyle defaultParagraphStyle]}
                                                context:nil];

    return labelSize.size;
}

- (UITableViewCell *)storyDescriptionCell
{
    if (!_storyDescriptionCell) {
        _storyDescriptionCell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"DescriptionCell"];
        [_storyDescriptionCell setSelectionStyle:UITableViewCellSelectionStyleNone];
        [_storyDescriptionCell.textLabel setNumberOfLines:0];
        [_storyDescriptionCell.textLabel setFont:[UIFont systemFontOfSize:16]];
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
