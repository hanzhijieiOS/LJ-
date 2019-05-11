//
//  XYExamHistoryTableView.m
//  智慧党建
//
//  Created by 韩智杰 on 2019/5/11.
//  Copyright © 2019年 韩智杰. All rights reserved.
//

#import "XYExamHistoryTableView.h"
#import "XYExamHistoryCell.h"
#import "XYExamScoreItemModel.h"

@interface XYExamHistoryTableView()

@property (nonatomic, copy) NSArray <XYExamScoreItemModel *> * dataArray;

@end

@implementation XYExamHistoryTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        [self registerClass:[XYExamHistoryCell class] forCellReuseIdentifier:@"XYExamHistoryCell"];
    }
    return self;
}

- (void)updateContentWithData:(NSArray<XYExamScoreItemModel *> *)data{
    self.dataArray = data;
    [self reloadData];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    XYExamHistoryCell * cell = [tableView dequeueReusableCellWithIdentifier:@"XYExamHistoryCell" forIndexPath:indexPath];
    [cell updateContentWithData:self.dataArray[indexPath.row]];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [XYExamHistoryCell getCellHeightWithData:self.dataArray[indexPath.row]];
}


@end
