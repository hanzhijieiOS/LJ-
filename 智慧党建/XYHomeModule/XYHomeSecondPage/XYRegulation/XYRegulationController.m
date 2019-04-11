//
//  XYRegulationController.m
//  智慧党建
//
//  Created by jaycehan(韩智杰) on 2019/2/24.
//  Copyright © 2019年 韩智杰. All rights reserved.
//

#import "XYRegulationController.h"
#import "XYRegulationTopView.h"
#import "XYRegulationTableView.h"
#import "XYRegulationModel.h"

@interface XYRegulationController ()<XYRegulationTopViewDelegate>

@property (nonatomic, strong) XYRegulationTopView * topView;
@property (nonatomic, strong) XYRegulationTableView * tableView;
@property (nonatomic, strong) XYRegulationModel * chapterModel;
@property (nonatomic, strong) XYRegulationModel * ruleModel;

@end

@implementation XYRegulationController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.topView = [[XYRegulationTopView alloc] initWithFrame:CGRectMake(0, 0, self.view.bounds.size.width, 50)];
    self.topView.delegate = self;
    [self.view addSubview:self.topView];
    [self initModel];
    self.tableView = [[XYRegulationTableView alloc] initWithFrame:CGRectMake(0, 58, self.view.bounds.size.width, self.view.bounds.size.height - 58 - kNavBarHeight) style:UITableViewStylePlain];
    [self.view addSubview:self.tableView];
    [self.tableView reloadDataWithData:self.chapterModel];
}

- (void)regulationTopViewDidSelectWithIndex:(NSInteger)index{
    switch (index) {
        case 0:
            [self.tableView reloadDataWithData:self.chapterModel];
            break;
        case 1:
            [self.tableView reloadDataWithData:self.ruleModel];
            break;
        default:
            break;
    }
}

- (void)initModel{
    self.chapterModel = [[XYRegulationModel alloc] init];
    self.chapterModel.titleAry = [NSArray arrayWithObjects:@"中国共产党章程（2017年修改）", @"中国共产党章程（2012年修改）", @"中国共产党章程（2007年修改）", @"中国共产党章程（2002年修改）", @"中国共产党章程（1997年修改）", @"中国共产党章程（1992年修改）", @"中国共产党章程（1987年修改）", @"中国共产党章程（1982年修改）", nil];
    self.chapterModel.URLAry = [NSArray arrayWithObjects:@"http://www.12371.cn/special/zggcdzc/zggcdzcqw/", @"http://news.12371.cn/2012/11/18/ARTI1353240237279676.shtml", @"http://news.12371.cn/2015/03/11/ARTI1426056999129192.shtml", @"http://news.12371.cn/2015/03/11/ARTI1426058071921337.shtml", @"http://news.12371.cn/2015/03/11/ARTI1426058924024547.shtml", @"http://fuwu.12371.cn/2014/12/24/ARTI1419399356558735.shtml", @"http://fuwu.12371.cn/2014/12/24/ARTI1419399131052717.shtml", @"http://fuwu.12371.cn/2014/12/24/ARTI1419388285737423.shtml", nil];
    self.chapterModel.subTitleAry = [NSArray arrayWithObjects:@"中国共产党第十九次全国代表大会决议", @"中国共产党第十八次全国代表大会决议", @"中国共产党第十七次全国代表大会决议", @"", @"", @"", @"", @"", nil];
    
    self.ruleModel = [[XYRegulationModel alloc] init];
    self.ruleModel.titleAry = [NSArray arrayWithObjects:@"中国共产党纪律检查机关监督执纪工作规划", @"中国共产党党委（党组）理论学习中心组学习规则", nil];
    self.ruleModel.URLAry = [NSArray arrayWithObjects:@"http://www.12371.cn/2019/01/06/ARTI1546779927287206.shtml", @"http://news.12371.cn/2017/03/30/ARTI1490871148844134.shtml", nil];
    self.ruleModel.subTitleAry = [NSArray arrayWithObjects:@"解读《中国共产党纪律检查机关监督执纪工作规则》", @"中央宣传部负责人就《中国共产党党委（党组）理论学习中心组学习规则》记者答问", nil];
}

@end
