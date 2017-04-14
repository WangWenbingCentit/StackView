//
//  EcityTableViewCardView.m
//  StackView
//
//  Created by wangwenbing on 2017/4/14.
//  Copyright © 2017年 Centit. All rights reserved.
//

#import "EcityTableViewCardView.h"

@implementation EcityTableViewCardView

- (instancetype)initWithFrame:(CGRect)frame
{
    EcityTableViewCardView *view = [super initWithFrame:frame];
    [view customizeLayer];
    
    return view;
}

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    EcityTableViewCardView *view = [super initWithCoder:aDecoder];
    [view customizeLayer];
    
    return view;
}

- (void)customizeLayer
{
    CALayer *customLayer = [self layer];
    [customLayer setMasksToBounds:YES];
    
    return;
}

+ (BOOL)requiresConstraintBasedLayout
{
    return YES;
}
@end
