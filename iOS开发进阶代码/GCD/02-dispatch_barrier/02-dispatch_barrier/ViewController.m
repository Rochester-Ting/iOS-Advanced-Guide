//
//  ViewController.m
//  02-dispatch_barrier
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
    // Do any additional setup after loading the view, typically from a nib.
//    异步栅栏函数
//    [self testBarrierWithAsync];
//    同步栅栏函数
    [self testBarrierWithSync];
}

//dispatch_barrier:栅栏函数,dispatch_barrier前面的任务执行完才会执行dispatch_barrier后面的任务
//1.异步栅栏函数:会开子线程
- (void)testBarrierWithAsync{
    dispatch_queue_t concurrent_queue = dispatch_queue_create("www.ruirui.com", DISPATCH_QUEUE_CONCURRENT);
    for (int i = 0; i < 10; i++) {
        dispatch_async(concurrent_queue, ^{
            NSLog(@"%zd",i);
        });
    }
    for (int j = 0; j < 100000; j++) {
        dispatch_barrier_async(concurrent_queue, ^{
            if (j == 100000 - 1) {
                NSLog(@"barrier finished");
            }
        });
    }
    NSLog(@"running!");
    for (int m = 0; m < 20; m++) {
        dispatch_async(concurrent_queue, ^{
            NSLog(@"%zd",m);
        });
    }
    
}
//同步栅栏函数:在主线程里执行任务
- (void)testBarrierWithSync{
    dispatch_queue_t concurrent_queue = dispatch_queue_create("www.ruirui.com", DISPATCH_QUEUE_CONCURRENT);
    for (int i = 0; i < 10; i++) {
        dispatch_async(concurrent_queue, ^{
            NSLog(@"%zd",i);
        });
    }
    for (int j = 0; j < 100000; j++) {
        dispatch_barrier_sync(concurrent_queue, ^{
            if (j == 100000 - 1) {
                NSLog(@"barrier finished");
            }
        });
    }
    NSLog(@"running!");
    for (int m = 0; m < 20; m++) {
        dispatch_async(concurrent_queue, ^{
            NSLog(@"%zd",m);
        });
    }
    
}
@end
