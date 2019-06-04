//
//  XYExamDetailTableVIew.m
//  智慧党建
//
//  Created by 韩智杰 on 2019/5/27.
//  Copyright © 2019年 韩智杰. All rights reserved.
//

#import "XYExamDetailTableVIew.h"
#import "XYExamQuestionCell.h"
#import "XYAnswerModel.h"

@interface XYExamDetailTableVIew()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, copy) NSArray * dataArray;

@property (nonatomic, strong) NSMutableArray <XYAnswerModel *> * answerArray;

@end

@implementation XYExamDetailTableVIew

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.delegate = self;
        self.dataSource = self;
    }
    return self;
}

- (void)updateWithDataArray:(NSArray *)dataArray{
    self.dataArray = dataArray;
    self.answerArray = [NSMutableArray arrayWithCapacity:dataArray.count];
    [self reloadData];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.dataArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    XYAnswerModel * model = nil;
    if (self.answerArray.count > indexPath.row) {
        model = self.answerArray[indexPath.row];
    }
    XYExamQuestionCell * cell = [XYExamQuestionCell initWithTableView:tableView ContentData:self.dataArray[indexPath.row] currentSelectAnswer:model] ;
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return [XYExamQuestionCell getCellHeightWithData:self.dataArray[indexPath.row]];
}

@end
