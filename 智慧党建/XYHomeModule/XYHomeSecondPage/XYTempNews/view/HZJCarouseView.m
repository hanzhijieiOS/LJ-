//
//  HZJCarouseView.m
//  知途趣闻
//
//  Created by Jay on 2017/10/25.
//  Copyright © 2017年 hanzhijie. All rights reserved.
//

#import "HZJCarouseView.h"

@implementation HZJCarouseView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.showsHorizontalScrollIndicator = NO;
        self.pagingEnabled = YES;
        [self layout];
    }
    return self;
}

- (void)layout{
    int count = 5;
    CGSize size = self.frame.size;
    self.contentSize = CGSizeMake(size.width * count, 0);
    
    for (int i = 0; i < count; i ++) {
        UIImageView *iconView = [[UIImageView alloc] initWithFrame:CGRectMake(i * size.width, 0, size.width, size.height)];
        iconView.contentMode = UIViewContentModeScaleAspectFit;
//        iconView.backgroundColor = [UIColor colorWithRed:30*(i+1)/255.0 green:30*(i+1)/255.0 blue:30*(i+1)/255.0 alpha:1];
        iconView.image = [UIImage imageNamed:@"dangzhang.png"];
        [self addSubview:iconView];
    }
    
}


/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
