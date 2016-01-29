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
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
    
    // 1.监听通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(tabBarButtonDidRepeatClick) name:WXTabBarButtonDidRepeatClickNotification object:nil];
}

#pragma =======================================================================
#pragma mark - 监听tabBarButton重复点击通知
- (void)tabBarButtonDidRepeatClick
{
    // 如果控制器的view不在window上,则直接返回
    if (self.view.window == nil) {
//        NSLog(@"%@: window = nil", self.class);
        return;
    }
    
    // 如果控制器的view没有和window重叠,则直接返回
    if (![self.view wx_intersectWithView:nil]) {
//        NSLog(@"%@: view没有和window重叠", self.class);
        return;
    }
    
    NSLog(@"%@: 重复点击，执行下拉刷新", [self class]);
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
