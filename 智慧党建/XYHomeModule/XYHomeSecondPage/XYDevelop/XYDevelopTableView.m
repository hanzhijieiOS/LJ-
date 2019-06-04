//
//  XYDevelopTableView.m
//  智慧党建
//
//  Created by 韩智杰 on 2019/5/27.
//  Copyright © 2019年 韩智杰. All rights reserved.
//

#import "XYDevelopTableView.h"
#import "XYDevelopCell.h"
#import "XYDevelopYearCell.h"

@interface XYDevelopTableView()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, copy) NSArray * timeArray;

@property (nonatomic, copy) NSArray * contentArray;

@property (nonatomic, copy) NSArray * yearArray;

@end

@implementation XYDevelopTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.dataSource = self;
        self.delegate = self;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.backgroundColor = [UIColor clearColor];
    }
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.timeArray.count + self.yearArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row % 3 == 0) {
        XYDevelopYearCell * cell = [tableView dequeueReusableCellWithIdentifier:[XYDevelopYearCell getCellIdentifierWithData:nil]];
        if (!cell) {
            cell = [[XYDevelopYearCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[XYDevelopYearCell getCellIdentifierWithData:nil]];
        }
        [cell updateWithTime:self.yearArray[indexPath.row / 3] color:[self getColorByPercent:((CGFloat)indexPath.row / (CGFloat)(self.timeArray.count + self.yearArray.count))]];
        return cell;
        
    }else{
        
        XYDevelopCell * cell = [tableView dequeueReusableCellWithIdentifier:[XYDevelopCell getCellIdentifierWithData:nil]];
        if (!cell) {
            cell = [[XYDevelopCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[XYDevelopCell getCellIdentifierWithData:nil]];
        }
        [cell updateWithContent:self.contentArray[indexPath.row - (indexPath.row / 3) - 1] time:self.timeArray[indexPath.row - (indexPath.row / 3) - 1] color:[self getColorByPercent:((CGFloat)indexPath.row / (CGFloat)(self.timeArray.count + self.yearArray.count))]];
        return cell;
    }
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

- (UIColor*)getColorByPercent:(double)percent {
    NSInteger r   = 0;
    NSInteger b   = 0;
    NSInteger one = 255 + 255;
    if ( percent < 0.5 ) {
        r = one * percent;
        b = 255;
    }
    if ( percent >= 0.5 ) {
        b = 255 - ( (percent - 0.5 ) * one) ;
        r = 255;
    }
    return [UIColor colorWithRed:r / 255.0 green:0 blue:b / 255.0 alpha:1];
}

- (NSArray *)timeArray{
    if (!_timeArray) {
        _timeArray = [NSArray arrayWithObjects:@"09-01", @"10-01", @"01-16", @"08-19", @"07-01", @"09-01", @"11-11", @"12-12", nil];
    }
    return _timeArray;
}

- (NSArray *)contentArray{
    if (!_contentArray) {
        _contentArray = [NSArray arrayWithObjects:@"进入西安邮电大学", @"第一个国庆节", @"进入寒假假期", @"成为预备党员", @"参加建党节活动", @"参加党员会议", @"成为正式党员", @"获得优秀党员称号", nil];
    }
    return _contentArray;
}

- (NSArray *)yearArray{
    if (!_yearArray) {
        _yearArray = [NSArray arrayWithObjects:@"2015年", @"2016年", @"2017年", @"2018年", nil];
    }
    return _yearArray;
}

@end
