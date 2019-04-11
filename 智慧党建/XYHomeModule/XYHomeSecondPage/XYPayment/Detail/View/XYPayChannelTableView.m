//
//  XYPayChannelTableView.m
//  智慧党建
//
//  Created by jaycehan(韩智杰) on 2019/4/10.
//  Copyright © 2019年 韩智杰. All rights reserved.
//

#import "XYPayChannelTableView.h"
#import "XYPayChannelCell.h"

@interface XYPayChannelTableView ()

@property (nonatomic, assign) NSInteger paySchema;

@property (nonatomic, copy) NSArray * schemaArray;

@end

@implementation XYPayChannelTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
        self.separatorStyle = UITableViewCellSeparatorStyleNone;
        self.tableFooterView = [UIView new];
        [self addTableHeaderView];
        self.schemaArray = [NSArray arrayWithObjects:@"微信支付", @"支付宝支付", nil];
    }
    return self;
}

- (void)addTableHeaderView{
    UIView * header = [[UIView alloc] initWithFrame:CGRectMake(0, 0, SCREENWIDTH, 30)];
    UILabel * label = [[UILabel alloc] initWithFrame:CGRectMake(K_LeftGap, 5, SCREENWIDTH, 20)];
    [header addSubview:label];
    label.text = @"支付方式";
    self.tableHeaderView = header;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 2;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    XYPayChannelCell * cell = [tableView dequeueReusableCellWithIdentifier:[XYPayChannelCell getCellIdentifierWithData:nil]];
    if (!cell) {
        cell = [[XYPayChannelCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:[XYPayChannelCell getCellIdentifierWithData:nil]];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    [cell reloadCellWithData:self.schemaArray[indexPath.row]];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [XYPayChannelCell getCellHeightWithData:nil];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    /* 因cell个数较少 这里使用visibleCells来充当所有cell */
    for (XYPayChannelCell * cell in self.visibleCells) {
        [cell removeSelectStatus];
    }
    XYPayChannelCell * cell = [tableView cellForRowAtIndexPath:indexPath];
    [cell setSelectStatus];
    self.paySchema = indexPath.row;
}

@end
