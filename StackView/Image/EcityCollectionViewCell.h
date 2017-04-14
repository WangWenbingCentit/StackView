//
//  EcityCollectionViewCell.h
//  StackView
//
//  Created by wangwenbing on 2017/4/13.
//  Copyright © 2017年 Centit. All rights reserved.
//

#import <UIKit/UIKit.h>

typedef NS_OPTIONS(NSInteger, EcitySwipeableCollectionViewCellState)
{
    EcitySwipeableCollectionViewCellStateOpen,
    EcitySwipeableCollectionViewCellStateClosed,
    EcitySwipeableCollectionViewCellStateEditing
};

@class EcityCollectionViewCell;

@protocol EcitySwipeableCollectionViewCellDelegate <NSObject>

- (void)buttonInfoActionForCell:(EcityCollectionViewCell *)aCell;

- (void)buttonDeleteActionForCell:(EcityCollectionViewCell *)aCell;

- (void)cellDidOpen:(EcityCollectionViewCell *)aCell;

- (void)cellDidColse:(EcityCollectionViewCell *)aCell;


@end

@interface EcityCollectionViewCell : UICollectionViewCell

@property (atomic, strong) IBOutlet UIButton *deleteBtn;
@property (atomic, strong) IBOutlet UIButton *infoBtn;

@property (atomic, strong) IBOutlet UIView *swipeView;

@property (atomic, strong) IBOutlet UIView *myContentView;

@property (atomic, strong) IBOutlet UIView *checkBoxView;

@property (atomic, strong) IBOutlet NSLayoutConstraint *contentViewRightConstraint;

@property (atomic, strong) IBOutlet NSLayoutConstraint *contentViewLeftConstraint;

@property (weak) NSObject <EcitySwipeableCollectionViewCellDelegate> *delegate;

@property (atomic) EcitySwipeableCollectionViewCellState cellState;

@property (atomic, getter=isEditing) BOOL editing;

@end
