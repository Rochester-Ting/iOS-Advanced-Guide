//
//  ViewController.m
//  01-GCD的基础用法
//
//  Created by 丁瑞瑞 on 13/7/16.
//  Copyright © 2016年 Rochester. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
//    异步串行队列
//    [self testAsyncWithSerial];
//    异步并行队列
//    [self testAsyncWithConCurrent];
//    同步串行队列
//    [self testSyncWithSerial];
//    同步并行队列
    [self testSyncWithConCurrent];
}

//异步串行队列:在同一个线程内,按顺序输出,因为是异步所以running的位置不定
- (void)testAsyncWithSerial{
    dispatch_queue_t serial_queue = dispatch_queue_create("www.ruirui.com",DISPATCH_QUEUE_SERIAL);
    for (int i = 0; i < 10; i++) {
        dispatch_async(serial_queue, ^{
            NSLog(@"%zd",i);
            NSLog(@"现在的线程是:%@",[NSThread currentThread]);
        });
        
    }
    NSLog(@"running!!");
}
//异步并行队列:不在同一线程,不按顺序输出
- (void)testAsyncWithConCurrent{
    dispatch_queue_t conCurrent_queue = dispatch_queue_create("www.rurui.com", DISPATCH_QUEUE_CONCURRENT);
    for (int i = 0; i < 10; i++) {
        dispatch_async(conCurrent_queue, ^{
            NSLog(@"%zd",i);
            NSLog(@"当前线程:%@",[NSThread currentThread]);
        });
        
    }
    NSLog(@"running!!!!");
}
//同步串行并列:在同一线程内,按顺序输出,会堵塞
- (void)testSyncWithSerial{
    dispatch_queue_t serial_queue = dispatch_queue_create("www.ruirui.com", DISPATCH_QUEUE_SERIAL);
    for (int i = 0; i < 10; i++) {
        dispatch_sync(serial_queue, ^{
            NSLog(@"%zd",i);
            NSLog(@"当前线程是:%@",[NSThread currentThread]);
        });
    }
    NSLog(@"running!");
}
//同步并行队列:在同一线程内,按顺序输出,会堵塞
- (void)testSyncWithConCurrent{
    dispatch_queue_t conCurrent_queue = dispatch_queue_create("www.ruirui.com", DISPATCH_QUEUE_CONCURRENT);
    for (int i = 0; i < 10; i++) {
        dispatch_sync(conCurrent_queue, ^{
            NSLog(@"%zd",i);
            NSLog(@"当前线程是:%@",[NSThread currentThread]);
        });
    }
    NSLog(@"running!");
}
@end
