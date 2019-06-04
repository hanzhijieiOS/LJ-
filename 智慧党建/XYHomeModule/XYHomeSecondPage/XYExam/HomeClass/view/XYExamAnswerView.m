//
//  XYExamAnswerView.m
//  智慧党建
//
//  Created by 韩智杰 on 2019/5/27.
//  Copyright © 2019年 韩智杰. All rights reserved.
//

#import "XYExamAnswerView.h"
#import "NSString+StringSize.h"
#import "XYExamSelectInfoModel.h"

#define K_LabelWidth (SCREENWIDTH - 8 - 2 * K_LeftGap - 18)

@interface XYExamAnswerView()

@property (nonatomic, strong) UILabel * answerLabel;

@property (nonatomic, strong) UIImageView * selectImgView;

@end

@implementation XYExamAnswerView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.answerLabel];
        [self addSubview:self.selectImgView];
        
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.selectImgView.frame = CGRectMake(K_LeftGap, 8, 18, 18);
    self.answerLabel.frame = (CGRect){CGPointMake(self.selectImgView.right + 8, 0), CGSizeMake((self.width - 2 * K_LeftGap - self.selectImgView.width - 8), self.height)};
}

- (void)updateWithData:(NSString *)content select:(BOOL)isSelect{
    self.answerLabel.text = content;
    if (isSelect) {
        self.selectImgView.image = [UIImage imageNamed:@"credit_answer_selected"];
    }else{
        self.selectImgView.image = [UIImage imageNamed:@"credit_answer_normal"];
    }
}

+ (CGFloat)getAnswerHeightWithData:(NSArray *)dataArray{
    CGFloat height = 0;
    for (NSObject * obj in dataArray) {
        if ([obj isKindOfClass:[XYExamSelectInfoModel class]]) {
            XYExamSelectInfoModel * model = (XYExamSelectInfoModel *)obj;
            height += [model.optionContent sizeWithPreferWidth:K_LabelWidth font:[UIFont systemFontOfSize:15]].height;
        }else if ([obj isKindOfClass:[NSString class]]){
            height += [(NSString *)obj sizeWithPreferWidth:K_LabelWidth font:[UIFont systemFontOfSize:15]].height;
        }
    }
    return height;
}

- (UILabel *)answerLabel{
    if (!_answerLabel) {
        _answerLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _answerLabel.textColor = [UIColor grayColor];
        _answerLabel.font=[UIFont systemFontOfSize:15];
        _answerLabel.numberOfLines = 0;
        _answerLabel.lineBreakMode=NSLineBreakByWordWrapping;
    }
    return _answerLabel;
}

- (UIImageView *)selectImgView{
    if (!_selectImgView) {
        _selectImgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"credit_answer_normal"]];
    }
    return _selectImgView;
}

@end
