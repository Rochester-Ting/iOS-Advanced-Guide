//
//  LeftTableViewController.h
//  02-饿了么界面布局
//
//  Created by 丁瑞瑞 on 12/7/16.
//  Copyright © 2016年 Rochester. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^tapBlock)(NSString *str);
@interface LeftTableViewController : UITableViewController
/** block*/
@property (nonatomic,copy) tapBlock callBackBlock;
@end
