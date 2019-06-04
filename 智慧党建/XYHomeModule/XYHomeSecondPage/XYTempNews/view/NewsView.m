//
//  NewsView.m
//  知途趣闻
//
//  Created by Jay on 2017/10/25.
//  Copyright © 2017年 hanzhijie. All rights reserved.
//

#import "NewsView.h"
#import "HZJCarouseView.h"
#import "Masonry.h"
#import "NewsTableViewCell.h"

@interface NewsView()<UITableViewDataSource>

@property (nonatomic, strong) NSMutableArray *dataList;

@end

@implementation NewsView

static NSString * identifier = @"NewsTableViewCell";

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if (self) {
        [self layout];
        self.dataSource = self;
        self.rowHeight = 100;
//        self.needLoadArray = [NSMutableArray array];
        [self registerClass:[NewsTableViewCell class] forCellReuseIdentifier:identifier];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
//    CGSize size = self.contentSize;
//    size.height += kSafeAreaBottomPaddingHeight;
//    self.contentSize = size;
}

- (void)layout{
    self.carouseView = [[HZJCarouseView alloc] initWithFrame:CGRectMake(10, 0, self.frame.size.width, self.frame.size.width * 4 / 7.0)];
    self.carouseView.bounces = NO;
    self.tableHeaderView = self.carouseView;
    self.pageControl = [[UIPageControl alloc] init];
    [self addSubview:self.pageControl];
    [self.pageControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self);
        make.bottom.equalTo(self.carouseView.mas_bottom).with.offset(-5);
        make.width.equalTo(@100);
        make.height.equalTo(@20);
    }];
    self.pageControl.numberOfPages = 5;
    self.pageControl.currentPageIndicatorTintColor = [UIColor blueColor];
    self.pageControl.pageIndicatorTintColor = [UIColor blackColor];
    self.pageControl.currentPage = 0;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NewsTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:identifier forIndexPath:indexPath];
    [cell updateViewWithNewsItemModel:self.dataList[indexPath.row]];
//    [self drawCell:cell withIndexPath:indexPath];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataList.count;
}

- (void)updataDataWithModel:(NSMutableArray*)model{
    self.dataList = model;
//    self.count = self.dataList.count;
    [self reloadData];
    [self setNeedsLayout];
}

- (void)drawCell:(NewsTableViewCell *)cell withIndexPath:(NSIndexPath *)indexPath{
    /*
    cell.data = self.dataList[indexPath.row];
    [cell clearContent];
    if (self.needLoadArray.count > 0 && [self.needLoadArray indexOfObject:indexPath] == NSNotFound) {
        return;
    }
    if (_scrollToToping) {
        return;
    }
    [cell updateViewWithNewsItemModel:self.dataList[indexPath.row]];
     */
}

- (UIView *)hitTest:(CGPoint)point withEvent:(UIEvent *)event{
//    if (!self.scrollToToping) {
//        [self.needLoadArray removeAllObjects];
//        [self loadContent];
//    }
    return [super hitTest:point withEvent:event];
}

- (void)loadContent{
//    if (self.scrollToToping) {
//        return;
//    }
//    if (self.indexPathsForVisibleRows.count <= 0) {
//        return;
//    }
//    if (self.visibleCells && self.visibleCells.count > 0) {
//        for (id temp in self.visibleCells) {
//            NewsTableViewCell * cell = (NewsTableViewCell *)temp;
//            [cell updateViewWithNewsItemModel:nil];
//        }
//    }
}

- (NSMutableArray *)dataList{
    if (!_dataList) {
        _dataList = [NSMutableArray array];
    }
    return _dataList;
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
