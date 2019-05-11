//
//  XYExamTableView.m
//  智慧党建
//
//  Created by 韩智杰 on 2019/4/27.
//  Copyright © 2019年 韩智杰. All rights reserved.
//

#import "XYExamTableView.h"
#import "XYExamListCell.h"
#import "XYExamInfoModel.h"

@interface XYExamTableView()

@property (nonatomic, copy) NSArray <XYExamInfoModel *> * dataArray;

@end

@implementation XYExamTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.dataSource = self;
        self.delegate = self;
        [self registerClass:[XYExamListCell class] forCellReuseIdentifier:@"XYExamListCell"];
    }
    return self;
}

- (void)updateContentWithData:(NSArray<XYExamInfoModel *> *)data{
    self.dataArray = data;
    [self reloadData];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [XYExamListCell getCellHeightWithData:self.dataArray[indexPath.row]];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    NSDictionary * dic = (NSDictionary *)self.dataArray[indexPath.row];
    NSString * urlStr = [NSString stringWithFormat:@"XYHome://Home/ZTHHomeTableViewController?Scheme=0&examID=%@", [dic objectForKey:@"examPaperNum"]];
    NSString * URLS = [urlStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSURL * URL = [NSURL URLWithString:URLS];
    [[UIApplication sharedApplication] openURL:URL options:[NSDictionary dictionary] completionHandler:nil];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    XYExamListCell * cell = [tableView dequeueReusableCellWithIdentifier:@"XYExamListCell" forIndexPath:indexPath];
    [cell updateContentWithData:self.dataArray[indexPath.row]];
    return cell;
}

@end
