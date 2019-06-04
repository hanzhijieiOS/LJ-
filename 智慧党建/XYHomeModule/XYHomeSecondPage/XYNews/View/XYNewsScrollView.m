//
//  HZJScrollView.m
//  新闻移动条
//
//  Created by Jay on 2017/3/7.
//  Copyright © 2017年 hahaha. All rights reserved.
//

#import "XYNewsScrollView.h"

@interface XYNewsScrollView()

@property (nonatomic,strong) UIView *line;
@property (nonatomic, strong) UIView *bottomLine;

@end

@implementation XYNewsScrollView

-(id)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.showsHorizontalScrollIndicator = NO;
        self.showsVerticalScrollIndicator = NO;
        self.scrollsToTop = NO;
        self.backgroundColor = [UIColor whiteColor];
        self.bounces = NO;
        _itemWidth = 0;
        _textColor = [UIColor colorWithRed:142/255.0 green:142/255.0 blue:142/255.0 alpha:1];
        _selectedColor = [UIColor colorWithRed:61/255.0 green:209/255.0 blue:165/255.0 alpha:1];
        _lineHeight = 2.5;
        _linePercent = 0.8;
        _tapAnimation = YES;
    }
    return self;
}

-(void)setTitleArray:(NSArray *)titleArray{
    if (titleArray.count > 4) {
        self.itemWidth = self.frame.size.width / 4.0;
    }else{
        self.itemWidth = self.frame.size.width / titleArray.count;
    }
    _titleArray = titleArray;
    float x = 0;
    float y = 0;
    float width = _itemWidth;
    float height = self.frame.size.height;
    for (int i = 0; i < titleArray.count; i++) {
        UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setTitle:titleArray[i] forState:UIControlStateNormal];
        x = i*_itemWidth;
        [button setFrame:CGRectMake(x, y, width, height)];
        button.opaque = YES;
        [button setTitleColor:_textColor forState:UIControlStateNormal];
        button.tag = i + 100;
        [button addTarget:self action:@selector(itemButtonClick:) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:button];
        if (i == 0) {
            [button setTitleColor:_selectedColor forState:UIControlStateNormal];
            _currentIndex = 0;
            _line = [[UIView alloc] initWithFrame:CGRectMake(_itemWidth*(1 - _linePercent)/2, CGRectGetHeight(self.frame) - _lineHeight, _itemWidth*_linePercent, _lineHeight)];
            _line.backgroundColor = _selectedColor;
            [self addSubview:_line];
            
        }
    }
    self.bottomLine = [[UIView alloc] initWithFrame:CGRectMake(0, 39.5, _titleArray.count * width, 0.5)];
    self.bottomLine.backgroundColor = [UIColor lightGrayColor];
    [self addSubview:_bottomLine];
    self.contentSize = CGSizeMake(_titleArray.count * width, height) ;
}

- (void)itemButtonClick:(UIButton *)button{
    _currentIndex = button.tag - 100;
    if(_tapAnimation){
    }else{
        [self changeItemColor:_currentIndex];
        [self changeLine:_currentIndex];
    }
    [self changeScrollOffset:_currentIndex];
    if(self.tapItemWithIndex){
        _tapItemWithIndex(_currentIndex,_tapAnimation);
    }

}

-(void) changeItemColor:(NSInteger)index{
    
    for (int i = 0; i < _titleArray.count; i++) {
        
        UIButton *button = (UIButton *)[self viewWithTag:i+100];
        
        [button setTitleColor:_textColor forState:UIControlStateNormal];
        
        if (button.tag == index+100) {
        
            [button setTitleColor:_selectedColor forState:UIControlStateNormal];
        
        }
    }
}

- (void)changeLine:(float)index{
    CGRect rect = _line.frame;
    rect.origin.x = index * _itemWidth + (1 - _linePercent) * _itemWidth / 2.0;
    _line.frame = rect;
}

- (void)changeScrollOffset:(NSInteger)index{
    float halfWeight = CGRectGetWidth(self.frame)/2.0;
    float scrollWeight = self.contentSize.width;
    float leftSpace = index*_itemWidth + _itemWidth/2.0 - halfWeight;
    if (leftSpace < 0) {
        leftSpace = 0;
    }
    if (leftSpace > scrollWeight - 2*halfWeight){
        leftSpace = scrollWeight - 2*halfWeight;
    }
    [self setContentOffset:CGPointMake(leftSpace, 0) animated:YES];
    if ([self.HZJDelegate respondsToSelector:@selector(newsScrollViewDidChangePage:)]) {
        [self.HZJDelegate newsScrollViewDidChangePage:_currentIndex];
    }
}

-(NSInteger)changeProgressToInteger:(float)x{
    float max = _titleArray.count;
    float min = 0;
    NSInteger index = 0;
    if (x < min+0.5) {
        index = min;
    }else if (x >= max - 0.5){
        index = max;
    }else{
        index = (x+0.5)/1;
    }
    return index;
}

-(void)moveToIndex:(float)index{
    
    [self changeLine:index];
    [self changeItemColor:index];
    NSInteger tempIndex = [self changeProgressToInteger:index];
    if (tempIndex != _currentIndex) {
        [self changeItemColor:tempIndex];
    }
    _currentIndex = index;
}

-(void)endMoveToIndex:(float)index{
    [self changeLine:index];
    [self changeItemColor:index];
    _currentIndex = index;
    [self changeScrollOffset:index];
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
