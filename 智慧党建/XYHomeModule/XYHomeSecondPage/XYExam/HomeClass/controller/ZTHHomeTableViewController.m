//
//  ZTHHomeTableViewController.m
//  ZTHOmnipotentCell
//
//  Created by 9188 on 2017/3/14.
//  Copyright © 2018年 韩智杰. All rights reserved.
//

#import "ZTHHomeTableViewController.h"
#import "NSArray+CDArrayAdditions.h"
#import "NSMutableDictionary+CDMutableDictAdditions.h"
#import "ZTHQuestionModel.h"
#import "ZTHAnswerModel.h"
#import "ZTHDataSourceManager.h"
#import "SCYQuestionAnswerCell.h"
#import "XYExamManager.h"
#import "XYExamInfoModel.h"
#import "XYExamDataModel.h"
#import "XYExamScoreItemModel.h"

@interface ZTHHomeTableViewController ()

@property (nonatomic, copy) NSArray *questions;
@property (nonatomic, strong) NSMutableArray *heightArray;
@property (nonatomic, strong) NSMutableArray *selectedIndexpathArray; // cell的选中答案数组
@property (nonatomic, strong) UIButton *tableFooterButton;

@property (nonatomic, copy) NSArray <XYExamInfoModel *> * publishExam;

@property (nonatomic, copy) NSString * examID;

@property (nonatomic, strong) XYExamDataModel * model;

@end
//  这里是用户反馈的意见
@implementation ZTHHomeTableViewController

- (instancetype)initWithStyle:(UITableViewStyle)style {
    if (self = [super initWithStyle:style]) {
        self.title = @"在线考试";
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.tableFooterView = self.tableFooterButton;
    [[XYExamManager sharedManager] fetchExamDetailInformationWithExamPaperNum:self.examID successBlock:^(XYExamDataModel *model) {
        self.model = model;
        [self initQuestions];
        [self.tableView reloadData];
    } failureBlock:^(NSError *error) {
        NSLog(@"");
        NSMutableArray * array = [NSMutableArray array];
        for (int i = 0; i < 5; i ++) {
            XYExamJudgeModel * model = [[XYExamJudgeModel alloc] init];
            model.examTittle = @"测试数据";
            [array addObject:model];
        }
        
        NSMutableArray * array2 = [NSMutableArray array];
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
            [array2 addObject:model];
        }
        XYExamDataModel * model = [[XYExamDataModel alloc] init];
        model.examJudgeInfoVos = [array copy];
        model.examSelectInfoVos = [array2 copy];
        self.model = model;
        [self initQuestions];
        [self.tableView reloadData];
    }];
}

#pragma mark - Table view data source
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.questions.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    __weak typeof(self) weakSelf = self;
    ZTHQuestionModel *questionModel = [self.questions cd_safeObjectAtIndex:indexPath.row];
    SCYQuestionAnswerCell *cell = [SCYQuestionAnswerCell questionAnswerCellWithTable:tableView answersCount:questionModel.options.count]; // 自动复用
    [cell setCellDataWithSCYCreditLoginQuestionModel:questionModel andSelectedIndexpathArray:self.selectedIndexpathArray andIndexPath:indexPath]; // 提供接口设置数据
    cell.selectAnswerBlock_V2 = ^(ZTHAnswerModel *answer, NSInteger answerCount) {
        [weakSelf questionDidComplentionWithAnswer:answer];
    };
    
    return cell;
}

#pragma mark - UITableViewDelegate
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    [tableView deselectRowAtIndexPath:indexPath animated:YES];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    ZTHQuestionModel *questionModel = [self.questions cd_safeObjectAtIndex:indexPath.row];
    NSNumber *rowHeight = [self.heightArray cd_safeObjectAtIndex:(indexPath.row)];
    if (rowHeight) {
        return [rowHeight floatValue];
    }else{
        CGFloat height = [SCYQuestionAnswerCell tableView:tableView rowHeightForObject:questionModel];
        [self.heightArray addObject:@(height)];
        return height;
    }
}

#pragma mark - lazy

- (void)questionDidComplentionWithAnswer:(ZTHAnswerModel *)answer{
    NSMutableDictionary * dic = [NSMutableDictionary dictionary];
    [dic setObject:@(answer.type) forKey:@"examSubjectType"];
    [dic setObject:answer.answerID forKey:@"answer"];
    [dic setObject:answer.num forKey:@"subjectId"];
    if (self.selectedIndexpathArray.count == 0) {
        [self.selectedIndexpathArray addObject:dic];
    }else{
        BOOL isExist = NO;
        for (NSDictionary * dict in self.selectedIndexpathArray) {
            if ([[dict valueForKey:@"subjectId"] isEqualToString:[dic objectForKey:@"subjectId"]]) {
                [self.selectedIndexpathArray removeObject:dict];
                [self.selectedIndexpathArray addObject:dic];
                isExist = YES;
                break;
            }
        }
        if (!isExist) {
            [self.selectedIndexpathArray addObject:dic];
        }
    }
}

/// 提交答案
- (void)submitQuestionAnswers{
    NSString * message = @"确定要提交吗？";
    __weak typeof(self) weakSelf = self;
    if (self.selectedIndexpathArray.count != self.questions.count) {
        message = @"还有问题没有填写，确定要提交吗？";
    }
    UIAlertController * alert = [UIAlertController alertControllerWithTitle:message message:@"" preferredStyle:UIAlertControllerStyleActionSheet];
    UIAlertAction * action = [UIAlertAction actionWithTitle:@"确认" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
        [weakSelf submitAnswers];
    }];
    UIAlertAction * cancel = [UIAlertAction actionWithTitle:@"取消" style:UIAlertActionStyleCancel handler:^(UIAlertAction * _Nonnull action) {
        
    }];
    [alert addAction:action];
    [alert addAction:cancel];
    [self presentViewController:alert animated:YES completion:nil];
    return;
}

- (void)submitAnswers{
    [AppHelper ShowHUDPrompt:@"正在提交答案...."];
    [[XYExamManager sharedManager] completeExam:self.examID submitAnswers:self.selectedIndexpathArray success:^{
        [AppHelper dismissHUDPromptWithAnimation:NO];
        [AppHelper ShowHUDPrompt:@"提交成功!" withParentViewController:nil];
        __weak typeof(self) weakSelf = self;
        [weakSelf completeExam];
    } failure:^(NSError *error) {
        [AppHelper dismissHUDPromptWithAnimation:NO];
        [AppHelper ShowHUDPrompt:@"提交失败，请稍后再试!" withParentViewController:nil];
    }];
}

- (void)completeExam{
    
    UIView * footerView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, self.view.width, 50)];
    footerView.backgroundColor = [UIColor cyanColor];

    UILabel * score = [[UILabel alloc] initWithFrame:CGRectMake(0, 10, self.view.width, 30)];
    score.font = [UIFont systemFontOfSize:20];
    score.textAlignment = NSTextAlignmentCenter;
    score.text = @"正在统计分数...";
    [footerView addSubview:score];
    [score sizeToFit];
    score.center = CGPointMake(footerView.width / 2.0, footerView.height / 2.0);
    
    UIActivityIndicatorView * indicatorView = [[UIActivityIndicatorView alloc] initWithFrame:CGRectMake(0, 0, 25, 25)];
    indicatorView.left = score.right;
    indicatorView.centerY = score.centerY;
    indicatorView.color = [UIColor blackColor];
    indicatorView.backgroundColor = [UIColor clearColor];
    indicatorView.hidesWhenStopped = YES;
    [footerView addSubview:indicatorView];
    [indicatorView startAnimating];
    
    self.tableView.tableFooterView = footerView;
    
    
    [[NSNotificationCenter defaultCenter] postNotificationName:XYExamCompleteNotification object:nil];
    [[XYExamManager sharedManager] fetchExamScoreWithPaperStartNum:self.examID successBlock:^(XYExamScoreItemModel *model) {
        [indicatorView stopAnimating];
        score.text = [NSString stringWithFormat:@"考试成绩：%ld", (long)model.score];
    } failureBlock:^(NSError *error) {
        [indicatorView stopAnimating];
        score.text = @"获取数据错误";
    }];
}

#pragma mark - lazy

- (void)initQuestions{
    ZTHDataSourceManager *manager = [[ZTHDataSourceManager alloc] initWithExamData:self.model];
    _questions = [NSArray arrayWithArray:manager.questions];
}

- (NSMutableArray *)heightArray{
    if (!_heightArray) {
        _heightArray = [NSMutableArray array];
    }
    return _heightArray;
}

- (NSMutableArray *)selectedIndexpathArray{
    if (!_selectedIndexpathArray) {
        _selectedIndexpathArray = [[NSMutableArray alloc] init];
    }
    return _selectedIndexpathArray;
}

- (UIButton *)tableFooterButton{
    if (!_tableFooterButton) {
        _tableFooterButton = [[UIButton alloc] initWithFrame:CGRectMake(0, 0, self.view.frame.size.width , 40)];
        _tableFooterButton.backgroundColor = [UIColor cyanColor];
        [_tableFooterButton setTitle:@"提交答案" forState:UIControlStateNormal];
        [_tableFooterButton addTarget:self action:@selector(submitQuestionAnswers) forControlEvents:UIControlEventTouchUpInside];
    }
    return _tableFooterButton;
}
@end
