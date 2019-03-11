//
//  XYMineTableView.m
//  智慧党建
//
//  Created by 韩智杰 on 2019/3/2.
//  Copyright © 2019年 韩智杰. All rights reserved.
//

#import "XYMineTableView.h"
#import "XYMineHeaderView.h"
#import "XYLoginController.h"

@interface XYMineTableView()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, copy) NSArray * dataArray;

@property (nonatomic, strong) XYMineHeaderView * headerView;

@end

@implementation XYMineTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        self.dataArray = [NSArray arrayWithObjects:@"我的申请", @"我的收藏", @"学习档案", @"消息通知", @"版本更新", @"退出登录", nil];
        self.headerView = [[XYMineHeaderView alloc] initWithFrame:CGRectMake(K_LeftGap, K_LeftGap, self.width - 2 * K_LeftGap, 200 - 2 * K_LeftGap)];
        UIView * view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.width, 200)];
        [view addSubview:self.headerView];
        self.tableHeaderView = view;
    }
    return self;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    UITableViewCell * cell = [tableView dequeueReusableCellWithIdentifier:@"XYMineCell"];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"XYMineCell"];
        NSString * imageName = @"";
        if (indexPath.section == 0) {
            cell.textLabel.text = self.dataArray[indexPath.row];
            imageName = [NSString stringWithFormat:@"%@.png",self.dataArray[indexPath.row]];
        }else if (indexPath.section == 1){
            imageName = [NSString stringWithFormat:@"%@.png",self.dataArray[indexPath.row + [self numberOfRowsInSection:0]]];
            cell.textLabel.text = self.dataArray[indexPath.row + [self numberOfRowsInSection:0]];
        }
        cell.imageView.image = [UIImage imageNamed:imageName];
    }
    return cell;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    if (section == 0) {
        return 5;
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
    NSString * URLStr = @"XYMine://Mine/XYLoginController?Scheme=1";
    NSString * URLS = [URLStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSURL * URL = [NSURL URLWithString:URLS];
    [[UIApplication sharedApplication] openURL:URL options:[NSDictionary dictionary] completionHandler:nil];
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
