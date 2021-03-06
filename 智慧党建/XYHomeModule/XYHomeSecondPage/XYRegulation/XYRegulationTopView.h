//
//  XYRegulationTopView.h
//  智慧党建
//
//  Created by jaycehan(韩智杰) on 2019/2/24.
//  Copyright © 2019年 韩智杰. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@protocol  XYRegulationTopViewDelegate<NSObject>

- (void)regulationTopViewDidSelectWithIndex:(NSInteger)index;

@end

@interface XYRegulationTopView : UIView

@property (nonatomic, weak) id<XYRegulationTopViewDelegate> delegate;

@end

NS_ASSUME_NONNULL_END
