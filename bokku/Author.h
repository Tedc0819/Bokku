//
//  Author.h
//  bokku
//
//  Created by Ted Cheng on 20/10/13.
//  Copyright (c) 2013 Ted Cheng. All rights reserved.
//

#import "TCJsonObject.h"

@interface Author : TCJsonObject

@property (nonatomic, strong) NSString *name;
@property (nonatomic, strong) NSString *pen_name;
@property (nonatomic, strong) NSString *email;

@end
