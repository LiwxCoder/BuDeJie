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

/** 对外提供接口方法type方法,让子类重写 */
- (WXTopicType)type;

@end
