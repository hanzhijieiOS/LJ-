//
//  XYInfoTableView.m
//  智慧党建
//
//  Created by 韩智杰 on 2019/5/28.
//  Copyright © 2019年 韩智杰. All rights reserved.
//

#import "XYInfoTableView.h"
#import "XYInfomationCell.h"
#import "XYLoginItemModel.h"

@interface XYInfoTableView()<UITableViewDelegate, UITableViewDataSource>

@property (nonatomic, strong) XYLoginItemModel * itemModel;

@property (nonatomic, copy) NSArray * valueArray;

@property (nonatomic, copy) NSArray * itemArray;

@end

@implementation XYInfoTableView

- (instancetype)initWithFrame:(CGRect)frame style:(UITableViewStyle)style{
    self = [super initWithFrame:frame style:style];
    if (self) {
        self.dataSource = self;
        self.delegate = self;
    }
    return self;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSData *defaultsData = [[NSUserDefaults standardUserDefaults] objectForKey:XYCurrentUserInfo];
    if (!defaultsData) {
        return nil;
    }
    XYLoginItemModel *defaultsModel = [NSKeyedUnarchiver unarchiveObjectWithData:defaultsData];
    XYInfomationCell * cell = [tableView dequeueReusableCellWithIdentifier:@"CELLID"];
    if (!cell) {
        cell = [[XYInfomationCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"CELLID"];
    }
    NSString * data = @"";
    if (![[defaultsModel valueForKey:self.valueArray[indexPath.row]] isKindOfClass:[NSString class]]) {
        data = [NSString stringWithFormat:@"%@",[defaultsModel valueForKey:self.valueArray[indexPath.row]]];
//        data = [[defaultsModel valueForKey:self.valueArray[indexPath.row]] string];
    }else{
        data = [defaultsModel valueForKey:self.valueArray[indexPath.row]];
    }
    [cell updateContentWithItem:self.itemArray[indexPath.row] data:data];
    return cell;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    return self.itemArray.count;
}

- (NSArray *)itemArray{
    if (!_itemArray.count) {
        _itemArray = [NSArray arrayWithObjects:@"姓名", @"性别", @"民族", @"出生日期", @"党员身份", @"入党日期", @"联系方式", @"邮箱", nil];
        _valueArray = [NSArray arrayWithObjects:@"name", @"sex", @"nationality", @"birthDay", @"identityValue", @"joinPartyDate", @"tel", @"email", nil];
    }
    return _itemArray;
}

@end
