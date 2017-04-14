//
//  EcityCollectionViewFlowLayoutDelegate.m
//  StackView
//
//  Created by wangwenbing on 2017/4/13.
//  Copyright © 2017年 Centit. All rights reserved.
//

#import "EcityCollectionViewFlowLayoutDelegate.h"

static NSString *kCoderItemWidthMaximumKey = @"itemWidthMaximum";
static NSString *kCoderInterItemSpacingKey = @"interItemSpacing";

static const float kEcityCollectionInterItemSpacing = 8.0;
@interface EcityCollectionViewFlowLayoutDelegate ()

@end

@implementation EcityCollectionViewFlowLayoutDelegate

- (instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super init];
    if (self == nil) return nil;
    [self prepareDefaults];

    if ([aDecoder containsValueForKey:kCoderInterItemSpacingKey]) {
        _interItemSpacing = [aDecoder decodeFloatForKey:kCoderInterItemSpacingKey];
    }
    if ([aDecoder containsValueForKey:kCoderItemWidthMaximumKey]) {
        _itemWidthMaxinum = [aDecoder decodeFloatForKey:kCoderItemWidthMaximumKey];
    }
    return self;
}

- (instancetype)init
{
    self = [super init];
    if (self == nil) return nil;
    [self prepareDefaults];
    
    return self;
}

- (void)encodeWithCoder:(NSCoder *)aCoder
{
    [aCoder encodeFloat:self.itemWidthMaxinum forKey:kCoderItemWidthMaximumKey];
    [aCoder encodeFloat:self.interItemSpacing forKey:kCoderInterItemSpacingKey];
}

- (void)prepareDefaults
{
    _interItemSpacing = kEcityCollectionInterItemSpacing;
    _itemWidthMaxinum = 384;// 375+8
    _fullViewCell = NO;
}

- (CGSize)recommendedThumbnailSizeForCollectionView:(UICollectionView *)collectionView
{
    CGFloat width = self.itemWidthMaxinum;
    // Don't use the collection View's traitCollection.scale because it will be zero when it's not currently presented
    CGFloat scale = [[[[UIApplication sharedApplication] keyWindow] screen] scale];
    CGSize thumbnailSize = CGSizeMake(width * scale, round(width*scale * 9.0 / 16.0));
    
    return thumbnailSize;
}

- (CGSize)cellSizeForCollectionView:(UICollectionView *)collectionView ofSize:(CGSize)collectionViewSize
{
    CGRect bounds = { CGPointZero,collectionViewSize};
    CGSize cellSize = CGSizeZero;
    CGFloat interItemSpacing = self.interItemSpacing;
    
    NSInteger mediaItemsPerRow;
    //UIEdgeInsetsInsetRect 表示在原来的rect基础上根据边缘距离内切一个rect出来
    bounds = UIEdgeInsetsInsetRect(bounds, collectionView.scrollIndicatorInsets);
    
    // some of our CVS have headers// 判断是否有header
    UICollectionReusableView *firstHeader = [[collectionView visibleSupplementaryViewsOfKind:UICollectionElementKindSectionHeader] firstObject];
    
    if (firstHeader) {
        bounds.size.height -= firstHeader.frame.size.height;
    }
    // 判断是否有其他的view展示，有的话， bounds.size.height -= firstHeader.frame.size.height;
    if (self.fullViewCell) {
        cellSize = CGSizeMake(CGRectGetWidth(bounds) - 2.0 * interItemSpacing, CGRectGetHeight(bounds));
    } else {
        // roundf --> 四舍五入 -> 竖屏
        if (collectionView.traitCollection.horizontalSizeClass == UIUserInterfaceSizeClassRegular) {
            // ceil -> 向上取整
            mediaItemsPerRow = ceil((CGRectGetWidth(bounds) - interItemSpacing)/ (self.itemWidthMaxinum + interItemSpacing));

            cellSize.width = floor((CGRectGetWidth(bounds) - ((mediaItemsPerRow + 1) * interItemSpacing)) /mediaItemsPerRow);
        } else {
            cellSize.width = collectionViewSize.width;
        }
        
        cellSize.height = cellSize.width * 9.0 / 16.0;
    }

    return cellSize;
    
}

- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    //如果是竖屏
    if (collectionView.traitCollection.horizontalSizeClass == UIUserInterfaceSizeClassRegular) {
        return UIEdgeInsetsMake(self.interItemSpacing, self.interItemSpacing, self.interItemSpacing, self.interItemSpacing);
    } else
    {
        return UIEdgeInsetsZero;
    }
}
//最小行 间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumLineSpacingForSectionAtIndex:(NSInteger)section
{
    // 如果是竖屏
    if (collectionView.traitCollection.horizontalSizeClass == UIUserInterfaceSizeClassRegular) {
        return self.interItemSpacing;
    } else
    {
        return 0;
    }
}
//最小列间距
- (CGFloat)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout minimumInteritemSpacingForSectionAtIndex:(NSInteger)section
{
    //如果是横屏
    if (collectionView.traitCollection.horizontalSizeClass == UIUserInterfaceSizeClassRegular) {
        return self.interItemSpacing;
    } else
    {
        return 0;
    }
}

- (BOOL)respondsToSelector:(SEL)aSelector
{
    BOOL responds = [super respondsToSelector:aSelector];
    
    BOOL passResponds = NO;
    
    id delegate = self.passthroughDelegate;
    if (delegate) {
        
        passResponds = [delegate respondsToSelector:aSelector];
    }
    
    return responds || passResponds;
    
}
// 如果一个类不能执行aSelector ,将无法处理的selector 转发给其他对象
- (id)forwardingTargetForSelector:(SEL)aSelector
{
    id delegate = self.passthroughDelegate;
    return delegate;
}
@end
