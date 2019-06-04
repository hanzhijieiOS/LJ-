//
//  XYCycleScrollViewCell.m
//  智慧党建
//
//  Created by 韩智杰 on 2019/1/2.
//  Copyright © 2019年 韩智杰. All rights reserved.
//

#import "XYCycleScrollViewCell.h"
#import "SDCycleScrollView.h"
#define ImageHeight 30
#define ImageWidth 30

@interface XYCycleScrollViewCell()<SDCycleScrollViewDelegate>

@property (nonatomic, strong) SDCycleScrollView * cycleScrollView;
@property (nonatomic, strong) UIImageView * _imageView;

@end

@implementation XYCycleScrollViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initializeCycleScrollView];
        self._imageView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"home_news.png"]];
        self._imageView.contentMode = UIViewContentModeScaleAspectFill;
        [self.contentView addSubview:self._imageView];
    }
    return self;
}

- (void)initializeCycleScrollView{
    self.cycleScrollView = [SDCycleScrollView cycleScrollViewWithFrame:CGRectZero delegate:self placeholderImage:nil];
    self.cycleScrollView.scrollDirection = UICollectionViewScrollDirectionVertical;
    self.cycleScrollView.onlyDisplayText = YES;
    NSMutableArray *titlesArray = [NSMutableArray new];
    [titlesArray addObject:@"七一献礼：党组书记的一堂党课"];
    [titlesArray addObject:@"庆祝建党97周年"];
    [titlesArray addObjectsFromArray:titlesArray];
    self.cycleScrollView.titlesGroup = [titlesArray copy];
    [self.cycleScrollView disableScrollGesture];
    self.cycleScrollView.autoScrollTimeInterval = 3.0;
    self.cycleScrollView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.cycleScrollView];
}


- (void)cycleScrollView:(SDCycleScrollView *)cycleScrollView didSelectItemAtIndex:(NSInteger)index{
    
}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.cycleScrollView.frame = CGRectMake(KEdgeSpacing + ImageWidth, 0, self.width - KEdgeSpacing * 2 - ImageWidth, self.height);
    self._imageView.frame = CGRectMake(KEdgeSpacing, (self.height - ImageHeight) / 2.0, ImageWidth, ImageHeight);
}

+ (CGFloat)getCellHeightWithData:(NSObject *)data{
    return 40;
}

@end
