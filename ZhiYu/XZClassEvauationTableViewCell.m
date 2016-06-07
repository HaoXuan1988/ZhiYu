//
//  XZClassEvauationTableViewCell.m
//  ZhiYu
//
//  Created by 吕浩轩 on 16/5/31.
//  Copyright © 2016年 上海先致信息股份有限公司. All rights reserved.
//

#import "XZClassEvauationTableViewCell.h"
#import "Menu.h"


@interface XZClassEvauationTableViewCell ()<LWAsyncDisplayViewDelegate>

@property (nonatomic,strong) LWAsyncDisplayView* asyncDisplayView;
@property (nonatomic,strong) UIButton* menuButton;
@property (nonatomic,strong) Menu* menu;
@property (nonatomic,strong) UIView* line;

@end


@implementation XZClassEvauationTableViewCell
{
    CGFloat totalHeight;
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        self.backgroundColor = [UIColor whiteColor];
        [self.contentView addSubview:self.asyncDisplayView];
//        [self.contentView addSubview:self.menuButton];
//        [self.contentView addSubview:self.menu];
//        [self.contentView addSubview:self.line];
        
    }
    return self;
}


#pragma mark - Actions

/***  点击图片  ***/
- (void)lwAsyncDisplayView:(LWAsyncDisplayView *)asyncDisplayView
   didCilickedImageStorage:(LWImageStorage *)imageStorage
                     touch:(UITouch *)touch{
    CGPoint point = [touch locationInView:self];
    for (NSInteger i = 0; i < self.cellLayout.imagePostionArray.count; i ++) {
        CGRect imagePosition = CGRectFromString(self.cellLayout.imagePostionArray[i]);
        if (CGRectContainsPoint(imagePosition, point)) {
            if ([self.delegate respondsToSelector:@selector(tableViewCell:didClickedImageWithCellLayout:atIndex:)] &&
                [self.delegate conformsToProtocol:@protocol(TableViewCellDelegate)]) {
                [self.delegate tableViewCell:self didClickedImageWithCellLayout:self.cellLayout atIndex:i];
            }
        }
        
    }
}

/***  点击文本链接 ***/
- (void)lwAsyncDisplayView:(LWAsyncDisplayView *)asyncDisplayView didCilickedLinkWithfData:(id)data {
    if ([self.delegate respondsToSelector:@selector(tableViewCell:didClickedLinkWithData:)] &&
        [self.delegate conformsToProtocol:@protocol(TableViewCellDelegate)]) {
        [self.delegate tableViewCell:self didClickedLinkWithData:data];
    }
}

/***  点击菜单按钮  ***/
- (void)didClickedMenuButton {
    [self.menu clickedMenu];
}

/***  点击评论 ***/
- (void)didClickedCommentButton {
    if ([self.delegate respondsToSelector:@selector(tableViewCell:didClickedCommentWithCellLayout:atIndexPath:)]) {
        [self.delegate tableViewCell:self didClickedCommentWithCellLayout:self.cellLayout atIndexPath:self.indexPath];
        [self.menu menuHide];
    }
}

//** 点赞 **//
- (void)didclickedLikeButton:(LikeButton *)likeButton {
    __weak typeof(self) weakSelf = self;
    [likeButton likeButtonAnimationCompletion:^(BOOL isSelectd) {
        [weakSelf.menu menuHide];
        if ([weakSelf.delegate respondsToSelector:@selector(tableViewCell:didClickedLikeButtonWithIsLike:atIndexPath:)]) {
            [weakSelf.delegate tableViewCell:weakSelf didClickedLikeButtonWithIsLike:!weakSelf.cellLayout.stautsModel.isLike atIndexPath:weakSelf.indexPath];
        }
    }];
}


#pragma mark - Draw and setup

- (void)setCellLayout:(XZCellLayout *)cellLayout {
    if (_cellLayout == cellLayout) {
        return;
    }
    _cellLayout = cellLayout;
    self.asyncDisplayView.layout = self.cellLayout;
    self.menu.statusModel = self.cellLayout.stautsModel;
}

- (void)layoutSubviews {
    [super layoutSubviews];
    self.asyncDisplayView.frame = CGRectMake(0,0,SCREEN_WIDTH,self.cellLayout.cellHeight);
//    self.menuButton.frame = self.cellLayout.menuPosition;
//    self.menu.frame = CGRectMake(self.cellLayout.menuPosition.origin.x - 5.0f,self.cellLayout.menuPosition.origin.y - 9.0f + 14.5f,0,34);
//    self.line.frame = self.cellLayout.lineRect;
}

- (void)extraAsyncDisplayIncontext:(CGContextRef)context size:(CGSize)size isCancelled:(LWAsyncDisplayIsCanclledBlock)isCancelled {
    if (!isCancelled()) {
        //绘制分割线
        CGContextMoveToPoint(context, 0.0f, self.bounds.size.height);
        CGContextAddLineToPoint(context, self.bounds.size.width, self.bounds.size.height);
        CGContextSetLineWidth(context, 0.2f);
        CGContextSetStrokeColorWithColor(context,RGB(220.0f, 220.0f, 220.0f, 1).CGColor);
        CGContextStrokePath(context);
        
//        if ([self.cellLayout.stautsModel.type isEqualToString:@"website"]) {
//            CGContextAddRect(context, self.cellLayout.websiteRect);
//            CGContextSetFillColorWithColor(context, RGB(240, 240, 240, 1).CGColor);
//            CGContextFillPath(context);
//        }
    }
}



#pragma mark - Getter

- (LWAsyncDisplayView *)asyncDisplayView {
    if (!_asyncDisplayView) {
        _asyncDisplayView = [[LWAsyncDisplayView alloc] initWithFrame:CGRectZero maxImageStorageCount:210];
        _asyncDisplayView.delegate = self;
    }
    return _asyncDisplayView;
}

- (UIButton *)menuButton {
    if (_menuButton) {
        return _menuButton;
    }
    _menuButton = [UIButton buttonWithType:UIButtonTypeCustom];
    [_menuButton setImage:[UIImage imageNamed:@"[menu]"] forState:UIControlStateNormal];
    _menuButton.imageEdgeInsets = UIEdgeInsetsMake(14.5f, 12.0f, 14.5f, 12.0f);
    [_menuButton addTarget:self action:@selector(didClickedMenuButton) forControlEvents:UIControlEventTouchUpInside];
    return _menuButton;
}

- (Menu *)menu {
    if (_menu) {
        return _menu;
    }
    _menu = [[Menu alloc] initWithFrame:CGRectZero];
    [_menu.commentButton addTarget:self action:@selector(didClickedCommentButton)
                  forControlEvents:UIControlEventTouchUpInside];
    [_menu.likeButton addTarget:self action:@selector(didclickedLikeButton:)
               forControlEvents:UIControlEventTouchUpInside];
    return _menu;
}

- (UIView *)line {
    if (_line) {
        return _line;
    }
    _line = [[UIView alloc] initWithFrame:CGRectZero];
    _line.backgroundColor = RGB(220.0f, 220.0f, 220.0f, 1);
    return _line;
}

- (void)setModel:(ClassEvaluationListsModel *)model indexPath:(NSIndexPath *)indexPath {
    
    _model = model;
    totalHeight = 0;

}

- (CGSize)sizeThatFits:(CGSize)size {
    
    return CGSizeMake(size.width, self.cellLayout.cellHeight);
}


- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
