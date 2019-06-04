//
//  XYMineHeaderView.m
//  智慧党建
//
//  Created by 韩智杰 on 2019/3/2.
//  Copyright © 2019年 韩智杰. All rights reserved.
//

#import "XYMineHeaderView.h"
#import "XYLoginManager.h"
//#import "XYLoginItemModel.h"
#define K_TopGap 13

@implementation XYMineHeaderView

- (instancetype)initWithFrame:(CGRect)frame{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor whiteColor];
        [self addSubview:self.backgroundImage];
        [self addSubview:self.namelabel];
        [self addSubview:self.statusLabel];
        [self addSubview:self.imageView];
        [self addSubview:self.sectionLabel];
        [self addSubview:self.sexImgView];
        [self addSubview:self.joinTimeLabel];
        UITapGestureRecognizer * tapGR = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(headerViewDidClick)];
        [self addGestureRecognizer:tapGR];
    }
    return self;
}

- (void)headerViewDidClick{
    if (![[XYLoginManager sharedManager] isLogin]) {
        NSString * URLStr = @"XYMine://Mine/XYLoginController?Scheme=1";
        NSString * URLS = [URLStr stringByAddingPercentEncodingWithAllowedCharacters:[NSCharacterSet URLQueryAllowedCharacterSet]];
        NSURL * URL = [NSURL URLWithString:URLS];
        [[UIApplication sharedApplication] openURL:URL options:[NSDictionary dictionary] completionHandler:nil];
    }
}

- (void)reloadData{
    BOOL isLogin = [[XYLoginManager sharedManager] isLogin];
    if (isLogin) {
        NSData *defaultsData = [[NSUserDefaults standardUserDefaults] objectForKey:XYCurrentUserInfo];
        if (!defaultsData) {
            return;
        }
        XYLoginItemModel *defaultsModel = [NSKeyedUnarchiver unarchiveObjectWithData:defaultsData];
        self.namelabel.text = defaultsModel.name;
        
        NSString * sectionStr = defaultsModel.identityValue;
        if (!sectionStr.length) {
            sectionStr = @"西安邮电大学";
        }
        self.sectionLabel.text = sectionStr;
        
        UIImage * image = nil;
        if (defaultsModel.sex) {
            image = [UIImage imageNamed:@"男.png"];
        }else{
            image = [UIImage imageNamed:@"女.png"];
        }
        self.sexImgView.image = image;
        
        NSString * joinTime = defaultsModel.joinPartyDate;
        if (!joinTime.length) {
            joinTime = @"2015-09-01";
        }
        self.joinTimeLabel.text = joinTime;
        
        [self.imageView sd_setImageWithURL:[NSURL URLWithString:@""] placeholderImage:[UIImage imageNamed:@"dangzhang.png"]];
        
    }else{
        self.namelabel.text = @"未登录，点击登录";
        self.sectionLabel.text = @"";
        self.sexImgView.image = nil;
        self.joinTimeLabel.text = @"";
        [self.imageView setImage:[UIImage imageNamed:@"dangzhang.png"]];
    }
    [self setNeedsLayout];
}

- (void)layoutSubviews{
    [super layoutSubviews];
    
    self.backgroundImage.frame = CGRectMake(0, 0, self.height / 1.6, self.height / 1.6);
    self.backgroundImage.center = CGPointMake(self.width / 2.0, self.height / 2.0);
    
    self.namelabel.frame = CGRectMake(K_LeftGap, K_TopGap, 0, 22);
    [self.namelabel sizeToFit];
    
    [self.statusLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.namelabel.mas_bottom);
        make.left.equalTo(self.namelabel.mas_right).offset(3);
        make.width.mas_equalTo(150);
        make.height.mas_equalTo(15);
    }];
    
    self.sectionLabel.frame = CGRectMake(K_LeftGap, self.height - 2 * K_TopGap, 0, 20);
    [self.sectionLabel sizeToFit];
    
    self.joinTimeLabel.frame = CGRectMake(self.sectionLabel.right + 15, self.sectionLabel.top, 0, 20);
    [self.joinTimeLabel sizeToFit];
    
    [self.imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.namelabel);
        make.right.equalTo(self).offset(- K_LeftGap);
        make.width.height.mas_equalTo(70);
    }];
    
    self.imageView.layer.cornerRadius = 35;
    self.imageView.layer.masksToBounds = YES;
    
    UIBezierPath *shadowPath = [UIBezierPath bezierPathWithRect:self.bounds];
    self.layer.masksToBounds = NO;
    self.layer.cornerRadius = 5;
    self.layer.shadowColor = [UIColor blackColor].CGColor;
    self.layer.shadowOffset = CGSizeMake(0.0f, 0.0f);
    self.layer.shadowOpacity = 0.5f;
    self.layer.shadowPath = shadowPath.CGPath;
    
    self.sexImgView.frame = CGRectMake(self.namelabel.right + 3, 0, 20, 20);
    self.sexImgView.centerY = self.namelabel.centerY;
}

- (UILabel *)namelabel{
    if (!_namelabel) {
        _namelabel = [[UILabel alloc] init];
        _namelabel.font = [UIFont systemFontOfSize:18 weight:1.7];
        _namelabel.backgroundColor = [UIColor clearColor];
    }
    return _namelabel;
}

- (UILabel *)statusLabel{
    if (!_statusLabel) {
        _statusLabel = [[UILabel alloc] init];
        _statusLabel.font = [UIFont systemFontOfSize:12];
//        _statusLabel.text = @"(预备党员)";
    }
    return _statusLabel;
}

- (UILabel *)sectionLabel{
    if (!_sectionLabel) {
        _sectionLabel = [[UILabel alloc] init];
        _sectionLabel.font = [UIFont systemFontOfSize:15];
//        _sectionLabel.text = @"西安邮电大学";
    }
    return _sectionLabel;
}

- (UIImageView *)imageView{
    if (!_imageView) {
        _imageView = [[UIImageView alloc] init];
        _imageView.backgroundColor = [UIColor whiteColor];
    }
    return _imageView;
}

- (UIImageView *)sexImgView{
    if (!_sexImgView) {
        _sexImgView = [[UIImageView alloc] init];
        _sexImgView.backgroundColor = [UIColor clearColor];
        _sexImgView.contentMode = UIViewContentModeScaleAspectFit;
    }
    return _sexImgView;
}

- (UIImageView *)backgroundImage{
    if (!_backgroundImage) {
        _backgroundImage = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"dl_danghui.png"]];
        _backgroundImage.backgroundColor = [UIColor clearColor];
        _backgroundImage.alpha = 0.25;
    }
    return _backgroundImage;
}

- (UILabel *)joinTimeLabel{
    if (!_joinTimeLabel) {
        _joinTimeLabel = [[UILabel alloc] initWithFrame:CGRectZero];
        _joinTimeLabel.font = [UIFont systemFontOfSize:15];
        _joinTimeLabel.backgroundColor = [UIColor clearColor];
    }
    return _joinTimeLabel;
}

@end
