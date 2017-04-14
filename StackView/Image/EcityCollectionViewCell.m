//
//  EcityCollectionViewCell.m
//  StackView
//
//  Created by wangwenbing on 2017/4/13.
//  Copyright © 2017年 Centit. All rights reserved.
//

#import "EcityCollectionViewCell.h"

@interface EcityCollectionViewCell ()<UIGestureRecognizerDelegate>

@property (nonatomic, strong) UIPanGestureRecognizer *panRecognizer;

@property (nonatomic, strong) UITapGestureRecognizer *tapRecognizer;

@property (nonatomic, assign) CGPoint panStartPoint;

@property (nonatomic, assign) CGFloat startingRightLayoutConstraintConstant;


@end

@implementation EcityCollectionViewCell

- (void)awakeFromNib
{
    [super awakeFromNib];
    self.panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panCell:)];
    self.panRecognizer.delegate = self;
    self.panRecognizer.cancelsTouchesInView = YES;
    
    self.tapRecognizer = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tapThisCell:)];
    self.tapRecognizer.delegate = self;
    self.tapRecognizer.cancelsTouchesInView = NO;
    
    [self.myContentView addGestureRecognizer:self.panRecognizer];
    [self.myContentView addGestureRecognizer:self.tapRecognizer];
    
    [self.infoBtn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    [self.deleteBtn addTarget:self action:@selector(buttonClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    self.cellState = EcitySwipeableCollectionViewCellStateClosed;
    return;
}
// 重新设置限制为0
- (void)resetConstraintContstantsToZero:(BOOL)animated notifyDelegateDidClose:(BOOL)notifyDelegate
{
    NSObject<EcitySwipeableCollectionViewCellDelegate> *delegate = [self delegate];
    
    if (self.startingRightLayoutConstraintConstant == 0 && self.contentViewRightConstraint.constant == 0) {
        
        if (self.cellState == EcitySwipeableCollectionViewCellStateOpen) {
            [delegate cellDidColse:self];
        }
        
        self.cellState = EcitySwipeableCollectionViewCellStateClosed;
        return;
    }
    
    self.contentViewRightConstraint.constant = 0;
    self.contentViewLeftConstraint.constant = 0;
    
    [self updateConstraintsIfNeeded:animated completion:^(BOOL finished) {
        self.startingRightLayoutConstraintConstant = self.contentViewRightConstraint.constant;
        if (self.cellState == EcitySwipeableCollectionViewCellStateOpen) {
            [delegate cellDidColse:self];
        }
        self.cellState = EcitySwipeableCollectionViewCellStateClosed;
    }];
    
}

- (CGFloat)buttonTotalWidth
{
    return CGRectGetWidth(self.myContentView.frame) - CGRectGetMinX(self.swipeView.frame);
}
- (void)updateConstraintsIfNeeded:(BOOL)animated completion:(void(^)(BOOL finished))completion
{
    float duration = 0.0;
    if (animated) {
        duration = 0.25;
    }
    
    [UIView animateWithDuration:duration delay:0 options:UIViewAnimationOptionCurveEaseOut animations:^{
        [self layoutIfNeeded];//设置标志为立即调用 [laoutSubView];
    } completion:completion];
    
}

- (void)setConstraintsToShowAllButtons:(BOOL)animated notifyDelegateDidOpen:(BOOL)notifyDelegate
{
    NSObject<EcitySwipeableCollectionViewCellDelegate> *delegate = [self delegate];
    self.cellState = EcitySwipeableCollectionViewCellStateOpen;
    
    if (notifyDelegate) {
        
        [delegate cellDidOpen:self];
    }
    
    //
    if (self.startingRightLayoutConstraintConstant == [self buttonTotalWidth] && self.contentViewRightConstraint.constant == [self buttonTotalWidth]) {
        // cell Did Open
        return;
    }
    
    // 2 如果需要展示cell ，需要的限制为
    self.contentViewLeftConstraint.constant = - [self buttonTotalWidth];
    self.contentViewRightConstraint.constant = [self buttonTotalWidth];
    
    [self updateConstraintsIfNeeded:animated completion:^(BOOL finished) {
        //3.更新的限制为。。。。。。
        self.contentViewLeftConstraint.constant = - [self buttonTotalWidth];
        self.contentViewRightConstraint.constant = [self buttonTotalWidth];
        //4更新完成的限制为
        [self updateConstraintsIfNeeded:animated completion:^(BOOL finished) {
            self.startingRightLayoutConstraintConstant = self.contentViewRightConstraint.constant;
        }];
    }];
}

- (void)openCell
{
    [self setConstraintsToShowAllButtons:NO notifyDelegateDidOpen:NO];
    return;
}

- (void)closeCell
{
    [self resetConstraintContstantsToZero:NO notifyDelegateDidClose:NO
     ];
    return;
}
- (void)prepareForReuse
{
    [super prepareForReuse];
    self.editing = NO;
    [self resetConstraintContstantsToZero:NO notifyDelegateDidClose:NO];
    return;

}

- (void)panCell:(UIPanGestureRecognizer *)sender
{
    if (self.editing) return;
    switch (sender.state) {
        case UIGestureRecognizerStateBegan:
            
            self.panStartPoint = [sender translationInView:self.myContentView];
            self.startingRightLayoutConstraintConstant = self.contentViewRightConstraint.constant;
            
            break;
        case UIGestureRecognizerStateChanged: {
            CGPoint currentPoint = [sender translationInView:self.myContentView];
            CGFloat deltaX = currentPoint.x - self.panStartPoint.x;// 移动的差值
            BOOL panningLeft = NO;
            if (deltaX < 0) {
                panningLeft = YES;
            }
            
            // the cell was colsed and is now opening
            if (self.startingRightLayoutConstraintConstant == 0) { //2
                
                if (!panningLeft) {
                    CGFloat constant = MAX(-deltaX, 0);//3
                    if (constant == 0) {//4
                        [self resetConstraintContstantsToZero:NO notifyDelegateDidClose:NO];//5
                    }
                    else
                    {
                        self.contentViewRightConstraint.constant = constant;//6
                    }
                }
                else
                {
                    CGFloat constant = MIN(-deltaX, [self buttonTotalWidth]);//7
                    if (constant == [self buttonTotalWidth]) {//8
                        [self setConstraintsToShowAllButtons:YES notifyDelegateDidOpen:NO];//9
                        
                    }
                    else {
                        self.contentViewRightConstraint.constant = constant;//10;
                    }
                }
            }
            else
            {
                //The cell was at least partially open.
                CGFloat adjustment = self.startingRightLayoutConstraintConstant - deltaX;//11
                if (!panningLeft) {
                    CGFloat constant = MAX(adjustment, 0);//13
                    
                    if (constant == 0) {
                        [self resetConstraintContstantsToZero:YES notifyDelegateDidClose:YES];//14
                    }
                    else {
                        self.contentViewRightConstraint.constant = constant;
                    }
                }
                else {
                    
                    CGFloat constant = MAX(adjustment, [self buttonTotalWidth]);//16
                    if (constant == [self buttonTotalWidth]) {
                        [self setConstraintsToShowAllButtons:YES notifyDelegateDidOpen:NO];//18
                    }
                    else {
                   
                        self.contentViewRightConstraint.constant = constant;//19
                    }
                }
            }
            self.contentViewLeftConstraint.constant = -self.contentViewLeftConstraint.constant;// 20
            
        }
            break;
            
        case UIGestureRecognizerStateEnded:
        {
            if (self.startingRightLayoutConstraintConstant == 0) { //1
                
                //We were closed, gesture was opening
                CGFloat halfOfButtonOne = CGRectGetWidth(self.infoBtn.frame) / 2; //2
                if (self.contentViewRightConstraint.constant >= halfOfButtonOne) { //3
                    
                    //Open all the way
                    [self setConstraintsToShowAllButtons:YES notifyDelegateDidOpen:YES];
                }
                else {
                    
                    //Re-close
                    [self resetConstraintContstantsToZero:YES notifyDelegateDidClose:NO];
                }
            }
            else {
                
                //We were open, gesture was closing
                CGFloat threeQuatersSwipeView = CGRectGetWidth(self.swipeView.frame) * 0.75f;
                if (self.contentViewRightConstraint.constant >= threeQuatersSwipeView) { //5
                    
                    //Re-open all the way
                    [self setConstraintsToShowAllButtons:YES notifyDelegateDidOpen:YES];
                } else {
                    
                    //Close
                    [self resetConstraintContstantsToZero:YES notifyDelegateDidClose:YES];
                }
            }
        }
            break;
        
        case UIGestureRecognizerStateCancelled:
        {
            if (self.startingRightLayoutConstraintConstant == 0) {
                
                //We were closed - reset everything to 0
                [self resetConstraintContstantsToZero:YES notifyDelegateDidClose:YES];
            }
            else {
                
                //We were open - reset to the open state
                [self setConstraintsToShowAllButtons:YES notifyDelegateDidOpen:YES];
            }
        }
            break;
            
        default:
            break;
    }
}

- (void)tapThisCell:(UIGestureRecognizer *)sender
{
    if (self.cellState == EcitySwipeableCollectionViewCellStateOpen) {
        [self resetConstraintContstantsToZero:YES notifyDelegateDidClose:YES];
    }
    return;
}

- (void)buttonClicked:(id)sender
{
    NSObject<EcitySwipeableCollectionViewCellDelegate> *delegate = [self delegate];
    [self closeCell]; // 类似使用数组之前，先将数组清空
    
    if (sender == self.infoBtn) {
        [delegate buttonInfoActionForCell:self];
    } else if (sender == self.deleteBtn) {
        [delegate buttonDeleteActionForCell:self];
    } else
    {
        NSLog(@"Click unknown button !");
    }
    return;
}

- (BOOL)gestureRecognizerShouldBegin:(UIGestureRecognizer *)gestureRecognizer
{
    BOOL shouldBegin = NO;
    
    if (gestureRecognizer == self.panRecognizer) {
        // pan 为水平方向的手势
        CGPoint translation = [(UIPanGestureRecognizer *)gestureRecognizer translationInView:gestureRecognizer.view];
        shouldBegin = fabs(translation.y) <= fabs(translation.x);
    } else
    {
        return YES;
    }
    
    return shouldBegin;
}
//手势共享
- (BOOL)gestureRecognizer:(UIGestureRecognizer *)gestureRecognizer shouldRecognizeSimultaneouslyWithGestureRecognizer:(UIGestureRecognizer *)otherGestureRecognizer
{
    BOOL shouldRecoginizeSimultaneously = NO;
    // Find out if the user is actively scrolling the collectionView of which this is a member.
    // If they are, return NO, and don't let the gesture recognizers work simultaneously.
    //
    // This works very well in maintaining user expectations while still allowing for the user to
    // scroll the cell sideways when that is their true intent.
    if ([gestureRecognizer isKindOfClass:[UIPanGestureRecognizer class]]) {//Velocity 速率
        CGFloat xVelocity = [(UIPanGestureRecognizer *)gestureRecognizer velocityInView:gestureRecognizer.view].x;
        
        // Find the current scrolling velocity in that view, in the Y direction.
        CGFloat yVelocity = [(UIPanGestureRecognizer *)gestureRecognizer velocityInView:gestureRecognizer.view].y;
        
        // If the cell is open, ignore the vertical scroll and SWRevealViewController gesture recognizer when
        // swiping right
        if (self.cellState == EcitySwipeableCollectionViewCellStateOpen) {
            if (0.0 < xVelocity) {
                // Return YES iff the user is not actively scrolling up.
                //// Return YES if no scrolling up
                shouldRecoginizeSimultaneously = fabs(yVelocity) <= 0.25;
            } else {
                return shouldRecoginizeSimultaneously = YES;
            }
        }
        else {
            
            if (0.0 > xVelocity) {
            // return YES if no Scrolling up
                shouldRecoginizeSimultaneously = fabs(yVelocity) <= 0.25; // 0.2
            }
            else {
                shouldRecoginizeSimultaneously = YES;
            }
        }
    } else if ([gestureRecognizer isKindOfClass:[UITapGestureRecognizer class]]){
        
        shouldRecoginizeSimultaneously = YES;
    }
    
    return shouldRecoginizeSimultaneously;
}

- (void)setEditing:(BOOL)editing animation:(BOOL)animated
{
    self.editing = editing;
    if (editing) {
        
        self.cellState = EcitySwipeableCollectionViewCellStateEditing;
        self.contentViewLeftConstraint.constant = CGRectGetWidth(self.checkBoxView.frame);
        self.contentViewRightConstraint.constant = - CGRectGetWidth(self.checkBoxView.frame);
        [self updateConstraintsIfNeeded:animated completion:^(BOOL finished) {
            // 更新完约束之后负值
            self.startingRightLayoutConstraintConstant = self.contentViewRightConstraint.constant;
        }];
    }
    else
    {
        self.cellState = EcitySwipeableCollectionViewCellStateClosed;
        [self resetConstraintContstantsToZero:animated notifyDelegateDidClose:NO];
    }
}
@end
