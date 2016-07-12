//
//  ViewController.m
//  03-在Cell中有不定数量个带图Button
//
//  Created by 丁瑞瑞 on 12/7/16.
//  Copyright © 2016年 Rochester. All rights reserved.
//

#import "ViewController.h"
#import "RRCell.h"
@interface ViewController ()
/** <#注释#>*/
@property (nonatomic,strong) NSArray *arrM9;
@property (nonatomic,strong) NSArray *arrM6;
@property (nonatomic,strong) NSArray *arrM4;
@property (nonatomic,strong) NSArray *arrM3;
@property (nonatomic,strong) NSArray *arrM1;
@property (nonatomic,strong) NSArray *arrM0;
@end

@implementation ViewController
- (NSArray *)arrM9
{
    if (!_arrM9) {
        _arrM9 = @[@1,@2,@3,@4,@5,@6,@7,@8,@9];
    }
    return _arrM9;
}
- (NSArray *)arrM6
{
    if (!_arrM6) {
        _arrM6 = @[@1,@2,@3,@4,@5,@6];
    }
    return _arrM6;
}
- (NSArray *)arrM4
{
    if (!_arrM4) {
        _arrM4 = @[@1,@2,@3,@4];
    }
    return _arrM4;
}
- (NSArray *)arrM3
{
    if (!_arrM3) {
        _arrM3 = @[@1,@2,@3];
    }
    return _arrM3;
}
- (NSArray *)arrM1
{
    if (!_arrM1) {
        _arrM1 = @[@1];
    }
    return _arrM1;
}
- (NSArray *)arrM0
{
    if (!_arrM0) {
        _arrM0 = @[];
    }
    return _arrM0;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self.tableView registerNib:[UINib nibWithNibName:NSStringFromClass([RRCell class]) bundle:nil] forCellReuseIdentifier:@"RR"];
    self.tableView.rowHeight = UITableViewAutomaticDimension;
    self.tableView.estimatedRowHeight = 60;
}

#pragma datasource
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 9;
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    RRCell *cell = [tableView dequeueReusableCellWithIdentifier:@"RR"];
    if (indexPath.row == 0) {
        cell.arrM = self.arrM0;
    }else if (indexPath.row == 1){
        cell.arrM = self.arrM1;
    }else if (indexPath.row == 2){
        cell.arrM = self.arrM3;
    }else if (indexPath.row == 3){
        cell.arrM = self.arrM4;
    }else if (indexPath.row == 4){
        cell.arrM = self.arrM6;
    }else if (indexPath.row == 8){
        cell.arrM = self.arrM1;
    }else{
        cell.arrM = self.arrM9;
    }
    return cell;
}
@end
