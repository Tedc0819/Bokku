//
//  PaginationAdapter.m
//  bokku
//
//  Created by Ted Cheng on 1/11/13.
//  Copyright (c) 2013 Ted Cheng. All rights reserved.
//

#import "PaginationAdapter.h"

@implementation PaginationAdapter

- (id)init
{
    self = [super init];
    if (self) {
        self.ableToCenterCell = YES;
        self.numberOfCellDisplay = 6;
    }
    return self;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"HoriButtonsViewCell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
        [cell.contentView setTransform:CGAffineTransformMakeRotation( M_PI / 2)];
        [cell.contentView setBackgroundColor:[UIColor colorWithHex:@"#ecf0f1" alpha:1]];
        [cell.textLabel setTextColor:[UIColor colorWithHex:@"#95a5a6" alpha:1]];
        [cell.textLabel setTextAlignment:NSTextAlignmentCenter];
    }
    [cell.textLabel setText:@(indexPath.row).stringValue];
    
    return cell;
}

@end
