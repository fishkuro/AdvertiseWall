#import <UIKit/UIKit.h>

typedef enum  {
    SKScoreResultQuery,         //查询积分后返回的结果
    SKScoreResultReduce,        //减少积分后返回的结果
}ScoreResultType;
@class SKAdWallController;
@protocol SKAdWallDelegate <NSObject>

@required

/**
 *
 *  当积分墙调用了 skAdWallPrepare 方法后会返回积分墙的状态和提示消息
 *  此代理方法必须实现，，只有当  adStatusNormal 是YES的时候
 *  才可以调用 skAdWallShow 方法来展示积分墙
 *
 *  @param adWallCtrl     当前积分墙
 *  @param adStatusNormal 积分墙是否正常
 *  @param message        提示消息
 */
- (void)skAdWallController:(SKAdWallController *)adWallCtrl
                  adStatus:(BOOL)adStatusNormal
               withMessage:(NSString *)message;
@optional

/**
 *  对积分进行操作（查询，减少）后会回调此代理方法
 *  如果用户在初始化方法中设置了 userIdString 会在此方法中返回
 *  如果没有设置 则返回 nil
 *
 *  @param status     操作是否成功
 *  @param userIDString 用户id
 *  @param resultType 结果的类型（查询结果，减少结果）
 *  @param score      当前积分
 *  @param message    提示消息
 */
- (void)skAdWallOperateScoreResultStatus:(BOOL)status
                            userIdString:(NSString *)userIDString
                              resultType:(ScoreResultType)resultType
                            currentScore:(NSUInteger)score
                             WithMessage:(NSString *)message;



@end


@interface SKAdWallController : UIViewController

@property (copy, nonatomic) NSString *skUidString;
@property (assign, nonatomic) id<SKAdWallDelegate> delegate;

/**
 *  初始化方法，广告位id必须是积分墙的广告位。
 *  视图控制器不能为空
 *
 *  @param skUidString 广告位id
 *  @param rootCtrl    视图控制器
 *
 *  @return 积分墙控制器实例
 */
- (id)initWithSKUid:(NSString *)skUidString
     rootController:(UIViewController *)rootCtrl;

/**
 *  初始化方法，广告位id必须是积分墙的广告位。
 *  如果开发者的应用有标识来区分不同的用户，可以设置 userIdString 对不同用户的积分进行操作
 *  视图控制器不能为空
 *
 *  @param skUidString  广告位id
 *  @param userIdString 用户id
 *  @param rootCtrl     视图控制器
 *
 *  @return 积分墙控制器实例
 */
- (id)initWithSKUid:(NSString *)skUidString
          andUserId:(NSString *)userIdString
     rootController:(UIViewController *)rootCtrl;


/**
 *  预备加载积分墙，然后会调用代理方法返回积分墙状态
 */
- (void)skAdWallPrepare;

/**
 *  展示积分墙
 */
- (void)skAdWallShow;


/**
 *  查询积分
 *
 */
- (void)skAdWallQueryScore;


/**
 *  减少积分
 *
 *  @param score       要减少的积分数量
 */
- (void)skAdWallReduceScore:(NSUInteger)score;



@end
