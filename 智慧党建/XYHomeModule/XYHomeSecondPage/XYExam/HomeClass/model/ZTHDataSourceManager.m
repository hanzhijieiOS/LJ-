//
//  ZTHDataSourceManager.m
//  ZTHSubjectCell
//
//  Created by 9188 on 2017/3/15.
//  Copyright © 2018年 韩智杰. All rights reserved.
//

#import "ZTHDataSourceManager.h"
#import "ZTHQuestionModel.h"
#import "ZTHAnswerModel.h"
#import "XYExamJudgeModel.h"

@interface ZTHDataSourceManager ()

@property (nonatomic, strong) NSMutableArray *dataSource;

@property (nonatomic, strong) XYExamDataModel * model;

@end

@implementation ZTHDataSourceManager

//- (instancetype)init
//{
//    self = [super init];
//    if (self) {
//        [self createDataSource];
//    }
//    return self;
//}

- (void)createDataSource{
    self.dataSource = [[NSMutableArray alloc] init];

    [self addModel_0];
    [self addModel_1];
    [self addModel_0];
    [self addModel_1];
    
    _questions = self.dataSource.mutableCopy;
    
}

- (instancetype)initWithExamData:(XYExamDataModel *)dataModel{
    self = [super init];
    self.model = dataModel;
    self.dataSource = [NSMutableArray array];
    [self createSelectInfo];
    [self createJudgeInfo];
    _questions = self.dataSource.mutableCopy;
    return self;
}

- (void)createJudgeInfo{
    for (XYExamJudgeModel * judge in self.model.examJudgeInfoVos) {
        if ([judge isKindOfClass:[NSDictionary class]]) {
            NSDictionary * dic = (NSDictionary *)judge;
            ZTHAnswerModel * as = [[ZTHAnswerModel alloc] init];
            as.num = [dic objectForKey:@"subjectId"];
            as.value = @"正确";
            as.answerID = @"1";
            as.type = [[dic objectForKey:@"examSubjectType"] integerValue];
            
            ZTHAnswerModel * as1 = [[ZTHAnswerModel alloc] init];
            as1.num = [dic objectForKey:@"subjectId"];
            as1.value = @"错误";
            as1.answerID = @"0";
            as1.type = [[dic objectForKey:@"examSubjectType"] integerValue];
            
            ZTHQuestionModel * question = [[ZTHQuestionModel alloc] init];
            question.questionName = [dic objectForKey:@"examTittle"];
            question.options = @[as, as1];
            
            [self.dataSource addObject:question];
        }else{
            ZTHAnswerModel * as = [[ZTHAnswerModel alloc] init];
            as.num = judge.subjectId;
            as.value = @"正确";
            as.answerID = @"1";
            as.type = judge.examSubjectType;
            
            ZTHAnswerModel * as1 = [[ZTHAnswerModel alloc] init];
            as1.num = judge.subjectId;
            as1.value = @"错误";
            as1.answerID = @"0";
            as1.type = judge.examSubjectType;
            
            ZTHQuestionModel * question = [[ZTHQuestionModel alloc] init];
            question.questionName = judge.examTittle;
            question.options = @[as, as1];
            
            [self.dataSource addObject:question];
        }
        
    }
}

- (void)createSelectInfo{
    for (XYExamSelectOptionModel * model in self.model.examSelectInfoVos) {
        
        if ([model isKindOfClass:[NSDictionary class]]) {
            NSDictionary * dic = (NSDictionary *)model;
            ZTHQuestionModel * question = [[ZTHQuestionModel alloc] init];
            question.questionName = [dic objectForKey:@"examTittle"];
            
            NSMutableArray * array = [NSMutableArray array];
            NSArray * a = [model valueForKey:@"selectOptionInfos"];
            for (XYExamSelectInfoModel * info in a) {
                NSDictionary * dict = (NSDictionary *)info;
                ZTHAnswerModel * as1 = [[ZTHAnswerModel alloc] init];
                as1.answerID = [dict objectForKey:@"option"];
                as1.value = [NSString stringWithFormat:@"%@.%@", [dict objectForKey:@"option"], [dict objectForKey:@"optionContent"]];
                as1.num = [dic objectForKey:@"subjectId"];
                as1.type = [[dic objectForKey:@"examSubjectType"] integerValue];
                
                [array addObject:as1];
            }
            question.options = [array copy];
            
            [self.dataSource addObject:question];
        }
    }
}

#pragma mark - 制造点假的数据
- (void)addModel_0{
    
    ZTHAnswerModel *answer_0= [[ZTHAnswerModel alloc] init];
    answer_0.num = @"1";
    answer_0.value = @"1.答案数组动态化显示问题，3-5都可以，还有动态行高问题，标题和答案都是动态返回行高的，，这动态计算可以好好看看";
    
    ZTHAnswerModel *answer_1= [[ZTHAnswerModel alloc] init];
    answer_1.num = @"2";
    answer_1.value = @"2.复用问题，包括不同数量的答案cell的复用，以及选择了答案，按钮的选择状态记录等等";
    
    ZTHAnswerModel *answer_2= [[ZTHAnswerModel alloc] init];
    answer_2.num = @"3";
    answer_2.value = @"3.总结就是根据答案个数，提前建好几个答案的SCYQuestionAnswerView，赋值的时候，一一循环赋值，设置坐标的时候，一一循环设置坐标";
    
    ZTHAnswerModel *answer_3= [[ZTHAnswerModel alloc] init];
    answer_3.num = @"4";
    answer_3.value = @"4.最下面的提交答案按钮，然后打印数据源，每题的答案都在数组里";
    
    ZTHQuestionModel *question_0 = [[ZTHQuestionModel alloc] init];
    question_0.questionNo = @"0";
    question_0.questionName = @"1.注意事项⚠️项目中值得看的地方";
    question_0.options = [NSArray arrayWithObjects:answer_0,answer_1,answer_2,answer_3, nil];
    
    [self.dataSource addObject:question_0];

}

- (void)addModel_1{
    
    ZTHAnswerModel *answer_0= [[ZTHAnswerModel alloc] init];
    answer_0.num = @"1";
    answer_0.value = @"1.关于问题的JSON数据格式，见ZTHDataSourceManager中questionJSONFormat方法中，给出了常用的JSON格式，直接丢给后台，这么定义就行了";
    
    ZTHAnswerModel *answer_1= [[ZTHAnswerModel alloc] init];
    answer_1.num = @"2";
    answer_1.value = @"2.答案数组不要超过5个";
    
    ZTHAnswerModel *answer_2= [[ZTHAnswerModel alloc] init];
    answer_2.num = @"3";
    answer_2.value = @"3.主要代码都在SCYQuestionAnswerCell里";
    
    ZTHAnswerModel *answer_3= [[ZTHAnswerModel alloc] init];
    answer_3.num = @"4";
    answer_3.value = @"4.SCYQuestionAnswerView是左边按钮（用来显示选中状态的按钮，）右边答案文字，封装好了";
    
    ZTHAnswerModel *answer_4= [[ZTHAnswerModel alloc] init];
    answer_4.num = @"5";
    answer_4.value = @"5.感觉还是很好的，足足数据答案就是5个";
    
    
    
    
    ZTHQuestionModel *question_1 = [[ZTHQuestionModel alloc] init];
    question_1.questionNo = @"1";
    question_1.questionName = @"1. 本demo提供回答问题cell的设计方式，答案数组的动态化，一般3-5个都能正常显示";
    question_1.options = [NSArray arrayWithObjects:answer_0,answer_1,answer_2,answer_3,answer_4, nil];
    [self.dataSource addObject:question_1];

}

#pragma mark - JSON格式  后台返回

- (void)questionJSONFormat{
   /* {
        questionNo : @"1";  // 第一题
        options =                         (
                                           {
                                               num = @"0"; // 答案索引
                                               value = @"重要"; // 答案标题
                                           },
                                           {
                                               num = @"1";
                                               value = @"不重要";
                                           },
                                           {
                                               num = @"3";
                                               value = @"没选择过";
                                           },
                                           {
                                               num = @"4";
                                               value = @"没努力过";
                                           }
                                           ); // 第一题答案数组
        
        questionName : @"第一题的标题，选择比努力更重要吗？"; // 第一题标题
    }*/
}
@end
