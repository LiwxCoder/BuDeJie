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
    
    // 方法二: 必须在[super viewDidLoad]之前设置类型
    self.type = WXTopicTypeAll;
    
    [super viewDidLoad];
    
}

@end
