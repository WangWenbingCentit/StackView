//
//  UIProjectListTableViewCell.m
//  StackView
//
//  Created by wangwenbing on 2017/4/11.
//  Copyright © 2017年 Centit. All rights reserved.
//

#import "UIProjectListTableViewCell.h"

@implementation UIProjectListTableViewCell


- (void)prepareForReuse
{
    [super prepareForReuse];
    self.projectIcon = nil;
    self.projectName = nil;
    self.projectLove = nil;
}
//如果使用需要修改xib上控件默认的初始值，需要调用这个方法。同时需要重写父类的初始化方法
- (void)awakeFromNib
{
    [super awakeFromNib];
    [self prepareForReuse];
}
@end
