//
//  ViewController.m
//  StackView
//
//  Created by wangwenbing on 2017/4/11.
//  Copyright © 2017年 Centit. All rights reserved.
//

#import "ViewController.h"
#import "UIProjectListTableViewCell.h"
#import "UIProjectStateTableViewCell.h"
@interface ViewController ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, weak) IBOutlet UITableView *tableView;



@end

static NSString *kProjectListTableVeiwCell = @"UIProjectListTableViewCell";
static NSString *kProjectStateScreenSegue = @"ProjectStateScreenSegue";
static NSString *kProjectStateCollectionScreenSegue = @"ProjectStateCollectionScreenSegue";
static NSString *kProjectStateTableViewCell = @"UIProjectStateTableViewCell";
@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
 
    if (indexPath.row == 0) {
        UIProjectListTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kProjectListTableVeiwCell forIndexPath:indexPath];
        cell.projectLove.text = @"900000喜欢";
        cell.projectName.text = @"小儿科医生";
        return cell;
    } else {
        
        UIProjectStateTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:kProjectStateTableViewCell forIndexPath:indexPath];
        return cell;
    }
    
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) return 120;
    if (indexPath.row == 1) return 150;
    return 100;
}
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
    if (indexPath.row == 0) {
        [self performSegueWithIdentifier:kProjectStateScreenSegue sender:nil];
    }
    [self performSegueWithIdentifier:kProjectStateCollectionScreenSegue sender:nil];
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    
}
// 如果从B->A ,那么这个方法写到A中，然后b中的时间绑定这个方法
- (IBAction)backActionSegue:(UIStoryboardSegue *)unwindSegue
{
    NSLog(@"%@",[self class]);
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
