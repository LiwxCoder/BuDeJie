//
//  WXVideoViewController.m
//  BuDeJie
//
//  Created by liwx on 16/1/26.
//  Copyright © 2016年 liwx. All rights reserved.
//

#import "WXVideoViewController.h"

@interface WXVideoViewController ()

@end

@implementation WXVideoViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    WXFunc();
    
    self.view.backgroundColor = WXRandomColor;
    self.tableView.contentInset = UIEdgeInsetsMake(WXNavMaxY + WXTitlesViewH, 0, WXTabBarH, 0);
    
    // 1.监听通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tabBarButtonDidRepeatClick) name:WXTabBarButtonDidRepeatClickNotification object:nil];
}

#pragma =======================================================================
#pragma mark - 监听tabBarButton重复点击通知
- (void)tabBarButtonDidRepeatClick
{
    NSLog(@"%@: 下拉刷新", [self class]);
}

- (void)dealloc
{
    // 移除通知
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma =======================================================================
#pragma mark - UITableViewDataSource数据源

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return 30;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static UIColor *bgColor = nil;
    if (bgColor == nil) {
        bgColor = WXRandomColor;
    }
    
    static NSString * const ID = @"cell";
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:ID];
        cell.backgroundColor = bgColor;
        cell.textLabel.textColor = [UIColor whiteColor];
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"%02ld. %@", indexPath.row, [self class]];
    
    return cell;
}

@end
