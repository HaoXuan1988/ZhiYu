




/********************* 有任何问题欢迎反馈给我 liuweiself@126.com ****************************************/
/***************  https://github.com/waynezxcv/Gallop 持续更新 ***************************/
/******************** 正在不断完善中，谢谢~  Enjoy ******************************************************/









#import <UIKit/UIKit.h>
#import "LikeButton.h"
#import "ClassEvaluationListsModel.h"


@interface Menu : UIView

@property (nonatomic,strong) LikeButton* likeButton;
@property (nonatomic,strong) UIButton* commentButton;
@property (nonatomic,strong) ClassEvaluationListsModel* statusModel;

- (void)clickedMenu;
- (void)menuShow;
- (void)menuHide;

@end
