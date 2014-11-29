

#import <UIKit/UIKit.h>


@class SKBannerView;

@protocol SKBannerViewDelegate <NSObject>

@required

/**
 *  当横幅广告调用了 skBannerPrepare 方法后会返回广告状态和提示消息
 *  此代理方法必须实现，，只有当  adStatusNormal 是YES的时候
 *  才可以调用 skBannerShow 方法来展示插屏广告
 *
 *  @param bannerView     当前横幅广告
 *  @param adStatusNormal 是否正常
 *  @param message        提示消息
 */
- (void)skBannerView:(SKBannerView *)bannerView
            adStatus:(BOOL)adStatusNormal
         withMessage:(NSString *)message;

@end


@interface SKBannerView : UIView

@property (copy, nonatomic) NSString *skUidString;
@property (assign, nonatomic) id<SKBannerViewDelegate> delegate;

/**
 *  初始化方法，广告位id必须是横幅的广告位。
 *  视图控制器不能为空
 *
 *  @param skUidString 广告位id
 *  @param skRect      横幅广告在父视图的位置
 *  @param rootCtrl    视图控制器
 *
 *  @return 横幅广告实例
 */
- (id)initWithSKUid:(NSString *)skUidString
              frame:(CGRect)skRect
     rootController:(UIViewController *)rootCtrl;

/**
 *  预备加载横幅广告，然后会调用代理方法返回广告状态
 */
- (void)skBannerPrepare;

/**
 *  展示横幅广告
 */
- (void)skBannerShow;



@end
