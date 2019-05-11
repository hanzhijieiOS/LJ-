//
//  HZJScrollView.h
//  新闻移动条
//
//  Created by Jay on 2017/3/7.
//  Copyright © 2017年 hahaha. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol HZJScrollViewDelegate <NSObject>

@required

- (void)HZJScrollViewDidChangePage:(NSInteger)index;

@end

typedef void (^HZJScrollViewTapBlock)(NSInteger index,BOOL animation);

@interface XYNewsScrollView : UIScrollView

@property (nonatomic,assign) float itemWidth;
@property (nonatomic,strong) UIColor *textColor;
@property (nonatomic,strong) UIColor *selectedColor;
@property (nonatomic,assign) float linePercent;
@property (nonatomic,assign) float lineHeight;
@property (nonatomic,strong) NSArray *titleArray;
@property (nonatomic,readonly) NSInteger currentIndex;
@property(nonatomic,assign)BOOL tapAnimation;
-(void)moveToIndex:(float)index;
-(void)endMoveToIndex:(float)index;
@property(nonatomic,copy)HZJScrollViewTapBlock tapItemWithIndex;
@property (nonatomic,weak) id <HZJScrollViewDelegate> HZJDelegate;
@end
