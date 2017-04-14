//
//  EcityCollectionViewFlowLayout.h
//  StackView
//
//  Created by wangwenbing on 2017/4/13.
//  Copyright © 2017年 Centit. All rights reserved.
//

#import <UIKit/UIKit.h>

IB_DESIGNABLE
@interface EcityCollectionViewFlowLayout : UICollectionViewFlowLayout
//// Set these properties to YES to get headers that pin to the top of the screen and footers that pin to the bottom while scrolling (similar to UITableView).// 固定区的大小--便于滑动，优化性能
@property (nonatomic, assign) IBInspectable BOOL sectionHeadersPinToVisibleBounds;

@end
