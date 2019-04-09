//
//  XYRegisterController.m
//  智慧党建
//
//  Created by jaycehan(韩智杰) on 2019/3/10.
//  Copyright © 2019年 韩智杰. All rights reserved.
//

#import "XYRegisterController.h"
#import "XYRegisterView.h"
@interface XYRegisterController ()

@property (nonatomic, strong) XYRegisterView * registerView;
@property (nonatomic, strong) UIImageView * bgImage;

@end

@implementation XYRegisterController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"注册";
    [self.view addSubview:self.bgImage];
    self.registerView = [[XYRegisterView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:self.registerView];
}

- (UIImageView *)bgImage{
    if (!_bgImage) {
        _bgImage = [[UIImageView alloc] initWithFrame:CGRectMake(0, 50, self.view.width, self.view.width)];
        _bgImage.image = [UIImage imageNamed:@"dl_danghui.png"];
        _bgImage.backgroundColor = [UIColor whiteColor];
        _bgImage.alpha = 0.2;
    }
    return _bgImage;
}

@end
