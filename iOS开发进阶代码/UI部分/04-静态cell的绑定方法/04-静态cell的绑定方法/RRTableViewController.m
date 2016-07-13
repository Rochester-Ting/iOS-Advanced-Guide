//
//  RRTableViewController.m
//  04-静态cell的绑定方法
//
//  Created by 丁瑞瑞 on 13/7/16.
//  Copyright © 2016年 Rochester. All rights reserved.
//

#import "RRTableViewController.h"

@interface RRTableViewController ()
/** 数组*/
@property (nonatomic,strong) NSArray *arrM;
@end

@implementation RRTableViewController
//- (NSArray *)arrM
//{
//    if (!_arrM) {
//        _arrM = [[NSArray alloc] init];
//    }
//    return _arrM;
//}
- (void)viewDidLoad {
    [super viewDidLoad];
//    获取plist文件的路径
    NSString *path = [[NSBundle mainBundle] pathForResource:@"dr.plist" ofType:nil];
//    读取plist文件的内容
    self.arrM = [[NSArray alloc] initWithContentsOfFile:path];
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:@"RR"];
    
}
#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    NSArray *sectionArray = self.arrM[0];
    return sectionArray ? sectionArray.count : 0;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RR"];
    NSDictionary *dict = self.arrM[0][indexPath.row];
    cell.textLabel.text = dict[@"title"];
    return cell;
}

@end
