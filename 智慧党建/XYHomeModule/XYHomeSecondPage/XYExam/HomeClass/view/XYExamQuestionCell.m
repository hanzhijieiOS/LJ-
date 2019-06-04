//
//  XYExamQuestionCell.m
//  智慧党建
//
//  Created by 韩智杰 on 2019/5/27.
//  Copyright © 2019年 韩智杰. All rights reserved.
//

#import "XYExamQuestionCell.h"
#import "XYExamQuestionView.h"
#import "XYExamAnswerView.h"
#import "XYAnswerModel.h"
#import "XYExamSelectOptionModel.h"
#import "XYExamJudgeModel.h"
#import "NSString+StringSize.h"

NSInteger SelectViewTag = 190527;
NSInteger JudegViewTag = 725091;

@interface XYExamQuestionCell()

@property (nonatomic, strong) XYExamQuestionView * questionView;

@property (nonatomic, strong) NSObject * data;

@end

@implementation XYExamQuestionCell

+ (instancetype)initWithTableView:(UITableView *)tableView ContentData:(NSObject *)data currentSelectAnswer:(XYAnswerModel *)answer{
    XYExamQuestionCell * cell = [tableView dequeueReusableCellWithIdentifier:NSStringFromClass([data class])];
    cell.data = data;
    if (!cell) {
        cell = [[XYExamQuestionCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:NSStringFromClass([data class])];
        [cell configWithData:data];
    }
    [cell updateWithData:data currentAnswer:answer];
    return cell;
}

- (void)configWithData:(NSObject *)data{
    self.questionView = [[XYExamQuestionView alloc] initWithFrame:CGRectZero];
    if ([data isKindOfClass:[XYExamSelectOptionModel class]]) {
        XYExamSelectOptionModel * model = (XYExamSelectOptionModel *)data;
        for (int i = 0; i < model.selectOptionInfos.count; i ++) {
            XYExamAnswerView * answerView = [[XYExamAnswerView alloc] initWithFrame:CGRectZero];
            [self.contentView addSubview:answerView];
            answerView.tag = i + SelectViewTag;
        }
    }else if([data isKindOfClass:[XYExamJudgeModel class]]){
        for (int i = 0; i < 2; i ++) {
            XYExamAnswerView * answerView = [[XYExamAnswerView alloc] initWithFrame:CGRectZero];
            [self.contentView addSubview:answerView];
            answerView.tag = i + JudegViewTag;
        }
    }
}

- (void)updateWithData:(NSObject *)data currentAnswer:(XYAnswerModel *)answer{
    if ([data isKindOfClass:[XYExamSelectOptionModel class]]) {
        XYExamSelectOptionModel * model = (XYExamSelectOptionModel *)data;
        for (int i = 0; i < model.selectOptionInfos.count; i ++) {
            UIView * answerView = [self.contentView viewWithTag:i + SelectViewTag];
            if ([answerView isKindOfClass:[XYExamAnswerView class]]) {
                BOOL isSelect = [answer.answer isEqualToString:model.selectOptionInfos[i].option];
                [(XYExamAnswerView *)answerView updateWithData:model.selectOptionInfos[i].optionContent select:isSelect];
            }
        }
    }else if ([data isKindOfClass:[XYExamJudgeModel class]]){
        UIView * answerOne = [self.contentView viewWithTag:0 + JudegViewTag];
        if ([answerOne isKindOfClass:[XYExamAnswerView class]]) {
            BOOL isSelect = [answer.answer isEqualToString:@"1"];
            [(XYExamAnswerView *)answerOne updateWithData:@"正确" select:isSelect];
        }
        
        UIView * answerTwo = [self.contentView viewWithTag:1 + JudegViewTag];
        if ([answerTwo isKindOfClass:[XYExamAnswerView class]]) {
            BOOL isSelect = [answer.answer isEqualToString:@"0"];
            [(XYExamAnswerView *)answerOne updateWithData:@"错误" select:isSelect];
        }
    }
}

- (void)layoutSubviews{
    [super layoutSubviews];
    CGFloat currentHeight = 0;
    for (UIView * view in self.contentView.subviews) {
        if ([view isKindOfClass:[XYExamQuestionView class]]) {
            if ([self.data isKindOfClass:[XYExamSelectOptionModel class]]) {
                XYExamSelectOptionModel * model = (XYExamSelectOptionModel *)(self.data);
                view.frame = CGRectMake(0, 0, self.width, [model.examTittle sizeWithPreferWidth:(self.width - 2 * K_LeftGap) font:[UIFont systemFontOfSize:16]].height);
            }else if([self.data isKindOfClass:[XYExamJudgeModel class]]){
                XYExamJudgeModel * model = (XYExamJudgeModel *)(self.data);
                view.frame = CGRectMake(0, 0, self.width, [model.examTittle sizeWithPreferWidth:(self.width - 2 * K_LeftGap) font:[UIFont systemFontOfSize:16]].height);
            }
            currentHeight += view.bottom;
        }
        if ([view isKindOfClass:[XYExamAnswerView class]]) {
            if ([self.data isKindOfClass:[XYExamSelectOptionModel class]]) {
                XYExamSelectOptionModel * model = (XYExamSelectOptionModel *)(self.data);
                view.frame = CGRectMake(0, currentHeight, self.width, [model.selectOptionInfos[view.tag].optionContent sizeWithPreferWidth:(self.width - 2 * K_LeftGap) font:[UIFont systemFontOfSize:16]].height);
                currentHeight = view.bottom;
            }else if([self.data isKindOfClass:[XYExamJudgeModel class]]){
                view.frame = CGRectMake(0, currentHeight, self.width, [@"正确" sizeWithPreferWidth:(self.width - 2 * K_LeftGap) font:[UIFont systemFontOfSize:16]].height);
                currentHeight = view.bottom;
            }
        }
    }
}

+ (CGFloat)getCellHeightWithData:(NSObject *)data{
    CGFloat height = 0;
    if ([data isKindOfClass:[XYExamSelectOptionModel class]]) {
        XYExamSelectOptionModel * model = (XYExamSelectOptionModel *)data;
        height += [model.examTittle sizeWithPreferWidth:SCREENWIDTH - 2 * K_LeftGap font:[UIFont systemFontOfSize:16]].height;
        for (XYExamSelectInfoModel * select in model.selectOptionInfos) {
            height += [select.optionContent sizeWithPreferWidth:(SCREENWIDTH - 2 * K_LeftGap - 8 - 18) font:[UIFont systemFontOfSize:15]].height;
        }
    }else if([data isKindOfClass:[XYExamJudgeModel class]]){
        XYExamJudgeModel * model = (XYExamJudgeModel *)data;
        height += [model.examTittle sizeWithPreferWidth:SCREENWIDTH -2 * K_LeftGap font:[UIFont systemFontOfSize:16]].height;
        for (int i = 0; i < 2; i ++) {
            height += [@"正确" sizeWithPreferWidth:(SCREENWIDTH - 2 * K_LeftGap - 8 - 18) font:[UIFont systemFontOfSize:15]].height;
        }
    }
    return height;
}

@end
