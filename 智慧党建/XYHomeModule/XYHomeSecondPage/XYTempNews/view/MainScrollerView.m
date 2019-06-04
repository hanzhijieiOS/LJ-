//
//  MainScrollerView.m
//  新闻移动条
//
//  Created by Jay on 2017/3/15.
//  Copyright © 2017年 hahaha. All rights reserved.
//

#import "MainScrollerView.h"

@implementation MainScrollerView

-(id)initWithFrame:(CGRect)frame array:(NSArray *)array{
    self = [super initWithFrame:frame];
    if (self) {
        self.pagingEnabled = YES;
        self.bounces = NO;
        self.contentSize = CGSizeMake(array.count *self.frame.size.width, 100);
    }
    return self;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
