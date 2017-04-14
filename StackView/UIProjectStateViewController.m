//
//  UIProjectStateViewController.m
//  StackView
//
//  Created by wangwenbing on 2017/4/11.
//  Copyright © 2017年 Centit. All rights reserved.
//

#import "UIProjectStateViewController.h"
#import "UIMessageListViewController.h"
#import "WToast.h"
@interface UIProjectStateViewController ()

@end
static NSString *kUIMessageListViewController = @"UIMessageListViewController";
@implementation UIProjectStateViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [WToast showWithText:@"天天向上"];
    // Do any additional setup after loading the view.
}


- (IBAction)pushViewController:(id)sender {

    [self performSegueWithIdentifier:kUIMessageListViewController sender:sender];
}


- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([segue.identifier isEqualToString:kUIMessageListViewController]) {
        UIMessageListViewController *messageListViewController = segue.destinationViewController;
        messageListViewController.title = @"天天向上";
        //   [self.navigationController pushViewController:messageListViewController animated:YES];
        
    }
    
 
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
