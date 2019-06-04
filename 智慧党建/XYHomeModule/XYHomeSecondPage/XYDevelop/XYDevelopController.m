//
//  XYDevelopController.m
//  智慧党建
//
//  Created by 韩智杰 on 2019/5/26.
//  Copyright © 2019年 韩智杰. All rights reserved.
//

#import "XYDevelopController.h"
#import "XYDevelopTableView.h"

@interface XYDevelopController ()

@property (nonatomic, strong) XYDevelopTableView * tableView;

@property (nonatomic, strong) UIImageView * imgView;


@end

@implementation XYDevelopController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.view.backgroundColor = [UIColor whiteColor];
    self.navigationItem.title = @"党员发展";
    self.tableView = [[XYDevelopTableView alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [self.view addSubview:self.tableView];
    
    _imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"dangzhang"]];
    _imgView.contentMode = UIViewContentModeScaleAspectFit;
    _imgView.alpha = 0.4;
    _imgView.backgroundColor = [UIColor whiteColor];
    _imgView.frame = CGRectMake(0, 0, SCREENWIDTH / 2, SCREENWIDTH / 2);
    _imgView.center = CGPointMake(self.view.width / 2.0, self.view.height / 2.0);
    [self.view addSubview:_imgView];
    
    // Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
