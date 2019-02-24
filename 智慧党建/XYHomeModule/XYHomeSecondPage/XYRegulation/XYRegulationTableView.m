//
//  XYRegulationTableView.m
//  智慧党建
//
//  Created by jaycehan(韩智杰) on 2019/2/24.
//  Copyright © 2019年 韩智杰. All rights reserved.
//

#import "XYRegulationTableView.h"
#import "XYRegulationCell.h"

@interface XYRegulationTableView ()<UITableViewDelegate, UITableViewDataSource>

@end

@implementation XYRegulationTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if (self) {
        [self registerClass:NSClassFromString(@"XYRegulationCell") forCellReuseIdentifier:[XYRegulationCell getCellIdentifierWithData:nil]];
        self.dataSource = self;
        self.delegate = self;
    }
    return self;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    XYRegulationCell * cell = [tableView dequeueReusableCellWithIdentifier:[XYRegulationCell getCellIdentifierWithData:nil] forIndexPath:indexPath];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [XYRegulationCell getCellHeightWithData:nil];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
