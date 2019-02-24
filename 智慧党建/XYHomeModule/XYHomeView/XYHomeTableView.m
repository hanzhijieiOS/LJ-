//
//  XYHomeTableView.m
//  智慧党建
//
//  Created by 韩智杰 on 2019/1/2.
//  Copyright © 2019年 韩智杰. All rights reserved.
//

#import "XYHomeTableView.h"
#import "SDCycleScrollView.h"
#import "XYHomeCollectionCell.h"
#import "XYCycleScrollViewCell.h"
#import "XYHomeNewsCell.h"

@interface XYHomeTableView()<UITableViewDelegate, UITableViewDataSource, SDCycleScrollViewDelegate>

@end

@implementation XYHomeTableView

static NSString * collectionCellID = @"XYHomeCollectionCell";
static NSString * cycleCellID = @"XYCycleScrollViewCell";

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.dataSource = self;
        self.delegate = self;
        self.tableFooterView = [UIView new];
        self.separatorStyle = UITableViewCellSeparatorStyleSingleLine;
        [self initializeTableHeaderView];
    }
    return self;
}

- (void)initializeTableHeaderView{
    SDCycleScrollView *cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectMake(0, 280, self.width, 180) delegate:self placeholderImage:[XYUtils imageWithColor:[UIColor lightGrayColor]]];
    cycleScrollView.pageControlAliment = SDCycleScrollViewPageContolAlimentRight;
    cycleScrollView.currentPageDotColor = [UIColor whiteColor];
    cycleScrollView.autoScrollTimeInterval = 3.0;
    
    {
        NSArray *imagesURLStrings = @[
                                      @"https://ss2.baidu.com/-vo3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a4b3d7085dee3d6d2293d48b252b5910/0e2442a7d933c89524cd5cd4d51373f0830200ea.jpg",
                                      @"https://ss0.baidu.com/-Po3dSag_xI4khGko9WTAnF6hhy/super/whfpf%3D425%2C260%2C50/sign=a41eb338dd33c895a62bcb3bb72e47c2/5fdf8db1cb134954a2192ccb524e9258d1094a1e.jpg",
                                      @"http://c.hiphotos.baidu.com/image/w%3D400/sign=c2318ff84334970a4773112fa5c8d1c0/b7fd5266d0160924c1fae5ccd60735fae7cd340d.jpg"
                                      ];
        cycleScrollView.imageURLStringsGroup = imagesURLStrings;
    }
    self.tableHeaderView = cycleScrollView;
}

#pragma mark - UITableViewDataSource

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    XYBaseTableViewCell * cell = nil;
    if (indexPath.row == 0) {
        cell = [tableView dequeueReusableCellWithIdentifier:collectionCellID];
        if (!cell) {
            cell = [[XYHomeCollectionCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:collectionCellID];
        }
    }else if (indexPath.row == 1){
        cell = [tableView dequeueReusableCellWithIdentifier:cycleCellID];
        if (!cell) {
            cell = [[XYCycleScrollViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cycleCellID];
        }
    }else if (indexPath.row >= 2){
        cell = [tableView dequeueReusableCellWithIdentifier:@"XYHomeNewsCell"];
        if (!cell) {
            cell = [[XYHomeNewsCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"XYHomeNewsCell"];
        }
    }
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return 5;
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 1;
}

#pragma mark - UITableViewDelegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row == 0) {
        return [XYHomeCollectionCell getCellHeightWithData:nil];
    }else if (indexPath.row == 1){
        return [XYCycleScrollViewCell getCellHeightWithData:nil];
    }
    return [XYHomeNewsCell getCellHeightWithData:nil];
}

#pragma mark - SDCycleScrollViewDelegate

- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
