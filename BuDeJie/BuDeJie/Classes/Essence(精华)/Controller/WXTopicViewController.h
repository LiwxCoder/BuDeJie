//
//  WXTopicViewController.h
//  BuDeJie
//
//  Created by liwx on 16/2/21.
//  Copyright © 2016年 liwx. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "WXTopicItem.h"

@interface WXTopicViewController : UITableViewController

// 方法二: 帖子父类控制器对外提供type属性
@property (nonatomic, assign) WXTopicType type;

@end
