//
//  XYPaymentListView.m
//  智慧党建
//
//  Created by 韩智杰 on 2019/2/23.
//  Copyright © 2019年 韩智杰. All rights reserved.
//

#import "XYPaymentListView.h"
#import "XYPaymentCell.h"

@interface XYPaymentListView()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation XYPaymentListView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.dataSource = self;
        self.delegate = self;
        self.tableFooterView = [UIView new];
    }
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 6;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    XYPaymentCell * cell = [tableView dequeueReusableCellWithIdentifier:@"XYPaymentCell"];
    if (!cell) {
        cell = [[XYPaymentCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"XYPaymentCell"];
    }
    cell.titleLabel.text = [NSString stringWithFormat:@"%ld月份党费",(long)indexPath.row];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSString * URLStr = @"XYHome://Home/XYPaymentDetailController/scheme=0";
    NSString * URLS = [URLStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSURL * URL = [NSURL URLWithString:URLS];
    [[UIApplication sharedApplication] openURL:URL options:[NSDictionary dictionary] completionHandler:nil];
}

@end
