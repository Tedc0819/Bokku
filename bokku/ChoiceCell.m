//
//  ChoiceCell.m
//  bokku
//
//  Created by Ted Cheng on 18/10/13.
//  Copyright (c) 2013 Ted Cheng. All rights reserved.
//

#import "ChoiceCell.h"

@implementation ChoiceCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self setAsNormalState];
        self.basicColorHex = @"#ffffff";
        self.textColorHex = @"#000000";
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    selected ? [self setAsSelectedState] : [self setAsNormalState];
    // Configure the view for the selected state
}

- (void)setHighlighted:(BOOL)highlighted animated:(BOOL)animated
{
    [super setHighlighted:highlighted animated:animated];
    highlighted ? [self setAsHighlightedState] : [self setAsNormalState];
}

- (void)setAsNormalState
{
    [self.contentView setBackgroundColor:[UIColor colorWithHex:self.basicColorHex alpha:0.2]];
    [self.textLabel setTextColor:[UIColor colorWithHex:self.textColorHex alpha:0.25]];
}

- (void)setAsHighlightedState
{
    [self.contentView setBackgroundColor:[UIColor colorWithHex:self.basicColorHex alpha:0.8]];
    [self.textLabel setTextColor:[UIColor colorWithHex:self.textColorHex alpha:0.85]];
}

- (void)setAsSelectedState
{
    [self.contentView setBackgroundColor:[UIColor colorWithHex:self.basicColorHex alpha:1]];
    [self.textLabel setTextColor:[UIColor colorWithHex:self.textColorHex alpha:1]];
}

@end
