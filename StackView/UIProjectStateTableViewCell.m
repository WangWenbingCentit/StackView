//
//  UIProjectStateTableViewCell.m
//  StackView
//
//  Created by wangwenbing on 2017/4/13.
//  Copyright © 2017年 Centit. All rights reserved.
//

#import "UIProjectStateTableViewCell.h"

@implementation UIProjectStateTableViewCell

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

- (void)prepareForReuse
{
    
}

- (void)awakeFromNib
{
    [super awakeFromNib];
    [self prepareForReuse];
}
@end
