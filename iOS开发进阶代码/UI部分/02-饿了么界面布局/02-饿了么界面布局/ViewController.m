//
//  ViewController.m
//  02-饿了么界面布局
//
//  Created by 丁瑞瑞 on 12/7/16.
//  Copyright © 2016年 Rochester. All rights reserved.
//

#import "ViewController.h"
#import "LeftTableViewController.h"
#import "RightTableViewController.h"
@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    LeftTableViewController *leftVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"LeftVC"];
    RightTableViewController *RightVC = [[UIStoryboard storyboardWithName:@"Main" bundle:nil] instantiateViewControllerWithIdentifier:@"RightVC"];
    __weak RightTableViewController *right = RightVC;
    leftVC.callBackBlock = ^(NSString *str){
        [right.tableView reloadData];
        
    };
}



@end
