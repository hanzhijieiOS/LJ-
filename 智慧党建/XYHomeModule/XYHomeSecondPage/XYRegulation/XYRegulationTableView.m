//
//  XYRegulationTableView.m
//  智慧党建
//
//  Created by jaycehan(韩智杰) on 2019/2/24.
//  Copyright © 2019年 韩智杰. All rights reserved.
//

#import "XYRegulationTableView.h"
#import "XYRegulationCell.h"
#import "XYRegulationCell_V2.h"
#import "XYRegulationModel.h"

@interface XYRegulationTableView ()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) XYRegulationModel * dataModel;

@end

@implementation XYRegulationTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.contentInset = UIEdgeInsetsMake(0, 0, kSafeAreaBottomPaddingHeight, 0);
        [self registerClass:NSClassFromString(@"XYRegulationCell_V2") forCellReuseIdentifier:[XYRegulationCell_V2 getCellIdentifierWithData:nil]];
        self.dataSource = self;
        self.delegate = self;
    }
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataModel.titleAry.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    XYRegulationCell_V2 * cell = [tableView dequeueReusableCellWithIdentifier:[XYRegulationCell_V2 getCellIdentifierWithData:nil] forIndexPath:indexPath];
    [cell updateTitlt:self.dataModel.titleAry[indexPath.row] subTitle:self.dataModel.subTitleAry[indexPath.row]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [XYRegulationCell getCellHeightWithData:nil];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString * URLStr = [NSString stringWithFormat:@"XYHome://Home/XYRegulationDetailController?Scheme=0&URL=%@", self.dataModel.URLAry[indexPath.row]];
    NSString * URLS = [URLStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSURL * URL = [NSURL URLWithString:URLS];
    [[UIApplication sharedApplication] openURL:URL options:[NSDictionary dictionary] completionHandler:nil];
}

- (void)reloadDataWithData:(id)data{
    if (![data isKindOfClass:NSClassFromString(@"XYRegulationModel")]) {
        return;
    }
    self.dataModel = (XYRegulationModel *)data;
    [self reloadData];
    [self setNeedsLayout];
}

@end
