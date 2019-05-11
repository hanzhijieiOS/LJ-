//
//  XYExamView.m
//  智慧党建
//
//  Created by 韩智杰 on 2019/4/27.
//  Copyright © 2019年 韩智杰. All rights reserved.
//

#import "XYExamView.h"

static CGFloat buttonWidthandHeight = 18;
static CGFloat answerLabelFont = 15;
#define SCREEN_WIDTH ([UIScreen mainScreen].bounds.size.width)
#define SCREEN_HEIGHT ([UIScreen mainScreen].bounds.size.height)
static const NSInteger kLeftAndRightMargin = 15;

@interface XYExamView()

@property (nonatomic, strong) UIButton *button;
@property (nonatomic, strong) UILabel *answerLabel;


@end

@implementation XYExamView

- (instancetype)init
{
    self = [super init];
    if (self) {
        [self createUI];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        [self createUI];
    }
    return self;
}
#pragma mark - private
- (void)createUI{
    [self addSubview:self.button];
    [self addSubview:self.answerLabel];
}
- (void)changeBtnStatus{
    self.button.selected = YES;
}
- (void)layoutSubviews{
    [super layoutSubviews];
    self.button.frame = CGRectMake(kLeftAndRightMargin, 8, buttonWidthandHeight, buttonWidthandHeight);
    CGFloat answerLabelWidth = self.right - 2 * kLeftAndRightMargin - buttonWidthandHeight - 10;
    CGSize answerLabelSize = [self.answerLabel.text boundingRectWithSize:CGSizeMake(answerLabelWidth, MAXFLOAT)
                                                                 options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                                              attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:answerLabelFont]}
                                                                 context:nil].size;
    self.answerLabel.frame = CGRectMake(self.button.right + 10, 6, answerLabelWidth, answerLabelSize.height);
}
#pragma mark - public
- (void)setAnswerLabelTitle:(NSString *)title{
    self.answerLabel.text = title;
}

- (void)setButtonStatusToBeSelected{
    self.button.selected = YES;
    self.isSelected = YES;
}
- (void)cancelButtonStatusSelected{
    self.button.selected = NO;
    self.isSelected = NO;
}

- (NSString *)getAnswerLabeltext{
    return self.answerLabel.text;
}

+ (CGFloat)questionAnswerCell:(XYExamListCell *)questionAnswerCell rowHeightForObject:(id)object{
    NSString *answer = (NSString *)object;
    CGFloat answerLabelWidth = SCREEN_WIDTH - 2 * kLeftAndRightMargin - buttonWidthandHeight - 10;
    CGSize answerLabelSize = [answer boundingRectWithSize:CGSizeMake(answerLabelWidth, MAXFLOAT)
                                                  options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading
                                               attributes:@{NSFontAttributeName : [UIFont systemFontOfSize:answerLabelFont]}
                                                  context:nil].size;
    return answerLabelSize.height + 16;
}

#pragma mark - lazy
- (UIButton *)button{
    if (!_button) {
        _button = [[UIButton alloc] init];
        [_button setImage:[UIImage imageNamed:@"credit_answer_normal"] forState:UIControlStateNormal];
        [_button setImage:[UIImage imageNamed:@"credit_answer_selected"] forState:UIControlStateSelected];
        _button.userInteractionEnabled = NO;
    }
    return _button;
}
- (UILabel *)answerLabel{
    if (!_answerLabel) {
        _answerLabel = [[UILabel alloc] init];
        _answerLabel.textColor = [UIColor lightGrayColor];
        _answerLabel.font=[UIFont systemFontOfSize:answerLabelFont];
        _answerLabel.numberOfLines = 0;
        _answerLabel.lineBreakMode=NSLineBreakByWordWrapping;
    }
    return _answerLabel;
}

@end
