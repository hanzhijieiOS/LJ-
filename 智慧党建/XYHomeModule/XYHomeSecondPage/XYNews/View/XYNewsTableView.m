//
//  XYNewsTableView.m
//  智慧党建
//
//  Created by 韩智杰 on 2019/5/9.
//  Copyright © 2019年 韩智杰. All rights reserved.
//

#import "XYNewsTableView.h"
#import "XYNewsCell.h"
#import "XYNewsListItemModel.h"

@interface XYNewsTableView()

@property (nonatomic, copy) NSArray <XYNewsListItemModel *> * dataArray;

@end

@implementation XYNewsTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        [self registerClass:[XYNewsCell class] forCellReuseIdentifier:@"XYNewsCell"];
    }
    return self;
}

- (void)updateContentWithDataList:(NSArray<XYNewsListItemModel *> *)data{
    self.dataArray = data;
    [self reloadData];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    XYNewsCell * cell = [tableView dequeueReusableCellWithIdentifier:@"XYNewsCell" forIndexPath:indexPath];
    [cell updateContentWithData:self.dataArray[indexPath.row]];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [XYNewsCell getCellHeightWithData:self.dataArray[indexPath.row]];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:NO];
}

@end
