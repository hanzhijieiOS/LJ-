//
//  XYRegulationTopView.m
//  智慧党建
//
//  Created by jaycehan(韩智杰) on 2019/2/24.
//  Copyright © 2019年 韩智杰. All rights reserved.
//

#import "XYRegulationTopView.h"

@interface XYRegulationTopView()

@property (nonatomic, strong) UIButton * chapterButton;
@property (nonatomic, strong) UIButton * ruleButton;

@end

@implementation XYRegulationTopView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        self.chapterButton = [[UIButton alloc] initWithFrame:CGRectZero];
        [self.chapterButton setTitle:@"党章" forState:UIControlStateNormal];
        [self.chapterButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        [self.chapterButton.titleLabel setFont:[UIFont systemFontOfSize:19]];
        [self.chapterButton addTarget:self action:@selector(buttonDidClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.chapterButton];
        
        self.ruleButton = [[UIButton alloc] initWithFrame:CGRectZero];
        [self.ruleButton setTitle:@"党规" forState:UIControlStateNormal];
        [self.ruleButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [self.ruleButton.titleLabel setFont:[UIFont systemFontOfSize:16]];
        [self.ruleButton addTarget:self action:@selector(buttonDidClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:self.ruleButton];
    }
    return self;
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [self.chapterButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.mas_left).offset(self.width / 4.0);
        make.centerY.mas_equalTo(self.mas_centerY);
        make.height.mas_equalTo(25);
        make.width.mas_equalTo(50);
    }];
    
    [self.ruleButton mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.mas_right).offset(- self.width / 4.0);
        make.centerY.mas_equalTo(self.chapterButton);
        make.width.height.equalTo(self.chapterButton);
    }];
}

- (void)buttonDidClick:(id)sender{
    if ([sender isEqual:self.chapterButton]) {
        self.chapterButton.enabled = NO;
        [self.chapterButton.titleLabel setFont:[UIFont systemFontOfSize:19]];
        [self.chapterButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        self.ruleButton.enabled = YES;
        [self.ruleButton.titleLabel setFont:[UIFont systemFontOfSize:16]];
        [self.ruleButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        if ([self.delegate respondsToSelector:@selector(regulationTopViewDidSelectWithIndex:)]) {
            [self.delegate regulationTopViewDidSelectWithIndex:0];
        }
    }else{
        self.chapterButton.enabled = YES;
        [self.chapterButton.titleLabel setFont:[UIFont systemFontOfSize:16]];
        [self.chapterButton setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        self.ruleButton.enabled = NO;
        [self.ruleButton.titleLabel setFont:[UIFont systemFontOfSize:19]];
        [self.ruleButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        if ([self.delegate respondsToSelector:@selector(regulationTopViewDidSelectWithIndex:)]) {
            [self.delegate regulationTopViewDidSelectWithIndex:1];
        }
    }
}

@end
