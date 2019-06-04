//
//  XYExamDetailController.m
//  智慧党建
//
//  Created by 韩智杰 on 2019/5/27.
//  Copyright © 2019年 韩智杰. All rights reserved.
//

#import "XYExamDetailController.h"
#import "XYExamManager.h"
#import "XYExamInfoModel.h"
#import "XYExamDataModel.h"
#import "XYExamScoreItemModel.h"
#import "XYExamDetailTableView.h"

#import "XYExamJudgeModel.h"

@interface XYExamDetailController ()

@property XYExamDetailTableVIew * tableView;

@property (nonatomic, strong) XYExamDataModel * model;
@property (nonatomic, copy) NSString * examID;

@end

@implementation XYExamDetailController

- (void)viewDidLoad {
    [super viewDidLoad];
//    [[XYExamManager sharedManager] fetchExamDetailInformationWithExamPaperNum:self.examID successBlock:^(XYExamDataModel *model) {
//        self.model = model;
//        NSMutableArray * array = [NSMutableArray array];
//        [array addObjectsFromArray:model.examJudgeInfoVos];
//        [array addObjectsFromArray:model.examSelectInfoVos];
//        [self.tableView updateWithDataArray:[array copy]];
//
//    } failureBlock:^(NSError *error) {
//        NSLog(@"");
//    }];
    self.tableView = [[XYExamDetailTableVIew alloc] initWithFrame:self.view.bounds style:UITableViewStylePlain];
    [self.view addSubview:self.tableView];
    NSMutableArray * array = [NSMutableArray array];
    for (int i = 0; i < 5; i ++) {
        XYExamJudgeModel * model = [[XYExamJudgeModel alloc] init];
        model.examTittle = @"测试数据";
        [array addObject:model];
    }
    for (int i = 0; i < 5; i ++) {
        XYExamSelectOptionModel * model = [[XYExamSelectOptionModel alloc] init];
        model.examTittle = @"这是选择题";
        NSMutableArray * a = [NSMutableArray array];
        for (int j = 0; j < 3; j ++) {
            XYExamSelectInfoModel * info = [[XYExamSelectInfoModel alloc] init];
            info.option = [NSString stringWithFormat:@"%c", (j + 'A')];
            info.optionContent = @"这是答案";
            [a addObject:info];
        }
        model.selectOptionInfos = a;
        [array addObject:model];
    }
    [self.tableView updateWithDataArray:array];
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
