//
//  WXVoiceViewController.m
//  BuDeJie
//
//  Created by liwx on 16/1/26.
//  Copyright © 2016年 liwx. All rights reserved.
//

#import "WXVoiceViewController.h"

@interface WXVoiceViewController ()

@end

@implementation WXVoiceViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    
    WXFunc();
    
    self.view.backgroundColor = WXRandomColor;
    self.tableView.contentInset = UIEdgeInsetsMake(WXNavMaxY + WXTitlesViewH, 0, WXTabBarH, 0);
    self.tableView.scrollIndicatorInsets = self.tableView.contentInset;
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
