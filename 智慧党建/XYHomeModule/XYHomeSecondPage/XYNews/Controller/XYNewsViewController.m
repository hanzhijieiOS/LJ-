//
//  XYNewsViewController.m
//  智慧党建
//
//  Created by 韩智杰 on 2019/5/9.
//  Copyright © 2019年 韩智杰. All rights reserved.
//

#import "XYNewsViewController.h"
#import "XYNewsTableView.h"
#import "XYNewsMainScrollerView.h"
#import "XYNewsScrollView.h"
#import "XYNewsManager.h"
#import "XYNewsItemModel.h"

@interface XYNewsViewController ()<XYNewsScrollViewDelegate, UIScrollViewDelegate>

@property (nonatomic, strong) XYNewsScrollView * itemScrollView;

@property (nonatomic, strong) XYNewsMainScrollerView * mainScrollView;

@property (nonatomic, copy) NSArray <XYNewsItemModel *> * modelArray;

@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) NSMutableArray *newsList;

@property (nonatomic, assign) CGRect viewRect;
@property (nonatomic, strong) NSMutableArray *titleArray;
@property (nonatomic, strong) NSMutableArray *subViewsArray;

@end

@implementation XYNewsViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.navigationItem.title = @"资讯阅览";
    [self showLoadingAnimation];
    self.titleArray = [NSMutableArray array];
    [[XYNewsManager sharedManager] fetchAllNewsItemWithSuccessBlock:^(NSArray<XYNewsItemModel *> *data) {
        self.modelArray = data;
        for (XYNewsItemModel * model in data) {
            [self.titleArray addObject:model.columnName];
        }
        [self initUI];
    } errorBlock:^(NSError * _Nullable error) {
        [self showEmpty];
    }];
}

- (void)initUI{
    _itemScrollView = [[XYNewsScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40)];
    _itemScrollView.titleArray = _titleArray ;
    _itemScrollView.HZJDelegate = self;
    _mainScrollView = [[XYNewsMainScrollerView alloc] initWithFrame:CGRectMake(0, _itemScrollView.frame.size.height, self.view.frame.size.width, self.view.frame.size.height - _itemScrollView.frame.size.height) array:_titleArray];
    _mainScrollView.delegate = self;
    _mainScrollView.showsVerticalScrollIndicator = NO;
    _mainScrollView.showsHorizontalScrollIndicator = NO;
    [self.view addSubview:_itemScrollView];
    [self.view addSubview:_mainScrollView];
    __weak typeof (_mainScrollView)weakScrollView = _mainScrollView;
    [_itemScrollView setTapItemWithIndex:^(NSInteger index,BOOL animation){
        [weakScrollView scrollRectToVisible:CGRectMake(index * weakScrollView.frame.size.width, 0.0, weakScrollView.frame.size.width,weakScrollView.frame.size.height) animated:animation];
    }];
    
    CGRect statusHeight = [[UIApplication sharedApplication] statusBarFrame];
    CGFloat naviHeight = self.navigationController.navigationBar.frame.size.height;
    CGFloat tabBarHeight = [[UITabBarController alloc] init].tabBar.frame.size.height;
    self.viewRect = CGRectMake(0, 0, self.view.frame.size.width, [UIScreen mainScreen].bounds.size.height - 40 - statusHeight.size.height - naviHeight - tabBarHeight);
    XYNewsTableView * tableView = [[XYNewsTableView alloc] initWithFrame:self.viewRect style:UITableViewStylePlain];
    [self.mainScrollView addSubview:tableView];
    self.subViewsArray = [NSMutableArray array];
    for (int i = 0; i < _titleArray.count; i ++) {
        self.subViewsArray[i] = [NSNumber numberWithBool:0];
        self.dataArray[i] = [NSNumber numberWithBool:0];
    }
    self.subViewsArray[0] = tableView;
    [[XYNewsManager sharedManager] fetchNewsListWithColumnId:(NSInteger)(self.modelArray[0].id) successBlock:^(NSArray<XYNewsListItemModel *> *data) {
        [tableView updateContentWithDataList:data];
        [self stopLoadingAnimation];
    } failureBlock:^(NSError * _Nullable error) {
        [self stopLoadingAnimation];
        [self showEmpty];
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)newsScrollViewDidChangePage:(NSInteger)index{
    if (self.subViewsArray[index] == [NSNumber numberWithBool:0]) {
        
        XYNewsTableView *newsTableView = [[XYNewsTableView alloc] initWithFrame:CGRectMake(index *self.view.frame.size.width, 0, self.view.frame.size.width, self.viewRect.size.height) style:UITableViewStylePlain];
        [self.mainScrollView addSubview:newsTableView];
        self.subViewsArray[index] = newsTableView;
        [[XYNewsManager sharedManager] fetchNewsListWithColumnId:(NSInteger)(self.modelArray[index].id) successBlock:^(NSArray<XYNewsListItemModel *> *data) {
            [newsTableView updateContentWithDataList:data];
        } failureBlock:^(NSError * _Nullable error) {
            
        }];
//            [[HZJNewsManager defaultInstance] fetchNewsListWithTyle:self.titleArray2[index] succeed:^(NSMutableArray<HZJNewsItemModel> * _Nonnull newsList) {
//                NSLog(@"%@",newsList);
//                self.dataArray[index] = newsList;
//                [newsTableView updateViewWithNewsItemModel:newsList];
//            } error:^(NSError * _Nullable error) {
//
//            }];
    }
}

- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView == self.mainScrollView) {
        float offset = scrollView.contentOffset.x;
        offset = offset/CGRectGetWidth(scrollView.frame);
        [_itemScrollView moveToIndex:offset];
    }
}

@end
