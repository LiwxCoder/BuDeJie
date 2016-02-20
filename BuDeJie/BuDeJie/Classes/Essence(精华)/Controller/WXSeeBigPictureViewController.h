//
//  WXSeeBigPictureViewController.h
//  BuDeJie
//
//  Created by liwx on 16/2/20.
//  Copyright © 2016年 liwx. All rights reserved.
//

#import <UIKit/UIKit.h>
@class WXTopicItem;

@interface WXSeeBigPictureViewController : UIViewController

/** 由外界传递模型 */
@property (nonatomic, strong) WXTopicItem *topicItem;

@end
