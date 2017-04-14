//
//  EcityCollectionViewFlowLayout.m
//  StackView
//
//  Created by wangwenbing on 2017/4/13.
//  Copyright © 2017年 Centit. All rights reserved.
//

#import "EcityCollectionViewFlowLayout.h"

@implementation EcityCollectionViewFlowLayout

@dynamic sectionHeadersPinToVisibleBounds;
// 优化性能
- (UICollectionViewFlowLayoutInvalidationContext *)invalidationContextForBoundsChange:(CGRect)newBounds
{
    UICollectionViewFlowLayoutInvalidationContext *context = (UICollectionViewFlowLayoutInvalidationContext *)[super invalidationContextForBoundsChange:newBounds];
    CGRect oldBounds = self.collectionView.bounds;
    if (!CGSizeEqualToSize(oldBounds.size, newBounds.size)) {
        context.invalidateFlowLayoutDelegateMetrics = YES;
    }
    return context;
}
@end
