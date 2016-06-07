//
//  XZClassEvauationTableViewCell.h
//  ZhiYu
//
//  Created by 吕浩轩 on 16/5/31.
//  Copyright © 2016年 上海先致信息股份有限公司. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "ClassEvaluationListsModel.h"
#import "XZCellLayout.h"

@class XZClassEvauationTableViewCell;

@protocol TableViewCellDelegate <NSObject>

- (void)tableViewCell:(XZClassEvauationTableViewCell *)cell didClickedImageWithCellLayout:(XZCellLayout *)layout
              atIndex:(NSInteger)index;

- (void)tableViewCell:(XZClassEvauationTableViewCell *)cell didClickedLinkWithData:(id)data;

- (void)tableViewCell:(XZClassEvauationTableViewCell *)cell didClickedCommentWithCellLayout:(XZCellLayout *)layout
          atIndexPath:(NSIndexPath *)indexPath;

- (void)tableViewCell:(XZClassEvauationTableViewCell *)cell didClickedLikeButtonWithIsLike:(BOOL)isLike atIndexPath:(NSIndexPath *)indexPath;

@end

@interface XZClassEvauationTableViewCell : UITableViewCell

@property (nonatomic, strong) ClassEvaluationListsModel *model;
@property (nonatomic,weak) id <TableViewCellDelegate> delegate;
@property (nonatomic,strong) XZCellLayout* cellLayout;
@property (nonatomic,strong) NSIndexPath* indexPath;



- (void)setModel:(ClassEvaluationListsModel *)model indexPath:(NSIndexPath *)indexPath;

@end
