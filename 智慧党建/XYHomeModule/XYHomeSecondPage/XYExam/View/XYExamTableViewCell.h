//
//  XYExamTableViewCell.h
//  智慧党建
//
//  Created by 韩智杰 on 2019/4/27.
//  Copyright © 2019年 韩智杰. All rights reserved.
//

#import "XYBaseTableViewCell.h"

@interface XYExamTableViewCell : XYBaseTableViewCell

@property (nonatomic, copy) void(^selectAnswerBlock)(NSString *, NSInteger answerCount);

/**
 *  cell的创建 默认重用
 *  @param tableView    tableView
 *  @param count        答案的数目（必传）
 */
+ (instancetype)questionAnswerCellWithTable:(UITableView *)tableView answersCount:(NSInteger)count;

///**
// *  设置问题的cell
// *  @param questionModel 模型
// *  @param selectedIndexpathArray  选中答案数组
// *  @param indexPath  indexpath
// */
//- (void)setCellDataWithSCYCreditLoginQuestionModel:(ZTHQuestionModel *)questionModel andSelectedIndexpathArray:(NSMutableArray *)selectedIndexpathArray andIndexPath:(NSIndexPath *)indexPath;

/**
 * 返回cell的行高
 *  @param object    问题内容数组
 *  return           cell的总高度
 */
+ (CGFloat)tableView:(UITableView *)tableView rowHeightForObject:(id)object;

@end
