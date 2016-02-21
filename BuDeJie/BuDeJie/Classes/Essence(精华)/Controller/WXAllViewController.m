//
//  WXAllViewController.m
//  BuDeJie
//
//  Created by liwx on 16/1/26.
//  Copyright © 2016年 liwx. All rights reserved.
//

#import "WXAllViewController.h"

@interface WXAllViewController ()

@end

@implementation WXAllViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

// ----------------------------------------------------------------------------
// 子类重写父类的type方法
- (WXTopicType)type
{
    return WXTopicTypeAll;
}

@end
