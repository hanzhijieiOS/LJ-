//
//  XYHomeCollectionCell.m
//  智慧党建
//
//  Created by 韩智杰 on 2019/1/2.
//  Copyright © 2019年 韩智杰. All rights reserved.
//

#import "XYHomeCollectionCell.h"
#import "XYHomeCollectionViewCell.h"

@interface XYHomeCollectionCell()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionView * collectionView;

@property (nonatomic, copy) NSArray * imgArray;
@property (nonatomic, copy) NSArray * itemArray;
@property (nonatomic, copy) NSArray * vcArray;

@end

@implementation XYHomeCollectionCell

static NSString * cellIdentifier = @"XYHomeCollectionViewCell";

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        [self initializeCollectionView];
        self.backgroundColor = [UIColor whiteColor];
        self.imgArray = [NSArray arrayWithObjects:@"zy_dangfei.png",@"zy_dangzhang.png",@"zy_kaoshi.png",@"zy_gonggao.png",@"zy_huiyi.png",@"zy_kaoshi.png",@"zy_ziliao.png",@"zy_gengduo.png", nil];
        self.itemArray = [NSArray arrayWithObjects:@"党费缴纳",@"党章党规",@"在线考试",@"公示公告",@"党员会议",@"支部在线",@"党课资料",@"查看更多", nil];
        self.vcArray = [NSArray arrayWithObjects:@"XYPaymentViewController", @"XYRegulationController", @"ZTHHomeTableViewController", nil];
    }
    return self;
}

- (void)initializeCollectionView{
    UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
    layout.itemSize = CGSizeMake(SCREENWIDTH / 4.0 - 1, SCREENWIDTH / 4.0 - 1);
    layout.minimumLineSpacing = 0;
    layout.minimumInteritemSpacing = 0;
    layout.sectionInset = UIEdgeInsetsMake(0., 0., 0., 0.);
    self.collectionView = [[UICollectionView alloc] initWithFrame:CGRectZero collectionViewLayout:layout];
    [self.collectionView registerClass:[XYHomeCollectionViewCell class] forCellWithReuseIdentifier:cellIdentifier];
    self.collectionView.dataSource = self;
    self.collectionView.delegate = self;
    self.collectionView.backgroundColor = [UIColor whiteColor];
    [self.contentView addSubview:self.collectionView];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    [self.collectionView setFrame:CGRectMake(0, 0, self.width, self.height)];
}

+ (CGFloat)getCellHeightWithData:(NSObject *)data{
    return SCREENWIDTH / 2.0;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return 8;
}

- (__kindof UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    XYHomeCollectionViewCell * cell = [collectionView dequeueReusableCellWithReuseIdentifier:cellIdentifier forIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
    cell.imageView.image = [UIImage imageNamed:self.imgArray[indexPath.row]];
    cell.titleLabel.text = self.itemArray[indexPath.row];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (indexPath.row >= self.vcArray.count) {
        return;
    }
    NSString * urlStr = [NSString stringWithFormat:@"XYHome://Home/%@?Scheme=0",self.vcArray[indexPath.row]];
    NSString * URLS = [urlStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
    NSURL * URL = [NSURL URLWithString:URLS];
    [[UIApplication sharedApplication] openURL:URL options:[NSDictionary dictionary] completionHandler:nil];
}

@end
