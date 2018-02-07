#import <UIKit/UIKit.h>
#import <Foundation/Foundation.h>
#import <SystemConfiguration/SystemConfiguration.h>
#import <StoreKit/StoreKit.h>
#import <CoreMedia/CoreMedia.h>
#import <CoreGraphics/CoreGraphics.h>
#import <AVKit/AVKit.h>
#import <AVFoundation/AVFoundation.h>
#import <AdSupport/AdSupport.h>
#import <QuartzCore/QuartzCore.h>

#import <Tapdaq/Tapdaq.h>
#import "FPANEUtils.h"
#import "FREConversionUtil.h"

#define SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(v)  ([[[UIDevice currentDevice] systemVersion] compare:v options:NSNumericSearch] != NSOrderedAscending)

#define TapdaqContextType @"tapdaq"
#define OfferwallContextType @"offerwall"
#define MoreAppsContextType @"moreapps"
#define BannerContextType @"banner"

//
//callback events
//
static NSString *const kTapdaqLibEvent_DID_INITIALIZE = @"AirTapdaqEvent_onDidInitialize";
static NSString *const kTapdaqLibAdEvent_AD_LOADED = @"AirTapdaqAdEvent_onAdLoaded";
static NSString *const kTapdaqLibAdEvent_DID_FAIL_TO_LOAD = @"AirTapdaqAdEvent_onDidFailToLoad";
static NSString *const kTapdaqLibAdEvent_DID_DISPLAY = @"AirTapdaqAdEvent_onDidDisplay";
static NSString *const kTapdaqLibAdEvent_DID_CLOSE = @"AirTapdaqAdEvent_onDidClose";
static NSString *const kTapdaqLibAdEvent_DID_CLICK = @"AirTapdaqAdEvent_onDidClick";
static NSString *const kTapdaqLibAdEvent_DID_VERIFY = @"AirTapdaqAdEvent_onDidVerify";
static NSString *const kTapdaqLibAdEvent_DID_REWARD_FAIL = @"AirTapdaqAdEvent_onDidRewardFail";
static NSString *const kTapdaqLibAdEvent_NOT_AVAILABLE = @"AirTapdaqAdEvent_onNotAvailable";
static NSString *const kTapdaqLibNativeAdDataEvent_AD_DATA = @"AirTapdaqNativeAdDataEvent_ad_data";
static NSString *const kTapdaqLibAdEvent_WILL_DISPLAY = @"AirTapdaqAdEvent_onWillDisplay";


#define TAPDAQ_CALLBACK_EVENT_DID_LOAD "load"
#define TAPDAQ_CALLBACK_EVENT_DID_FAIL_LOAD "failload"
#define TAPDAQ_CALLBACK_EVENT_DID_SHOW "show"
#define TAPDAQ_CALLBACK_EVENT_DID_CLICK "click"
#define TAPDAQ_CALLBACK_EVENT_DID_HIDE "hide"
#define TAPDAQ_CALLBACK_EVENT_DID_CLOSE "close"
#define TAPDAQ_CALLBACK_EVENT_CUSTOM "custom"
#define TAPDAQ_CALLBACK_EVENT_DID_REFRESH "refresh"

@interface TapdaqLib : NSObject <TapdaqDelegate>
    struct BannerConfigurationData{
        NSInteger hAlign;
        NSInteger vAlign;
        NSInteger marginTop;
        NSInteger marginLeft;
        NSInteger marginBottom;
        NSInteger marginRight;
    };


    @property (nonatomic, assign) UIView* bannerView;
    @property (strong, nonatomic) NSArray<NSLayoutConstraint *> *constraintsBanner;
    @property (nonatomic, strong) NSMutableDictionary* nativeAdsByCreativeTypePlacecementTag;
    @property (nonatomic, strong) NSString *contextType;
    - (id) initWithContextType: (NSString *) contextType;
    + (void)dispatchEvent:(const char *)eventName withMessage:(NSString *)message withContextType:(NSString *)contextType;

@end

FREContext TapdaqCtx = nil;
FREContext OfferwallCtx = nil;
FREContext MoreAppsCtx = nil;
FREContext BannerCtx = nil;



FREContext GetContextForType(NSString * contextType);

void ExtensionInitializer(void** extDataToSet, FREContextInitializer* ctxInitializerToSet, FREContextFinalizer* ctxFinalizerToSet);
void ExtensionFinalizer(void *extData);

void ContextInitializer(void* extData, const uint8_t* ctxType, FREContext ctx, uint32_t* numFunctionsToTest, const FRENamedFunction** functionsToSet);
void ContextFinalizer(FREContext ctx);

