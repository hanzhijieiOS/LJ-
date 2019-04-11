//
//  XYBaseViewController.m
//  智慧党建
//
//  Created by 韩智杰 on 2018/12/16.
//  Copyright © 2018年 韩智杰. All rights reserved.
//

#import "XYBaseViewController.h"
#import "XYAnimationView.h"

@interface XYBaseViewController ()

@property (nonatomic, strong) XYAnimationView * animationView;
@property (nonatomic, strong) UIView * emptyView;
@property (nonatomic, strong) UIImageView * emptyImgView;
@property (nonatomic, strong) UILabel * emptyLabel;

@end

@implementation XYBaseViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor colorWithRed:245/255.0 green:245/255.0 blue:245/255.0 alpha:1];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];
    [self.navigationController.navigationBar setTitleTextAttributes:@{NSForegroundColorAttributeName : [UIColor whiteColor]}];
}

- (UIStatusBarStyle)preferredStatusBarStyle{
    return UIStatusBarStyleLightContent;
}

- (void)showLoadingAnimation{
    [self.view addSubview:self.animationView];
    [self.animationView start];
}

- (void)stopLoadingAnimation{
    [self.animationView stop];
    [self.animationView removeFromSuperview];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    [[SDImageCache sharedImageCache] clearMemory];
}

- (void)showEmpty{
    [self.view addSubview:self.emptyView];
}

- (void)reloadData{
    [_emptyView removeFromSuperview];
    [self showLoadingAnimation];
    /**
     * 子类重写
     */
    NSLog(@"reloadData");
}

- (void)viewDidLayoutSubviews{
    [super viewDidLayoutSubviews];
    CGRect rect = _animationView.frame;
    rect.origin.y -= self.view.origin.y;
    [_animationView setFrame:rect];
}

- (XYAnimationView *)animationView{
    if (!_animationView) {
        _animationView = [[XYAnimationView alloc] initWithFrame:self.view.bounds];
        [self.view addSubview:_animationView];
    }
    return _animationView;
}

- (UIView *)emptyView{
    if (!_emptyView) {
        _emptyView = [[UIView alloc] initWithFrame:self.view.bounds];
        _emptyView.backgroundColor = [UIColor whiteColor];
        [_emptyView addSubview:self.emptyImgView];
        [_emptyView addSubview:self.emptyLabel];
        UITapGestureRecognizer * tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(reloadData)];
        [_emptyView addGestureRecognizer:tapGR];
    }
    return _emptyView;
}

- (UIImageView *)emptyImgView{
    if (!_emptyImgView) {
        _emptyImgView = [[UIImageView alloc] initWithFrame:CGRectMake((self.view.width - 250) / 2.0, 100, 250, 250)];
        _emptyImgView.image = [UIImage imageNamed:@"empty"];
        _emptyImgView.backgroundColor = [UIColor whiteColor];
        _emptyImgView.userInteractionEnabled = YES;
    }
    return _emptyImgView;
}

- (UILabel *)emptyLabel{
    if (!_emptyLabel) {
        _emptyLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, self.emptyImgView.bottom + 10, self.view.width, 20)];
        _emptyLabel.backgroundColor = [UIColor whiteColor];
        _emptyLabel.text = @"空空如也,点击重试";
        _emptyLabel.textAlignment = NSTextAlignmentCenter;
        _emptyLabel.textColor = [UIColor grayColor];
    }
    return _emptyLabel;
}

@end
