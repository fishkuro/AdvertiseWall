

#import <UIKit/UIKit.h>

@class SKInterstitialView;

@protocol SKInterstitialDelegate <NSObject>

@required
/**
 *  当插屏广告调用了 skInterstitialPrepare 方法后会返回广告状态和提示消息
 *  此代理方法必须实现，，只有当  adStatusNormal 是YES的时候
 *  才可以调用 skInterstitialShow 方法来展示插屏广告
 *
 *  @param interstView    当前插屏广告
 *  @param adStatusNormal 是否正常
 *  @param message        提示消息
 */
- (void)skInterstitialView:(SKInterstitialView *)interstView
                  adStatus:(BOOL)adStatusNormal
               withMessage:(NSString *)message;

@end


@interface SKInterstitialView : UIView

@property (copy, nonatomic) NSString *skUidString;
@property (assign, nonatomic) id<SKInterstitialDelegate> delegate;

/**
 *  初始化方法，广告位id必须是插屏的广告位。
 *  视图控制器不能为空
 *
 *  @param skUidString 广告位id
 *  @param rootCtrl    视图控制器
 *
 *  @return 插屏广告实例
 */
- (id)initWithSKUid:(NSString *)skUidString
     rootController:(UIViewController *)rootCtrl;

/**
 *  预备加载插屏广告，然后会调用代理方法返回广告状态
 */
- (void)skInterstitialPrepare;

/**
 *  展示插屏广告
 */
- (void)skInterstitialShow;


@end
