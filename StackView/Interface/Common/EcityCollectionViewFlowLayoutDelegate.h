//
//  EcityCollectionViewFlowLayoutDelegate.h
//  StackView
//
//  Created by wangwenbing on 2017/4/13.
//  Copyright © 2017年 Centit. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

IB_DESIGNABLE
@interface EcityCollectionViewFlowLayoutDelegate : NSObject<UICollectionViewDelegateFlowLayout, NSCoding>

@property (weak) IBOutlet NSObject <UICollectionViewDelegate> *passthroughDelegate;
@property (assign) IBInspectable CGFloat interItemSpacing;//列间隔
@property (assign) IBInspectable CGFloat itemWidthMaxinum;//最大宽度

@property (assign) BOOL fullViewCell;

- (CGSize)recommendedThumbnailSizeForCollectionView:(UICollectionView *)collectionView;


@end
