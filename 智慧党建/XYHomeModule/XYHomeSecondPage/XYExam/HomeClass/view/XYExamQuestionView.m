//
//  XYExamQuestionView.m
//  智慧党建
//
//  Created by 韩智杰 on 2019/5/27.
//  Copyright © 2019年 韩智杰. All rights reserved.
//

#import "XYExamQuestionView.h"

@interface XYExamQuestionView()

@property (nonatomic, strong) UILabel * typeLabel;

@property (nonatomic, strong) UILabel * questionLabel;

@end

@implementation XYExamQuestionView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        [self addSubview:self.typeLabel];
        [self addSubview:self.questionLabel];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.questionLabel.frame = CGRectMake(K_LeftGap, 0, self.width - 2 * K_LeftGap, self.height);
}

- (UILabel *)typeLabel{
    if (!_typeLabel) {
        _typeLabel = [[UILabel alloc] init];
        _typeLabel.font = [UIFont systemFontOfSize:16];
        _typeLabel.textColor = [UIColor whiteColor];
        _typeLabel.backgroundColor = [UIColor redColor];
        _typeLabel.layer.cornerRadius = 3;
        _typeLabel.layer.masksToBounds = YES;
    }
    return _typeLabel;
}

- (UILabel *)questionLabel{
    if (!_questionLabel) {
        _questionLabel = [[UILabel alloc] init];
        _questionLabel.font = [UIFont systemFontOfSize:16];
        _questionLabel.textColor = [UIColor blackColor];
    }
    return _questionLabel;
}

@end
