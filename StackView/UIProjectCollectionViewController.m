//
//  UIProjectCollectionViewController.m
//  StackView
//
//  Created by wangwenbing on 2017/4/13.
//  Copyright © 2017年 Centit. All rights reserved.
//

#import "UIProjectCollectionViewController.h"
#import "EcityCollectionViewFlowLayoutDelegate.h"
#import "UIProjectStateCollectionViewCell.h"

@interface UIProjectCollectionViewController ()
//返回共享数据使用atomic dataSource／截图／ flowlayoutDelegate／MBProjressHUD

@property (strong, atomic) IBOutlet EcityCollectionViewFlowLayoutDelegate *flowLayoutDelegate;
@end

@implementation UIProjectCollectionViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    // Do any additional setup after loading the view.
}

- (void)setEditing:(BOOL)editing animated:(BOOL)animated
{
    [super setEditing:editing animated:animated];
    UICollectionView *collectionView = self.collectionView;
  
    
    UICollectionViewFlowLayoutInvalidationContext *context = [[UICollectionViewFlowLayoutInvalidationContext alloc] init];
    [context invalidateFlowLayoutDelegateMetrics];
    [collectionView.collectionViewLayout invalidateLayoutWithContext:context];
    
}

- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return 2;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *kUIProjectStateCollectionViewCell = @"UIProjectStateCollectionViewCell";
    
    UIProjectStateCollectionViewCell *cell = (UIProjectStateCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:kUIProjectStateCollectionViewCell forIndexPath:indexPath];
    
    return cell;
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
