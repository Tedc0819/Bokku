//
//  ColorBar.h
//  bokku
//
//  Created by Ted Cheng on 18/10/13.
//  Copyright (c) 2013 Ted Cheng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface ColorBar : UIView

@property (nonatomic, assign) BOOL isHorizontal;
@property (nonatomic, strong) NSDictionary *colorDict;

@end
