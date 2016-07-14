//
//  ViewController.m
//  UIPickerView
//
//  Created by 丁瑞瑞 on 14/7/16.
//  Copyright © 2016年 Rochester. All rights reserved.
//

#import "ViewController.h"
#import "AFHTTPSessionManager.h"
@interface ViewController ()<UIPickerViewDelegate,UIPickerViewDataSource>
@property (weak, nonatomic) IBOutlet UIPickerView *CityPickerView;
/** */
@property (nonatomic,strong) AFHTTPSessionManager *manager;

/** 存放省的数组*/
@property (nonatomic,strong) NSArray *proArr;
/** 存放市的数组*/
@property (nonatomic,strong) NSArray *cityArr;
/** 存放区的数组*/
@property (nonatomic,strong) NSArray *townArr;
/** 记录市的索引*/
@property (nonatomic,assign) NSInteger index;
@end

@implementation ViewController
- (NSArray *)proArr
{
    if (!_proArr) {
        _proArr = [[NSArray alloc] init];
    }
    return _proArr;
}
- (NSArray *)cityArr
{
    if (!_cityArr) {
        _cityArr = [[NSArray alloc] init];
    }
    return _cityArr;
}
- (NSArray *)townArr
{
    if (!_townArr) {
        _townArr = [[NSArray alloc] init];
    }
    return _townArr;
}
- (AFHTTPSessionManager *)manager
{
    if (!_manager) {
        _manager = [AFHTTPSessionManager manager];
        _manager.responseSerializer.acceptableContentTypes  =[NSSet setWithObject:@"text/plain"];
    }
    return _manager;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    self.CityPickerView.delegate = self;
    self.CityPickerView.dataSource = self;
//    获取省的数据
    [self getProvinces];
    [self getCity:@"11"];
    [self getTown:@"1101"];
}
#pragma mark - 获取省的数据
- (void)getProvinces{
    [self.manager POST:@"http://120.26.87.168:8080/cafe/api/common/getAllProvince" parameters:nil progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        
        self.proArr = responseObject[@"result"];
       
        [self.CityPickerView reloadAllComponents];
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}
#pragma mark - 获取市的数据
- (void)getCity:(NSString *)index{
    NSDictionary *dict = @{@"provinceId":index};
    
    [self.manager POST:@"http://120.26.87.168:8080/cafe/api/common/getCityByProvinceId" parameters:dict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
//        NSLog(@"%@",responseObject);
        
            self.cityArr = responseObject[@"result"];
//            NSLog(@"%@",self.cityArr);
            [self.CityPickerView reloadAllComponents];
        if (self.cityArr.count > 0) {
            NSInteger index = [self.CityPickerView selectedRowInComponent:1];
            
            self.index = index;
            //                        NSLog(@"%@",self.cityArr);
            NSDictionary *dict = self.cityArr[index];
            //            NSLog(@"%@",dict);
            NSString *indexTown = dict[@"cityId"];
            //            NSLog(@"%@",indexTown);
            [self getTown:indexTown];
            [self.CityPickerView reloadAllComponents];
            
            [self.CityPickerView selectRow:0 inComponent:2 animated:YES];
            
        }
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        NSLog(@"%@",error);
    }];
}
#pragma mark - 获取区的数据
- (void)getTown:(NSString *)index{
    NSDictionary *dict = @{@"cityId":index};
    [self.manager POST:@"http://120.26.87.168:8080/cafe/api/common/getCountyByCityId" parameters:dict progress:nil success:^(NSURLSessionDataTask * _Nonnull task, id  _Nullable responseObject) {
        self.townArr = responseObject[@"result"];
        
        [self.CityPickerView reloadAllComponents];
        
    } failure:^(NSURLSessionDataTask * _Nullable task, NSError * _Nonnull error) {
        
    }];
}


- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView{
    
    return 3;
}
- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    if (component == 0) {
        return self.proArr.count;
    }else if (component == 1){
        return self.cityArr.count;
    }else{
        return self.townArr.count;
    }
}



//返回第一行展示的标题
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component{
    
    //如果是第0列,就是省份,返回省份的名称
    if (component == 0) {
       
        return self.proArr[row][@"provinceName"];
    }else if(component == 1){
        
        return self.cityArr[row][@"cityName"];
    }else{
//        NSDictionary *dict = self.cityArr[self.index];
//        
//        NSString *indexTown = dict[@"cityId"];
//        [self getTown:indexTown];
        
        return self.townArr[row][@"countyName"];
    }
    
}
-(void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component{
    
    if (component == 0) {
        NSInteger index2 = [pickerView selectedRowInComponent:0];
        NSDictionary *dci = self.proArr[index2];
//        NSLog(@"%@",dci);
        //            省的数据
        NSString *indexCity = dci[@"provinceId"];
        
        //            获取市的数据
//        self.cityArr = nil;
        [self getCity:indexCity];
//        [pickerView reloadAllComponents];
        [pickerView selectRow:0 inComponent:1 animated:YES];
        
        //            获取选的第几个市
        
        

    }
    
    if (component == 1) {
        NSInteger index = [pickerView selectedRowInComponent:1];
        
        self.index = index;
        NSDictionary *dict = self.cityArr[index];
        
        NSString *indexTown = dict[@"cityId"];
        [self getTown:indexTown];
//        [pickerView reloadComponent:2];
        
        [pickerView selectRow:0 inComponent:2 animated:YES];
        
        
    

    }
}


@end
