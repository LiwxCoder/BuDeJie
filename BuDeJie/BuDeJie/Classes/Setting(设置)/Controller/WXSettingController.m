//
//  WXSettingController.m
//  BuDeJie
//
//  Created by liwx on 16/1/19.
//  Copyright © 2016年 liwx. All rights reserved.
//

#import "WXSettingController.h"
#import "WXFileCacheManager.h"
#import <SDImageCache.h>
#import <SVProgressHUD.h>

static NSString * const ID = @"cell";

@interface WXSettingController ()

/** 缓存总大小 */
@property (nonatomic, assign) NSInteger totalSize;

@end

@implementation WXSettingController

#pragma =======================================================================
#pragma mark - 系统方法重写

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    // 1.设置右侧跳转按钮
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithTitle:@"jump" style:UIBarButtonItemStyleDone target:self action:@selector(jump)];
    
    // 2.设置标题
    self.navigationItem.title = @"设置";
    
    // 3.注册cell
    [self.tableView registerClass:[UITableViewCell class] forCellReuseIdentifier:ID];
    
    // 4.设置tableView相关属性
    // TODO: 设置多余的没有数据的cell不要分割线
    self.tableView.tableFooterView = [[UIView alloc] init];
    
    
    // ------------------------------------------------------------------------
    // 5.移除获取缓存大小
    // 5.1.获取SDWebImage沙盒缓存路径 NSSearchPathForDirectoriesInDomains最后一个参数: 是否展开搜索
    NSString *cachePath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) lastObject];
    // 5.2 拼接缓存全路径
    NSString *defaultPath = [cachePath stringByAppendingPathComponent:@"default"];
    
    // 5.3 提示正在计算
    [SVProgressHUD showWithStatus:@"正在计算缓存..."];
    
    // 5.3 异步获取缓存大小,使用dispatch_after是为了模拟正在计算缓存大小
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        [WXFileCacheManager getCacheSizeOfDirectoriesPath:defaultPath completeBlock:^(NSInteger totalSize) {
            // 1.获取缓存总大小,重新刷新表格
            self.totalSize = totalSize;
            NSIndexPath *indexPath = [NSIndexPath indexPathForRow:0 inSection:0];
            [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
            
            // 2.移除提示HUD
            [SVProgressHUD dismiss];
        }];
    });
    
}

// ----------------------------------------------------------------------------
// 监听跳转按钮点击
- (void)jump
{
    UIViewController *vc = [[UIViewController alloc] init];
    
    // 必须设置背景色,不然会push时会出现黑色卡顿现象
    vc.view.backgroundColor = [UIColor redColor];
    
    [self.navigationController pushViewController:vc animated:YES];
}

#pragma =======================================================================
#pragma mark - UITableViewDataSource,UITableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    // 1.从缓冲池获取cell,之前已注册,所以无需再判断cell是否为空
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    
    // 2.设置数据
    cell.textLabel.text = [self getCacheStr];
    
    return cell;
}

// ----------------------------------------------------------------------------
// 选中第0行执行清除
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row == 0) {
        
        // 删除SDWebImage的缓存路径(沙盒中的default路径)
        NSString *cachePath = NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES)[0];
        NSString *defaultPath = [cachePath stringByAppendingPathComponent:@"default"];
        [SVProgressHUD showWithStatus:@"正在清理缓存..."];
        // 模拟清理缓存,使用dispatch_after延迟,实际应用不需要延迟执行dispatch_after
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(0.5 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            [WXFileCacheManager removeDirectoriesPath:defaultPath completeBlock:^{
                // 隐藏指示器
                [SVProgressHUD dismiss];
                
                // 总数清零
                self.totalSize = 0;
                // 刷新表格
                [self.tableView reloadRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationNone];
            }];
        });
    }
}



#pragma =======================================================================
#pragma mark - 缓存处理

// ------------------------------------------------------------------------
// 拼接显示缓存大小字符串
- (NSString *)getCacheStr
{
    NSString *cacheStr = @"清空缓存";
    if (self.totalSize >= (1000 * 1000)) {
        cacheStr = [NSString stringWithFormat:@"%@: (%.1f)MB", cacheStr, self.totalSize / (1000 * 1000.0)];
        cacheStr = [cacheStr stringByReplacingOccurrencesOfString:@".0" withString:@""];
    } else if (self.totalSize >= 1000) {
        cacheStr = [NSString stringWithFormat:@"%@: (%.1f)KB", cacheStr, self.totalSize / 1000.0];
        cacheStr = [cacheStr stringByReplacingOccurrencesOfString:@".0" withString:@""];
    } else if (self.totalSize > 0) {
        cacheStr = [NSString stringWithFormat:@"%@: (%ld)B", cacheStr, self.totalSize];
    }
    return cacheStr;
}

// ----------------------------------------------------------------------------
// 计算SDWebImage的缓存
- (void)getSDWebImageCacheSize
{
    // 1.获取SDWebImage缓存大小,用于对比自己计算的缓存大小是否正确
    NSUInteger cacheSize = [[SDImageCache sharedImageCache] getSize];
    
    NSLog(@"cacheSize: %ld", cacheSize);
}

@end
