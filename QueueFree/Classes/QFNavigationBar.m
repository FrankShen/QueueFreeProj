//
//  QFNavigationBar.m
//  QueueFree
//
//  Created by BuG.BS on 12-10-24.
//  Copyright (c) 2012年 BuG.BS. All rights reserved.
//

#import "QFNavigationBar.h"

@implementation QFNavigationBar

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
    UIImage *image = [UIImage imageNamed: @"navigation_bar_background"];
    [image drawInRect:CGRectMake(0, 0, self.frame.size.width, self.frame.size.height)];
}


@end
