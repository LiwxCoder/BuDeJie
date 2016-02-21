//
//  WXPictureViewController.m
//  BuDeJie
//
//  Created by liwx on 16/1/26.
//  Copyright © 2016年 liwx. All rights reserved.
//

#import "WXPictureViewController.h"

@interface WXPictureViewController ()

@end

@implementation WXPictureViewController

- (void)viewDidLoad {
    
    // 方法二: 必须在[super viewDidLoad]之前设置类型
    self.type = WXTopicTypePicture;
    
    [super viewDidLoad];
    
}

@end
