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
    
    // 方法二: 必须在[super viewDidLoad]之前设置类型
    self.type = WXTopicTypeWord;
    
    [super viewDidLoad];
    
}

@end
