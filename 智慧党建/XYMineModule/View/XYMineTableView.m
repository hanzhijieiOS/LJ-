//
//  XYMineTableView.m
//  智慧党建
//
//  Created by 韩智杰 on 2019/3/2.
//  Copyright © 2019年 韩智杰. All rights reserved.
//

#import "XYMineTableView.h"
#import "XYMineHeaderView.h"
#import "XYLoginManager.h"

@interface XYMineTableView()<UITableViewDelegate, UITableViewDataSource, FDActionSheetDelegate>

@property (nonatomic, copy) NSArray * dataArray;

@property (nonatomic, strong) XYMineHeaderView * headerView;

@end

@implementation XYMineTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
//        self.dataArray = [NSArray arrayWithObjects:@"我的申请", @"我的收藏", @"学习档案", @"消息通知", @"版本更新", @"退出登录", nil];
        self.dataArray = [NSArray arrayWithObjects:@"历史成绩", @"清除缓存", @"问题反馈", @"关于我们" ,@"个人信息", @"退出登录", nil];
        self.headerView = [[XYMineHeaderView alloc] initWithFrame:CGRectMake(K_LeftGap, K_LeftGap, self.width - 2 * K_LeftGap, 200 - 2 * K_LeftGap)];
        UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, 200)];
        [view addSubview:self.headerView];
        self.tableHeaderView = view;
        [self.headerView reloadData];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(userLoginStatusDidChange) name:XYUserLoginStatusDidChangeNotification object:nil];
    }
    return self;
}

- (void)refreshMemorySize{
    UITableViewCell * cell = [self cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
    UILabel * tagLabel = (UILabel *)[cell.contentView viewWithTag:19051101];
    tagLabel.text = [NSString stringWithFormat:@"%.2fM", [[SDImageCache sharedImageCache] getSize] / 10000.0];
}

- (void)userLoginStatusDidChange{
    [self reloadData];
    [self.headerView reloadData];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"XYMineCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"XYMineCell"];
        NSString * imageName = @"";
        if (indexPath.section == 0) {
            cell.textLabel.text = self.dataArray[indexPath.row];
            imageName = [NSString stringWithFormat:@"%@.png",self.dataArray[indexPath.row]];
            if (indexPath.row == 1) {
                UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(SCREENWIDTH - 112, 7, 100, 20)];
                label.textAlignment = NSTextAlignmentRight;
                [cell.contentView addSubview:label];
                label.text = [NSString stringWithFormat:@"%.2fM", [[SDImageCache sharedImageCache] getSize] / 10000.0];
                label.tag = 19051101;
            }
        }else if (indexPath.section == 1){
            imageName = [NSString stringWithFormat:@"%@.png",self.dataArray[indexPath.row + [self numberOfRowsInSection:0]]];
            cell.textLabel.text = self.dataArray[indexPath.row + [self numberOfRowsInSection:0]];
        }
        cell.imageView.image = [UIImage imageNamed:imageName];
    }
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1 + [[XYLoginManager sharedManager] isLogin];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return self.dataArray.count - 1 - ![[XYLoginManager sharedManager] isLogin];
    }
    return 1;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 44;
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section{
    if (section == 1) {
        UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 10)];
        view.backgroundColor = [UIColor colorWithRed:245 / 255.0 green:245 / 255.0 blue:245 / 255.0 alpha:1];
        return view;
    }
    return nil;
}

- (CGFloat)tableView:(UITableView *)tableView heightForFooterInSection:(NSInteger)section{
    return 0;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    if (section == 1) {
        return 10;
    }
    return 0;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [self deselectRowAtIndexPath:indexPath animated:YES];
    if (indexPath.section == 0) {
        switch (indexPath.row) {
            case 0:{
                if (![[XYLoginManager sharedManager] isLogin]) {
                    NSString * URLStr = @"XYMine://Mine/XYLoginController?Scheme=1";
                    NSString * URLS = [URLStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
                    NSURL * URL = [NSURL URLWithString:URLS];
                    [[UIApplication sharedApplication] openURL:URL options:[NSDictionary dictionary] completionHandler:nil];
                    return;
                }
                NSString * URLStr = @"XYMine://Mine/XYExamHistoryController?Scheme=0";
                NSString * URLS = [URLStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
                NSURL * URL = [NSURL URLWithString:URLS];
                [[UIApplication sharedApplication] openURL:URL options:[NSDictionary dictionary] completionHandler:nil];
            }
                break;
            case 1:{
                [AppHelper ShowHUDPrompt:@"正在清除缓存...." withParentViewController:nil];
                [[SDImageCache sharedImageCache] clearDiskOnCompletion:^{
                    [AppHelper dismissHUDPromptWithAnimation:NO];
                    UITableViewCell * cell = [tableView cellForRowAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0]];
                    UILabel * tagLabel = (UILabel *)[cell.contentView viewWithTag:19051101];
                    tagLabel.text = @"0.0M";
                    [AppHelper ShowHUDPrompt:@"清理成功!" withParentViewController:nil];
                    [self reloadData];
                }];
            }
                break;
            case 2:{
                NSString * URLStr = @"XYMine://Mine/XYMFeedBackController?Scheme=0";
                NSString * URLS = [URLStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
                NSURL * URL = [NSURL URLWithString:URLS];
                [[UIApplication sharedApplication] openURL:URL options:[NSDictionary dictionary] completionHandler:nil];
            }
                break;
            case 3:{
                NSLog(@"关于我们");
            }
            case 4:{
                NSString * URLStr = @"XYMine://Mine/XYInfomationController?Scheme=0";
                NSString * URLS = [URLStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
                NSURL * URL = [NSURL URLWithString:URLS];
                [[UIApplication sharedApplication] openURL:URL options:[NSDictionary dictionary] completionHandler:nil];
            }
            default:
                break;
        }
    }else if (indexPath.section == 1){
        FDActionSheet * sheet = [[FDActionSheet alloc] initWithTitle:@"确定退出登录吗?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
        [sheet show];
    }

}

- (void)actionSheet:(FDActionSheet *)sheet clickedButtonIndex:(NSInteger)buttonIndex{
    [[NSUserDefaults standardUserDefaults] setBool:NO forKey:XYUserLoginStatus];
    [[NSUserDefaults standardUserDefaults] removeObjectForKey:XYCurrentUserInfo];
    [[NSUserDefaults standardUserDefaults] synchronize];
    [AppHelper ShowHUDPrompt:@"退出成功" withParentViewController:nil];
    [[NSNotificationCenter defaultCenter] postNotificationName:XYUserLoginStatusDidChangeNotification object:nil];
}


@end
