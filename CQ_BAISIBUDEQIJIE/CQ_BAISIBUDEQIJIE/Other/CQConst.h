
#import <UIKit/UIKit.h>

typedef enum{
    CQTopicControllerTypeAll = 1,
    CQTopicControllerTypePicture = 10,
    CQTopicControllerTypeWord = 29,
    CQTopicControllerTypeVoice = 31,
    CQTopicControllerTypeVideo = 41
}CQTopicControllerType;

UIKIT_EXTERN CGFloat const CQTitleViewsHeight;
UIKIT_EXTERN CGFloat const CQTitleViewsY ;
UIKIT_EXTERN CGFloat const CQTabBarHeight;
UIKIT_EXTERN CGFloat const CQTopicCellMargin;
/** 精华-cell-文字内容的Y值 */
UIKIT_EXTERN CGFloat const CQTopicCellTextY;
/** 精华-cell-底部工具条的高度 */
UIKIT_EXTERN CGFloat const CQTopicCellBottomBarH ;

/** 精华-cell-图片帖子的最大高度 */
UIKIT_EXTERN CGFloat const CQTopicCellPictureMaxH;
/** 精华-cell-图片帖子一旦超过最大高度,就是用Break */
UIKIT_EXTERN CGFloat const CQTopicCellPictureBreakH;

/** XMGUser模型-性别属性值 */
UIKIT_EXTERN NSString * const CQUserSexMale;
UIKIT_EXTERN NSString * const CQUserSexFemale;


/** 精华-cell-最热评论标题的高度 */
UIKIT_EXTERN CGFloat const CQTopicCellTopCmtTitleH;

/** tabBar被选中的通知名字 */
UIKIT_EXTERN NSString * const CQTabBarDidSelectNotification;

UIKIT_EXTERN CGFloat const CQTagMargin;
UIKIT_EXTERN CGFloat const CQTagHeight;




