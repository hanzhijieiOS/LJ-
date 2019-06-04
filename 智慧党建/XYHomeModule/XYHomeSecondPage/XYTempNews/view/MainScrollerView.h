//
//  MainScrollerView.h
//  新闻移动条
//
//  Created by Jay on 2017/3/15.
//  Copyright © 2017年 hahaha. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MainScrollerView : UIScrollView

@property(nonatomic,copy) NSArray *titleArray;

- (id)initWithFrame:(CGRect)frame array:(NSArray *)array;
@end
