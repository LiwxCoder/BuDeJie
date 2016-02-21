//
//  WXWordViewController.m
//  BuDeJie
//
//  Created by liwx on 16/1/26.
//  Copyright © 2016年 liwx. All rights reserved.
//

#import "WXWordViewController.h"

@interface WXWordViewController ()

@end

@implementation WXWordViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
}

// ----------------------------------------------------------------------------
// 子类重写父类的type方法
- (WXTopicType)type
{
    return WXTopicTypeWord;
}

@end
