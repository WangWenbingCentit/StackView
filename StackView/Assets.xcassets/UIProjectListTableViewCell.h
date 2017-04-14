//
//  UIProjectListTableViewCell.h
//  StackView
//
//  Created by wangwenbing on 2017/4/11.
//  Copyright © 2017年 Centit. All rights reserved.
//

#import "EcityTableViewCell.h"
#import "UIProjectLabel.h"

@interface UIProjectListTableViewCell : EcityTableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *projectIcon;
@property (weak, nonatomic) IBOutlet UIProjectLabel *projectName;
@property (weak, nonatomic) IBOutlet UIProjectLabel *projectLove;

@end
