//
//  HZJNewsController.m
//  知途趣闻
//
//  Created by Jay on 2017/10/25.
//  Copyright © 2017年 hanzhijie. All rights reserved.
//

#import "HZJNewsController.h"
#import "HZJScrollView.h"
#import "MainScrollerView.h"

#import "NewsView.h"
#import "HZJCarouseView.h"
#import "NSTimer+HZJUnReturn.h"
#import "HZJNewsManager.h"
#import "HZJNewsDetailController.h"
#import "HZJNewsTableVIew.h"

@interface HZJNewsController ()<UIScrollViewDelegate,UITableViewDelegate,HZJScrollViewDelegate>

@property (nonatomic, strong) HZJScrollView *itemScrollView;
@property (nonatomic, strong) MainScrollerView *mainScrollView;
@property (nonatomic, strong) NSTimer *timer;
@property (nonatomic, strong) NewsView *newsTabeleView;

@property (nonatomic, strong) NSMutableArray *dataArray;
@property (nonatomic, strong) NSMutableArray *newsList;

@property (nonatomic, assign) CGRect viewRect;
@property (nonatomic, copy) NSArray *titleArray;
@property (nonatomic, copy) NSArray *titleArray2;
@property (nonatomic, strong) NSMutableArray *subViewsArray;

@property (nonatomic, assign) BOOL isTimerRunning;

@end

@implementation HZJNewsController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.title = @"热点新闻";
//    self.automaticallyAdjustsScrollViewInsets = NO;
//    self.edgesForExtendedLayout = UIRectEdgeNone;
//    self.navigationController.navigationBar.translucent = NO;
    self.navigationController.navigationBar.barTintColor = [UIColor whiteColor];
    self.view.backgroundColor = [UIColor whiteColor];
    self.isTimerRunning = NO;
    _titleArray = [NSArray arrayWithObjects:@"头条",@"社会",@"国内",@"国际",@"娱乐",@"体育",@"军事",@"科技",@"财经",@"时尚", nil];
    _titleArray2 = [NSArray arrayWithObjects:@"toutiao",@"shehui",@"guonei",@"guoji",@"yule",@"tiyu",@"junshi",@"keji",@"caijing",@"shishang", nil];
    self.dataArray = [NSMutableArray array];
    
    _itemScrollView = [[HZJScrollView alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width, 40)];
    _itemScrollView.titleArray = _titleArray ;
    _itemScrollView.HZJDelegate = self;
    _mainScrollView = [[MainScrollerView alloc] initWithFrame:CGRectMake(0, _itemScrollView.frame.size.height, self.view.frame.size.width, self.view.frame.size.height - _itemScrollView.frame.size.height) array:_titleArray];
    _mainScrollView.delegate = self;
    [self.view addSubview:_itemScrollView];
    [self.view addSubview:_mainScrollView];
    __weak typeof (_mainScrollView)weakScrollView = _mainScrollView;
    [_itemScrollView setTapItemWithIndex:^(NSInteger index,BOOL animation){
        [weakScrollView scrollRectToVisible:CGRectMake(index * weakScrollView.frame.size.width, 0.0, weakScrollView.frame.size.width,weakScrollView.frame.size.height) animated:animation];

    }];
    CGRect statusHeight = [[UIApplication sharedApplication] statusBarFrame];
    CGFloat naviHeight = self.navigationController.navigationBar.frame.size.height;
    CGFloat tabBarHeight = [[UITabBarController alloc] init].tabBar.height;
    self.viewRect = CGRectMake(0, 0, self.view.frame.size.width, [UIScreen mainScreen].bounds.size.height - 40 - statusHeight.size.height - naviHeight - tabBarHeight - kSafeAreaBottomPaddingHeight);
    _newsTabeleView = [[NewsView alloc] initWithFrame:self.viewRect style:UITableViewStylePlain];
    [self.mainScrollView addSubview:_newsTabeleView];
    _newsTabeleView.delegate = self;
    _newsTabeleView.carouseView.delegate = self;
    self.subViewsArray = [NSMutableArray array];
    for (int i = 0; i < _titleArray.count; i ++) {
        self.subViewsArray[i] = [NSNumber numberWithBool:0];
        self.dataArray[i] = [NSNumber numberWithBool:0];
    }
    self.subViewsArray[0] = _newsTabeleView;
    [self addTimerTask];
    [self getNewsListWithType:@"toutiao"];
    
    
    // Do any additional setup after loading the view.
}

- (void)getNewsListWithType:(NSString *)type{
    [self showLoadingAnimation];
    [[HZJNewsManager defaultInstance] fetchNewsListWithTyle:type succeed:^(NSMutableArray<HZJNewsItemModel> * _Nonnull newsList) {
        self.newsList = newsList;
        self.dataArray[0] = newsList;
        [self.newsTabeleView updataDataWithModel:self.newsList];
        [self stopLoadingAnimation];
    } error:^(NSError * _Nullable error) {
        [self stopLoadingAnimation];
        [self showEmpty];
    }];
}

- (void)addTimerTask{
    __weak typeof(self)weakSelf = self;
    self.timer = [NSTimer HZJ_scheduledTimerWithTimerInterval:2.5 repeats:YES block:^(NSTimer *timer) {
        __strong typeof(weakSelf)strongSelf = weakSelf;
        [strongSelf nextImage];
    }];
    self.isTimerRunning = YES;
}

- (void)nextImage{
    if (self.newsTabeleView.pageControl.currentPage == self.newsTabeleView.pageControl.numberOfPages - 1) {
        self.newsTabeleView.pageControl.currentPage = 0;
    }else{
        self.newsTabeleView.pageControl.currentPage ++;
    }
    CGFloat offsetX = self.newsTabeleView.pageControl.currentPage * self.newsTabeleView.carouseView.frame.size.width;
    [UIView animateWithDuration:1.0 animations:^{
        self.newsTabeleView.carouseView.contentOffset = CGPointMake(offsetX, 0);
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Delegate

- (void)HZJScrollViewDidChangePage:(NSInteger)index{
    if (self.subViewsArray[index] == [NSNumber numberWithBool:0]) {
        HZJNewsTableVIew *newsTableView = [[HZJNewsTableVIew alloc] initWithFrame:CGRectMake(index *self.view.frame.size.width, 0, self.view.frame.size.width, self.viewRect.size.height) style:UITableViewStylePlain];
        newsTableView.delegate = self;
        [self.mainScrollView addSubview:newsTableView];
        self.subViewsArray[index] = newsTableView;
        [[HZJNewsManager defaultInstance] fetchNewsListWithTyle:self.titleArray2[index] succeed:^(NSMutableArray<HZJNewsItemModel> * _Nonnull newsList) {
            self.dataArray[index] = newsList;
            [newsTableView updateViewWithNewsItemModel:newsList];
        } error:^(NSError * _Nullable error) {
        }];
    }
}

-(void)scrollViewDidScroll:(UIScrollView *)scrollView{
    if (scrollView == self.newsTabeleView.carouseView) {
        int page = (scrollView.contentOffset.x + scrollView.frame.size.width / 2)/ scrollView.frame.size.width;
        self.newsTabeleView.pageControl.currentPage = page;
    }
    if (scrollView == self.newsTabeleView) {
        if (scrollView.contentOffset.y > 400) {
            if (self.isTimerRunning) {
                [self.timer setFireDate:[NSDate distantFuture]];
                self.isTimerRunning = NO;
            }
        }else{
            if (!self.isTimerRunning) {
                [self.timer setFireDate:[NSDate distantPast]];
                self.isTimerRunning = YES;
            }
        }
    }
    if (scrollView == self.mainScrollView) {
        float offset = scrollView.contentOffset.x;
        offset = offset/CGRectGetWidth(scrollView.frame);
        [_itemScrollView moveToIndex:offset];
    }
}

- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView{
    if (scrollView == self.newsTabeleView.carouseView) {
        [self.timer invalidate];
    }
    if ([scrollView isKindOfClass:[NewsView class]]) {
        [((NewsView *)scrollView).needLoadArray removeAllObjects];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView{
    if (scrollView == self.newsTabeleView.carouseView) {
        [self addTimerTask];
    }
    if (scrollView == self.mainScrollView) {
        float offset = scrollView.contentOffset.x;
        offset = offset/CGRectGetWidth(scrollView.frame);
        [_itemScrollView endMoveToIndex:offset];
    }
}

- (BOOL)scrollViewShouldScrollToTop:(UIScrollView *)scrollView{
    if ([scrollView isKindOfClass:[NewsView class]]) {
        ((NewsView *)scrollView).scrollToToping = YES;
    }
    return YES;
}

- (void)scrollViewDidScrollToTop:(UIScrollView *)scrollView{
    if ([scrollView isKindOfClass:[NewsView class]]) {
        ((NewsView *)scrollView).scrollToToping = NO;
        [(NewsView *)scrollView loadContent];
    }
}

- (void)scrollViewDidEndScrollingAnimation:(UIScrollView *)scrollView{
    if ([scrollView isKindOfClass:[NewsView class]]) {
        ((NewsView *)scrollView).scrollToToping = NO;
        [(NewsView *)scrollView loadContent];
    }
}

- (void)scrollViewWillEndDragging:(UIScrollView *)scrollView withVelocity:(CGPoint)velocity targetContentOffset:(inout CGPoint *)targetContentOffset{
    if ([scrollView isKindOfClass:[NewsView class]]) {
        NSIndexPath * indexPath = [(NewsView *)scrollView indexPathForRowAtPoint:CGPointMake(0, targetContentOffset->y)];
        NSIndexPath * cip = [[(NewsView *)scrollView indexPathsForVisibleRows] firstObject];
        NSInteger skinCount = 6;
        if (labs(cip.row - indexPath.row) > skinCount) {
            NSArray *temp = [(NewsView *)scrollView indexPathsForRowsInRect:CGRectMake(0, targetContentOffset->y, scrollView.bounds.size.width, scrollView.bounds.size.height)];
            NSMutableArray *array = [NSMutableArray arrayWithArray:temp];
            if (velocity.y < 0) {
                NSIndexPath * index = [temp lastObject];
                if (index.row + 3 < ((NewsView *)scrollView).count) {
                    [array addObject:[NSIndexPath indexPathForRow:index.row + 1 inSection:0]];
                    [array addObject:[NSIndexPath indexPathForRow:index.row + 2 inSection:0]];
                    [array addObject:[NSIndexPath indexPathForRow:index.row + 3 inSection:0]];
                }
            }else{
                NSIndexPath *index = [temp firstObject];
                if (index.row > 3) {
                    [array addObject:[NSIndexPath indexPathForRow:index.row - 3 inSection:0]];
                    [array addObject:[NSIndexPath indexPathForRow:index.row - 2 inSection:0]];
                    [array addObject:[NSIndexPath indexPathForRow:index.row - 1 inSection:0]];
                }
            }
            [((NewsView *)scrollView).needLoadArray addObjectsFromArray:array];
        }
    }
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
    HZJNewsDetailController *VC = [[HZJNewsDetailController alloc] init];
    HZJNewsItemModel *model = self.dataArray[self.itemScrollView.currentIndex][indexPath.row];
    VC.url = model.url;
    [self.navigationController pushViewController:VC animated:YES];
}

- (void)dealloc{
    [self.timer invalidate];
}

- (NSMutableArray *)newsList{
    if (!_newsList) {
        _newsList = [NSMutableArray array];
    }
    return _newsList;
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
