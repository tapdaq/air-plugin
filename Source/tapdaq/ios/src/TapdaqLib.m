#import "TapdaqLib.h"
#import "JsonHelper.h"

@implementation TapdaqLib
static TapdaqLib *sharedInstance = nil;

+ (TapdaqLib *)sharedInstance {
    
    if (sharedInstance == nil)
        sharedInstance = [[super allocWithZone:NULL] init];
    
    return sharedInstance;
}


- (id)copy {
    return self;
}

- (id) initWithContextType: (NSString *) contextType {
    self = [super init];
    if (self) {
        _contextType = contextType;
    }
    
    return self;
}

+ (id)allocWithZone:(NSZone *)zone {
    return [self sharedInstance];
}


+ (void)dispatchEvent:(const char *)eventName withMessage:(NSString *)message withContextType:(NSString *)contextType {
    FREContext context = GetContextForType(contextType);
    
    if (context) {
        if (!message) message = @"";
        FREDispatchStatusEventAsync(context, (const uint8_t *)eventName, (const uint8_t *)[message UTF8String]);
    }
}


NSArray * parsePlacementsJSONString(NSString *placementsString){

    NSMutableArray *result = [[NSMutableArray alloc]init];
    NSData *data = [placementsString dataUsingEncoding:NSUTF8StringEncoding];
    NSArray *placementObjects = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    for (NSDictionary *placementDict in placementObjects)  {
        NSArray *creativeTypes = [placementDict valueForKey:@"creativeTypes"];
        NSUInteger combinedCreativeTypes = parseCreativeTypesArray(creativeTypes);
        NSString *tagValue = [placementDict valueForKey:@"tag"];
        TDPlacement *placement = [[TDPlacement alloc] initWithAdTypes:combinedCreativeTypes forTag:tagValue];
        [result addObject:placement];
    }
    return result;
}

NSUInteger parseAdvertTypesToEnable(NSString *advertTypesToEnable){
    
    NSData *data = [advertTypesToEnable dataUsingEncoding:NSUTF8StringEncoding];
    NSArray *advertsArray = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    NSUInteger combinedAdvertTypes = parseCreativeTypesArray(advertsArray);
    return combinedAdvertTypes;
}


NSUInteger parseCreativeTypesArray(NSArray *creativeTypes){

    NSUInteger creativeTypesCombined = 0;
    for (NSString *creativeTypeString in creativeTypes)
    {
        creativeTypesCombined = creativeTypesCombined | parseCreativeTypeString(creativeTypeString);
    }
    return creativeTypesCombined;

}

NSUInteger parseCreativeTypeString(NSString *creativeType){
    if ([creativeType isEqualToString:@"INTERSTITIAL_LANDSCAPE"]) {
        return TDAdTypeInterstitial;
    }
    else if ([creativeType isEqualToString:@"INTERSTITIAL_PORTRAIT"]) {
        return TDAdTypeInterstitial;
    }
    else if ([creativeType isEqualToString:@"VIDEO_INTERSTITIAL"]) {
        return TDAdTypeVideo;
    }
    else if ([creativeType isEqualToString:@"REWARDED_VIDEO_INTERSTITIAL"]) {
        return TDAdTypeRewardedVideo;
    }
    else if ([creativeType isEqualToString:@"BANNER"]) {
        return TDAdTypeBanner;
    }
    else if ([creativeType isEqualToString:@"SQUARE_SMALL"]) {
        return TDAdType1x1Small;
    }
    else if ([creativeType isEqualToString:@"SQUARE_MEDIUM"]) {
        return TDAdType1x1Medium;
    }
    else if ([creativeType isEqualToString:@"SQUARE_LARGE"]) {
        return TDAdType1x1Large;
    }
    else if ([creativeType isEqualToString:@"NEWSFEED_TALL_SMALL"]) {
        return TDAdType1x2Small;
    }
    else if ([creativeType isEqualToString:@"NEWSFEED_TALL_MEDIUM"]) {
        return TDAdType1x2Medium;
    }
    else if ([creativeType isEqualToString:@"NEWSFEED_TALL_LARGE"]) {
        return TDAdType1x2Large;
    }
    else if ([creativeType isEqualToString:@"NEWSFEED_WIDE_SMALL"]) {
        return TDAdType2x1Small;
    }
    else if ([creativeType isEqualToString:@"NEWSFEED_WIDE_MEDIUM"]) {
        return TDAdType2x1Medium;
    }
    else if ([creativeType isEqualToString:@"NEWSFEED_WIDE_LARGE"]) {
        return TDAdType2x1Large;
    }
    else if ([creativeType isEqualToString:@"FULLSCREEN_TALL_SMALL"]) {
        return TDAdType2x3Small;
    }
    else if ([creativeType isEqualToString:@"FULLSCREEN_TALL_MEDIUM"]) {
        return TDAdType2x3Medium;
    }
    else if ([creativeType isEqualToString:@"FULLSCREEN_TALL_LARGE"]) {
        return TDAdType2x3Large;
    }
    else if ([creativeType isEqualToString:@"FULLSCREEN_WIDE_SMALL"]) {
        return TDAdType3x2Small;
    }
    else if ([creativeType isEqualToString:@"FULLSCREEN_WIDE_MEDIUM"]) {
        return TDAdType3x2Medium;
    }
    else if ([creativeType isEqualToString:@"FULLSCREEN_WIDE_LARGE"]) {
        return TDAdType3x2Large;
    }
    else if ([creativeType isEqualToString:@"STRIP_TALL_SMALL"]) {
        return TDAdType1x5Small;
    }
    else if ([creativeType isEqualToString:@"STRIP_TALL_MEDIUM"]) {
        return TDAdType1x5Medium;
    }
    else if ([creativeType isEqualToString:@"STRIP_TALL_LARGE"]) {
        return TDAdType1x5Large;
    }
    else if ([creativeType isEqualToString:@"STRIP_WIDE_SMALL"]) {
        return TDAdType5x1Small;
    }
    else if ([creativeType isEqualToString:@"STRIP_WIDE_MEDIUM"]) {
        return TDAdType5x1Medium;
    }
    else if ([creativeType isEqualToString:@"STRIP_WIDE_LARGE"]) {
        return TDAdType5x1Large;
    }
    else if ([creativeType isEqualToString:@"OFFERWALL"]) {
        return TDAdTypeOfferwall;
    }   else if ([creativeType isEqualToString:@"NONE"]) {
        return TDAdTypeNone;
    }
    return 0;
}

TDNativeAdType parseNativeAdTypeTypeString(NSString *creativeType){
    
   if ([creativeType isEqualToString:@"SQUARE_SMALL"]) {
        return TDNativeAdType1x1Small;
    }
    else if ([creativeType isEqualToString:@"SQUARE_MEDIUM"]) {
        return TDNativeAdType1x1Medium;
    }
    else if ([creativeType isEqualToString:@"SQUARE_LARGE"]) {
        return TDNativeAdType1x1Large;
    }
    
    else if ([creativeType isEqualToString:@"NEWSFEED_TALL_SMALL"]) {
        return TDNativeAdType1x2Small;
    }
    else if ([creativeType isEqualToString:@"NEWSFEED_TALL_MEDIUM"]) {
        return TDNativeAdType1x2Medium;
    }
    else if ([creativeType isEqualToString:@"NEWSFEED_TALL_LARGE"]) {
        return TDNativeAdType1x2Large;
    }
    
    else if ([creativeType isEqualToString:@"NEWSFEED_WIDE_SMALL"]) {
        return TDNativeAdType2x1Small;
    }
    else if ([creativeType isEqualToString:@"NEWSFEED_WIDE_MEDIUM"]) {
        return TDNativeAdType2x1Medium;
    }
    else if ([creativeType isEqualToString:@"NEWSFEED_WIDE_LARGE"]) {
        return TDNativeAdType2x1Large;
    }
    
    else if ([creativeType isEqualToString:@"FULLSCREEN_TALL_SMALL"]) {
        return TDNativeAdType2x3Small;
    }
    else if ([creativeType isEqualToString:@"FULLSCREEN_TALL_MEDIUM"]) {
        return TDNativeAdType2x3Medium;
    }
    else if ([creativeType isEqualToString:@"FULLSCREEN_TALL_LARGE"]) {
        return TDNativeAdType2x3Large;
    }
    
    else if ([creativeType isEqualToString:@"FULLSCREEN_WIDE_SMALL"]) {
        return TDNativeAdType3x2Small;
    }
    else if ([creativeType isEqualToString:@"FULLSCREEN_WIDE_MEDIUM"]) {
        return TDNativeAdType3x2Medium;
    }
    else if ([creativeType isEqualToString:@"FULLSCREEN_WIDE_LARGE"]) {
        return TDNativeAdType3x2Large;
    }
    
    else if ([creativeType isEqualToString:@"STRIP_TALL_SMALL"]) {
        return TDNativeAdType1x5Small;
    }
    else if ([creativeType isEqualToString:@"STRIP_TALL_MEDIUM"]) {
        return TDNativeAdType1x5Medium;
    }
    else if ([creativeType isEqualToString:@"STRIP_TALL_LARGE"]) {
        return TDNativeAdType1x5Large;
    }
    
    else if ([creativeType isEqualToString:@"STRIP_WIDE_SMALL"]) {
        return TDNativeAdType5x1Small;
    }
    else if ([creativeType isEqualToString:@"STRIP_WIDE_MEDIUM"]) {
        return TDNativeAdType5x1Medium;
    }
    else if ([creativeType isEqualToString:@"STRIP_WIDE_LARGE"]) {
        return TDNativeAdType5x1Large;
    }
   
    
    return 0;
}

TDAdTypes parseAdTypeString(NSString *adTypeString) {

    if ([adTypeString isEqualToString:@"static_interstitial"]) {
        return TDAdTypeInterstitial;
    } else if ([adTypeString isEqualToString:@"video_interstitial"]) {
        return TDAdTypeVideo;
    } else if ([adTypeString isEqualToString:@"rewarded_video_interstitial"]) {
        return TDAdTypeRewardedVideo;
    }
    
    return TDAdTypeInterstitial;
    
}

NSString* parseNativeAdTypeToString(TDNativeAdType nativeAdType){

    
    if (nativeAdType == TDNativeAdType1x1Small) {
        return @"SQUARE_SMALL";
    }
    else if (nativeAdType == TDNativeAdType1x1Medium) {
        return @"SQUARE_MEDIUM";
    }
    else if (nativeAdType == TDNativeAdType1x1Large) {
        return @"SQUARE_LARGE";
    }
    else if (nativeAdType == TDNativeAdType1x2Small) {
        return @"NEWSFEED_TALL_SMALL";
    }
    else if (nativeAdType == TDNativeAdType1x2Medium) {
        return @"NEWSFEED_TALL_MEDIUM";
    }
    else if (nativeAdType == TDNativeAdType1x2Large) {
        return @"NEWSFEED_TALL_LARGE";
    }
    else if (nativeAdType == TDNativeAdType2x1Small) {
        return @"NEWSFEED_WIDE_SMALL";
    }
    else if (nativeAdType == TDNativeAdType2x1Medium) {
        return @"NEWSFEED_WIDE_MEDIUM";
    }
    else if (nativeAdType == TDNativeAdType2x1Large) {
        return @"NEWSFEED_WIDE_LARGE";
    }
    else if (nativeAdType == TDNativeAdType2x3Small) {
        return @"FULLSCREEN_TALL_SMALL";
    }
    else if (nativeAdType == TDNativeAdType2x3Medium) {
        return @"FULLSCREEN_TALL_MEDIUM";
    }
    else if (nativeAdType == TDNativeAdType2x3Large) {
        return @"FULLSCREEN_TALL_LARGE";
    }
    else if (nativeAdType == TDNativeAdType3x2Small) {
        return @"FULLSCREEN_WIDE_SMALL";
    }
    else if (nativeAdType == TDNativeAdType3x2Medium) {
        return @"FULLSCREEN_WIDE_MEDIUM";
    }
    else if (nativeAdType == TDNativeAdType3x2Large) {
        return @"FULLSCREEN_WIDE_LARGE";
    }
    else if (nativeAdType == TDNativeAdType1x5Small) {
        return @"STRIP_TALL_SMALL";
    }
    else if (nativeAdType == TDNativeAdType1x5Medium) {
        return @"STRIP_TALL_MEDIUM";
    }
    else if (nativeAdType == TDNativeAdType1x5Large) {
        return @"STRIP_TALL_LARGE";
    }
    else if (nativeAdType == TDNativeAdType5x1Small) {
        return @"STRIP_WIDE_SMALL";
    }
    else if (nativeAdType == TDNativeAdType5x1Medium) {
        return @"STRIP_WIDE_MEDIUM";
    }
    else if (nativeAdType == TDNativeAdType5x1Large) {
        return @"STRIP_WIDE_LARGE";
    }

    return @"";
}

NSString* parseAdEventDataToJSONString(TDAdTypes adType, NSString* placementTag, NSString *error){
    
    NSString *adTypeParsed;
    if (adType == TDAdTypeInterstitial) {
        adTypeParsed = @"static_interstitial";
    }
    else if (adType == TDAdTypeVideo) {
        adTypeParsed = @"video_interstitial";
    }
    else if (adType == TDAdTypeRewardedVideo) {
        adTypeParsed = @"rewarded_video_interstitial";
    }
    else if (adType == TDAdTypeBanner) {
        adTypeParsed = @"banner";
    }
    else  {
        adTypeParsed = @"native";
    }
    
    NSMutableDictionary *adDataDict = [[NSMutableDictionary alloc]init];
    [adDataDict setValue:adTypeParsed forKey:@"adType"];
    [adDataDict setValue:placementTag forKey:@"placementTag"];
    if (error != NULL) {
        NSMutableDictionary *errorDict = [[NSMutableDictionary alloc]init];
        [errorDict setValue:0 forKey:@"errorCode"];
        [errorDict setValue:error forKey:@"errorMessage"];
        [adDataDict setValue:errorDict forKey:@"error"];
    }
    
    
    NSError *err;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:adDataDict options:NSJSONWritingPrettyPrinted error:&err];
    NSString *jsonDataString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    NSLog(@"JSON = %@", jsonDataString);
    
    return jsonDataString;
    
}

NSString* parseNativeAdEventDataToJSONString(TDNativeAdType nativeAdType, NSString* placementTag, NSString *error ){
    
    NSString *adTypeParsed = @"native";
    NSString *nativeAdTypeParsed = parseNativeAdTypeToString(nativeAdType);
    
    NSMutableDictionary *adDataDict = [[NSMutableDictionary alloc]init];
    [adDataDict setValue:adTypeParsed forKey:@"adType"];
    [adDataDict setValue:placementTag forKey:@"placementTag"];
    [adDataDict setValue:nativeAdTypeParsed forKey:@"nativeAdType"];
    if (error != NULL) {
        NSMutableDictionary *errorDict = [[NSMutableDictionary alloc]init];
        [errorDict setValue:0 forKey:@"errorCode"];
        [errorDict setValue:error forKey:@"errorMessage"];
        [adDataDict setValue:errorDict forKey:@"error"];
    }
    
    NSError *err;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:adDataDict options:NSJSONWritingPrettyPrinted error:&err];
    NSString *jsonDataString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    NSLog(@"JSON = %@", jsonDataString);
    
    return jsonDataString;
    
}


NSString* parseVerificationDataToJSONString(NSString* placementTag, NSString* rewardName, int rewardAmount){
    
    NSString *adTypeParsed = @"rewarded_video_interstitial";
    
    NSMutableDictionary *adDataDict = [[NSMutableDictionary alloc]init];
    [adDataDict setValue:adTypeParsed forKey:@"adType"];
    [adDataDict setValue:placementTag forKey:@"placementTag"];
    [adDataDict setValue:rewardName forKey:@"rewardName"];
    [adDataDict setValue:[NSNumber numberWithInt:rewardAmount] forKey:@"rewardAmount"];
    
    
    NSError *err;
    NSData *jsonData = [NSJSONSerialization dataWithJSONObject:adDataDict options:NSJSONWritingPrettyPrinted error:&err];
    NSString *jsonDataString = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
    
    NSLog(@"JSON = %@", jsonDataString);
    
    return jsonDataString;
    
}



NSString * parseNativeAdToJSONString(TDNativeAdvert *nativeAd, NSString *uniqueId){
    if (nativeAd != nil) {
        NSDictionary* dict = @{
                               @"applicationId": nativeAd.applicationId,
                               @"targetingId": nativeAd.targetingId,
                               @"subscriptionId": nativeAd.subscriptionId,
                               @"appName": nativeAd.appName,
                               @"description": nativeAd.appDescription,
                               @"buttonText": nativeAd.buttonText,
                               @"developerName": nativeAd.developerName,
                               @"ageRating": nativeAd.ageRating,
                               @"appSize": @(nativeAd.appSize),
                               @"averageReview": @(nativeAd.averageReview),
                               @"totalReviews": @(nativeAd.totalReviews),
                               @"category": nativeAd.category,
                               @"appVersion": nativeAd.appVersion,
                               @"price": @(nativeAd.price),
                               @"iconUrl": [nativeAd.iconUrl absoluteString],
                               @"creativeIdentifier": nativeAd.creative.identifier,
                               @"imageUrl": [nativeAd.creative.url absoluteString],
                               @"uniqueId": uniqueId,
                               @"tag": nativeAd.tag
                               };
        
        return [JsonHelper toJsonString: dict] ;
    } else {
        NSLog(@"No nativeAd available");
        return @"{}";
    }
}

NSArray * getTestDevicesFromJSON(NSString *jsonString){
    NSMutableArray *result = [[NSMutableArray alloc]init];
    NSData *data = [jsonString dataUsingEncoding:NSUTF8StringEncoding];
    NSArray *jsonObjects = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableContainers error:nil];
    for (NSDictionary *dataDict in jsonObjects) {
        NSArray *testDevices = [dataDict valueForKey:@"value"];
        NSInteger networkId = [[dataDict valueForKey:@"key"] intValue];
        NSMutableDictionary *resultDict = [[NSMutableDictionary alloc]init];
        
        NSString *networkName = (networkId == 0? TDMAdMob : TDMFacebookAudienceNetwork);
        
        [resultDict setValue:networkName forKey:@"name"];
        [resultDict setValue:testDevices forKey:@"testDevices"];
        [result addObject:resultDict];
    }
    return result;
}

- (NSString*)dictionaryToString:(NSDictionary *)dictionary{
    NSMutableString *resultString = [NSMutableString string];
    for (NSString* key in [dictionary allKeys]){
        if ([resultString length]>0)
            [resultString appendString:@";"];
        [resultString appendFormat:@"%@=%@", key, [dictionary objectForKey:key]];
    }
    return [NSString stringWithString : resultString];
}


#pragma mark Common delegate methods

-(void)didLoadConfig{
    
    FPANE_DispatchEventWithInfo(TapdaqCtx, kTapdaqLibEvent_DID_INITIALIZE, parseAdEventDataToJSONString(TDAdTypeInterstitial, @"", NULL));
    
}

#pragma mark Interstitial delegate methods

/**
 Called immediately after an interstitial is available to the user for a specific placement tag.
 This method should be used in conjunction with -showInterstitialForPlacementTag:.
 @param placementTag A placement tag.
 */
- (void)didLoadInterstitialForPlacementTag:(NSString *)placementTag {
    
    FPANE_DispatchEventWithInfo(TapdaqCtx, kTapdaqLibAdEvent_AD_LOADED, parseAdEventDataToJSONString(TDAdTypeInterstitial, placementTag, NULL));
}

/**
 Called when the interstitial was not able to be loaded for a specific placement tag.
 Tapdaq will automatically attempt to load an interstitial again with a 1 second delay.
 @param placementTag A placement tag.
 */
- (void)didFailToLoadInterstitialForPlacementTag:(NSString *)placementTag {
    
    FPANE_DispatchEventWithInfo(TapdaqCtx, kTapdaqLibAdEvent_DID_FAIL_TO_LOAD, parseAdEventDataToJSONString(TDAdTypeInterstitial, placementTag, @"Failed to load static interstitial"));
}

/**
 Called immediately before the interstitial is to be displayed to the user.
 This method is only used in conjunction with -showInterstitial.
 */
-(void)willDisplayInterstitialForPlacementTag:(NSString *)placementTag
{
    FPANE_DispatchEventWithInfo(TapdaqCtx, kTapdaqLibAdEvent_WILL_DISPLAY, parseAdEventDataToJSONString(TDAdTypeInterstitial, placementTag, NULL));
}

/**
 Called immediately after the interstitial is displayed to the user.
 This method is only used in conjunction with -showInterstitial.
 */
-(void)didDisplayInterstitialForPlacementTag:(NSString *)placementTag
{
    FPANE_DispatchEventWithInfo(TapdaqCtx, kTapdaqLibAdEvent_DID_DISPLAY, parseAdEventDataToJSONString(TDAdTypeInterstitial,placementTag, NULL));
}

/**
 Called when the user closes interstitial, either by tapping the close button, or the background surrounding the interstitial.
 This method is only used in conjunction with -showInterstitial.
 */
-(void)didCloseInterstitialForPlacementTag:(NSString *)placementTag
{
    FPANE_DispatchEventWithInfo(TapdaqCtx, kTapdaqLibAdEvent_DID_CLOSE, parseAdEventDataToJSONString(TDAdTypeInterstitial, placementTag, NULL));
}

/**
 Called when the user clicks the interstitial.
 This method is only used in conjunction with -showInterstitial.
 */
-(void)didClickInterstitialForPlacementTag:(NSString *)placementTag
{
    FPANE_DispatchEventWithInfo(TapdaqCtx, kTapdaqLibAdEvent_DID_CLICK, parseAdEventDataToJSONString(TDAdTypeInterstitial,placementTag, NULL));
}



#pragma mark Video delegate methods

/**
 Called immediately after a video is available to the user for a specific placement tag.
 This method should be used in conjunction with -showVideoForPlacementTag:.
 @param placementTag A placement tag.
 */
- (void)didLoadVideoForPlacementTag:(NSString *)placementTag {
    
    FPANE_DispatchEventWithInfo(TapdaqCtx, kTapdaqLibAdEvent_AD_LOADED, parseAdEventDataToJSONString(TDAdTypeVideo, placementTag, NULL));
}

/**
 Called when, for whatever reason, the video was not able to be loaded.
 Tapdaq will automatically attempt to load a video again with a 1 second delay.
 @param placementTag A placement tag.
 */
- (void)didFailToLoadVideoForPlacementTag:(NSString *)placementTag {
    
    FPANE_DispatchEventWithInfo(TapdaqCtx, kTapdaqLibAdEvent_DID_FAIL_TO_LOAD, parseAdEventDataToJSONString(TDAdTypeVideo, placementTag, @"Failed to load video interstitial"));
}

/**
 Called immediately before the video is to be displayed to the user.
 This method is only used in conjunction with -showVideo.
 */
-(void)willDisplayVideoForPlacementTag:(NSString *)placementTag {

    FPANE_DispatchEventWithInfo(TapdaqCtx, kTapdaqLibAdEvent_WILL_DISPLAY, parseAdEventDataToJSONString(TDAdTypeVideo, placementTag, NULL));
}

/**
 Called immediately after the video is displayed to the user.
 This method is only used in conjunction with -showVideo.
 */
-(void)didDisplayVideoForPlacementTag:(NSString *)placementTag {

    FPANE_DispatchEventWithInfo(TapdaqCtx, kTapdaqLibAdEvent_DID_DISPLAY, parseAdEventDataToJSONString(TDAdTypeVideo, placementTag, NULL));
}

/**
 Called when the user closes video.
 This method is only used in conjunction with -showVideo.
 */
-(void)didCloseVideoForPlacementTag:(NSString *)placementTag {

    FPANE_DispatchEventWithInfo(TapdaqCtx, kTapdaqLibAdEvent_DID_CLOSE, parseAdEventDataToJSONString(TDAdTypeVideo, placementTag, NULL));
}

/**
 Called when the user clicks the video ad.
 This method is only used in conjunction with -showVideo.
 */
-(void)didClickVideoForPlacementTag:(NSString *)placementTag {

    FPANE_DispatchEventWithInfo(TapdaqCtx, kTapdaqLibAdEvent_DID_CLICK, parseAdEventDataToJSONString(TDAdTypeVideo, placementTag, NULL));
}


#pragma mark Rewarded Video delegate methods

/**
 Called immediately after a rewarded video is available to the user for a specific placement tag.
 This method should be used in conjunction with -showRewardedVideoForPlacementTag:.
 @param placementTag A placement tag.
 */
- (void)didLoadRewardedVideoForPlacementTag:(NSString *)placementTag {
    
    FPANE_DispatchEventWithInfo(TapdaqCtx, kTapdaqLibAdEvent_AD_LOADED, parseAdEventDataToJSONString(TDAdTypeRewardedVideo, placementTag, NULL));
}


/**
 Called when, for whatever reason, the rewarded video was not able to be displayed.
 This method is only used in conjunction with -showRewardedVideoForPlacementTag.
 */
- (void)didFailToLoadRewardedVideoForPlacementTag:(NSString *)placementTag {
    
    FPANE_DispatchEventWithInfo(TapdaqCtx, kTapdaqLibAdEvent_DID_FAIL_TO_LOAD, parseAdEventDataToJSONString(TDAdTypeRewardedVideo, placementTag, @"Failed to load rewarded video interstitial"));
}
/**
 Called immediately before the rewarded video is to be displayed to the user.
 */
-(void)willDisplayRewardedVideoForPlacementTag:(NSString *)placementTag {

    FPANE_DispatchEventWithInfo(TapdaqCtx, kTapdaqLibAdEvent_WILL_DISPLAY, parseAdEventDataToJSONString(TDAdTypeRewardedVideo, placementTag, NULL));
}

/**
 Called immediately after the rewarded video is displayed to the user.
 */
-(void)didDisplayRewardedVideoForPlacementTag:(NSString *)placementTag {

    FPANE_DispatchEventWithInfo(TapdaqCtx, kTapdaqLibAdEvent_DID_DISPLAY, parseAdEventDataToJSONString(TDAdTypeRewardedVideo, placementTag, NULL));
}

/**
 Called when the user closes the rewarded video.
 */
-(void)didCloseRewardedVideoForPlacementTag:(NSString *)placementTag
{
    FPANE_DispatchEventWithInfo(TapdaqCtx, kTapdaqLibAdEvent_DID_CLOSE, parseAdEventDataToJSONString(TDAdTypeRewardedVideo, placementTag, NULL));
}

/**
 Called when the user clicks the rewarded video ad.
 */
-(void)didClickRewardedVideoForPlacementTag:(NSString *)placementTag {

    FPANE_DispatchEventWithInfo(TapdaqCtx, kTapdaqLibAdEvent_DID_CLICK, parseAdEventDataToJSONString(TDAdTypeRewardedVideo, placementTag, NULL));
}

/**
 Called when a reward is ready for the user.
 @param rewardName The name of the reward.
 @param rewardAmount The value of the reward.
 */
-(void)rewardValidationSucceededForPlacementTag:(NSString *)placementTag rewardName:(NSString *)rewardName rewardAmount:(int)rewardAmount {

    FPANE_DispatchEventWithInfo(TapdaqCtx, kTapdaqLibAdEvent_DID_VERIFY, parseVerificationDataToJSONString(placementTag, rewardName, rewardAmount));
}

/**
 Called if an error occurred when rewarding the user.
 */
-(void)rewardValidationErroredForPlacementTag:(NSString *)placementTag {

    FPANE_DispatchEventWithInfo(TapdaqCtx, kTapdaqLibAdEvent_DID_REWARD_FAIL, parseAdEventDataToJSONString(TDAdTypeRewardedVideo, placementTag, @"Rewarded video validation errored"));
}

#pragma mark Native advert delegate methods

/**
 Called when a native advert is successfully loaded, used in conjunction with -loadNativeAdvertForPlacementTag:adType:.
 
 @param placementTag The placement tag of the native advert that loaded.
 @param nativeAdType The ad type of the native advert that loaded.
 */
- (void)didLoadNativeAdvertForPlacementTag:(NSString *)placementTag
                                    adType:(TDNativeAdType)nativeAdType {
    
    FPANE_DispatchEventWithInfo(TapdaqCtx, kTapdaqLibAdEvent_AD_LOADED, parseNativeAdEventDataToJSONString(nativeAdType, placementTag, NULL));
}

/**
 Called when the native ad failed to load, used in conjunction with -loadNativeAdvertForPlacementTag:adType:.
 
 @param placementTag The placement tag that failed to load the native ad.
 @param nativeAdType The ad type of the native advert that failed to load.
 */
- (void)didFailToLoadNativeAdvertForPlacementTag:(NSString *)placementTag
                                          adType:(TDNativeAdType)nativeAdType {
    
    FPANE_DispatchEventWithInfo(TapdaqCtx, kTapdaqLibAdEvent_DID_FAIL_TO_LOAD, parseNativeAdEventDataToJSONString(nativeAdType, placementTag, @"Failed to load native advert"));
    
}


//-----------------------------------------------------------------------------------------------------------
#pragma mark Offerwall delegate methods
- (void)didLoadOfferwall {
    [self dispatchOfferwallEvent:TAPDAQ_CALLBACK_EVENT_DID_LOAD withMessage:nil];
}
- (void)didFailToLoadOfferwall {
    [self dispatchOfferwallEvent:TAPDAQ_CALLBACK_EVENT_DID_FAIL_LOAD withMessage:nil];
}

- (void)didDisplayOfferwall {
    [self dispatchOfferwallEvent:TAPDAQ_CALLBACK_EVENT_DID_SHOW withMessage:nil];
}

- (void)didCloseOfferwall {
    [self dispatchOfferwallEvent:TAPDAQ_CALLBACK_EVENT_DID_CLOSE withMessage:nil];
}

- (void)didReceiveOfferwallCredits:(NSDictionary *)creditInfo{
    NSLog(@"Received offerwall credits with processed data: %@",  [self dictionaryToString:creditInfo]);
    [self dispatchOfferwallEvent:TAPDAQ_CALLBACK_EVENT_CUSTOM withMessage:[self dictionaryToString:creditInfo]];
}

- (void)dispatchOfferwallEvent:(const char *)eventName  withMessage:(NSString *)message {
    [TapdaqLib dispatchEvent:eventName withMessage:message withContextType:OfferwallContextType];
}

//-----------------------------------------------------------------------------------------------------------
#pragma mark More Apps delegate methods
- (void)didLoadMoreApps {
    [self dispatchMoreAppsEvent:TAPDAQ_CALLBACK_EVENT_DID_LOAD withMessage:nil];
}

- (void)didFailToLoadMoreApps {
    [self dispatchMoreAppsEvent:TAPDAQ_CALLBACK_EVENT_DID_FAIL_LOAD withMessage:nil];
}

- (void)didDisplayMoreApps {
    [self dispatchMoreAppsEvent:TAPDAQ_CALLBACK_EVENT_DID_SHOW withMessage:nil];
}

- (void)didCloseMoreApps {
    [self dispatchMoreAppsEvent:TAPDAQ_CALLBACK_EVENT_DID_CLOSE withMessage:nil];
}

- (void)dispatchMoreAppsEvent:(const char *)eventName  withMessage:(NSString *)message {
    [TapdaqLib dispatchEvent:eventName withMessage:message withContextType:MoreAppsContextType];
}


#pragma mark Banner
//-----------------------------------------------------------------------------------------------------------
TDMBannerSize getBannerSizeFromString(NSString *bannerSizeString){
    
    if ([bannerSizeString isEqualToString:@"STANDARD"]) {
        return TDMBannerStandard;
    }
    else if ([bannerSizeString isEqualToString:@"LARGE"]) {
        return TDMBannerLarge;
    }
    else if ([bannerSizeString isEqualToString:@"MEDIUM_RECT"]) {
        return TDMBannerMedium;
    }
    else if ([bannerSizeString isEqualToString:@"FULL"]) {
        return TDMBannerFull;
    }
    else if ([bannerSizeString isEqualToString:@"LEADERBOARD"]) {
        return TDMBannerLeaderboard;
    }
    else if ([bannerSizeString isEqualToString:@"SMART"]) {
        UIInterfaceOrientation interfaceOrientation = [[UIApplication sharedApplication] statusBarOrientation];
        if (UIInterfaceOrientationIsLandscape(interfaceOrientation))
        {
            return TDMBannerSmartLandscape;
            
        }
        else
        {
            return TDMBannerSmartPortrait;
        }
    }
    
    return TDMBannerStandard;
}

- (void)didLoadBanner {
    [self dispatchBannerEvent:TAPDAQ_CALLBACK_EVENT_DID_LOAD withMessage:nil];
}

- (void)didFailToLoadBanner {
    [self dispatchBannerEvent:TAPDAQ_CALLBACK_EVENT_DID_FAIL_LOAD withMessage:nil];
}

- (void)didDisplayBanner {
    [self dispatchBannerEvent:TAPDAQ_CALLBACK_EVENT_DID_SHOW withMessage:nil];
}

- (void)didCloseBanner {
    [self dispatchBannerEvent:TAPDAQ_CALLBACK_EVENT_DID_CLOSE withMessage:nil];
}

- (void)didClickBanner {
    [self dispatchBannerEvent:TAPDAQ_CALLBACK_EVENT_DID_CLICK withMessage:nil];
}

- (void)didRefreshBanner {
    [self dispatchBannerEvent:TAPDAQ_CALLBACK_EVENT_DID_REFRESH withMessage:nil];
}



- (void)dispatchBannerEvent:(const char *)eventName  withMessage:(NSString *)message {
    [TapdaqLib dispatchEvent:eventName withMessage:message withContextType:BannerContextType];
}

@end

//-----------------------------------------------------------------------------------------------------------

FREContext GetContextForType(NSString * contextType) {
    if ([contextType isEqualToString: TapdaqContextType]) {
        return TapdaqCtx;
    }
    
    if ([contextType isEqualToString: OfferwallContextType]) {
        return OfferwallCtx;
    }
    
    if ([contextType isEqualToString: MoreAppsContextType]) {
        return MoreAppsCtx;
    }

    if ([contextType isEqualToString: BannerContextType]) {
        return BannerCtx;
    }

    return NULL;
}



#pragma mark - C interface

DEFINE_ANE_FUNCTION(AirTapdaqInit) {
    @try {

        
        NSString* applicationId = FPANE_FREObjectToNSString(argv[0]);
        NSString* clientKey = FPANE_FREObjectToNSString(argv[1]);
        NSString* placementsString = FPANE_FREObjectToNSString(argv[3]);
        NSArray *placementTags = parsePlacementsJSONString(placementsString);
        NSString* pluginVersion = [@"air_" stringByAppendingString : FPANE_FREObjectToNSString(argv[6])];
        BOOL debugMode = FPANE_FREObjectToBool(argv[7]);

        [[Tapdaq sharedSession] setDelegate:[ TapdaqLib sharedInstance]];
        TDProperties *properties = [TDProperties defaultProperties];
        
        if (debugMode) {
            properties.logLevel = TDLogLevelDebug;
        }else {
            properties.logLevel = TDLogLevelInfo;
        }
        [properties setIsDebugEnabled:debugMode];
        
        NSArray *testDevices = getTestDevicesFromJSON(FPANE_FREObjectToNSString(argv[5]));
        //test devices
        for (NSDictionary *testDevicesDictionary in testDevices ) {
            NSArray *testDevices = [testDevicesDictionary valueForKey:@"testDevices"];
            if (testDevices.count > 0) {
                NSLog(@"found test device %@ ",testDevicesDictionary);
                TDTestDevices *tapdaqTestDevices = [[TDTestDevices alloc] initWithNetwork:[testDevicesDictionary valueForKey:@"name" ]                                                                            testDevices:testDevices];
                [properties registerTestDevices:tapdaqTestDevices];
            }
        }
        
        for (TDPlacement *placement in placementTags) {
            [properties registerPlacement:placement];
        }

        [properties setPluginVersion : pluginVersion];
        NSLog(@"PluginVersion %@",pluginVersion);

        

        [[Tapdaq sharedSession] setApplicationId:applicationId clientKey:clientKey properties:properties];
        [[Tapdaq sharedSession] launch];
    }
    @catch (NSException *exception) {
        FPANE_DispatchEventWithInfo(context, @"LOGGING", [@"Exception occured while initialising Tapdaq : " stringByAppendingString:exception.reason]);
    }
    return NULL;
}

DEFINE_ANE_FUNCTION(AirTapdaqLoadInterstitial) {
    @try {
        NSString* placementTag = FPANE_FREObjectToNSString(argv[0]);
        NSString* adTypeString = FPANE_FREObjectToNSString(argv[1]);
        TDAdTypes adType = parseAdTypeString(adTypeString);
        
        if (adType == TDAdTypeInterstitial) {
            if ([placementTag isEqualToString:@""]) {
                [[Tapdaq sharedSession] loadInterstitial];
            } else {
                [[Tapdaq sharedSession] loadInterstitialForPlacementTag:placementTag];
            }
        } else if (adType == TDAdTypeVideo) {
            if ([placementTag isEqualToString:@""]) {
                [[Tapdaq sharedSession] loadVideo];
            } else {
                [[Tapdaq sharedSession] loadVideoForPlacementTag:placementTag];
            }
        } else if (adType == TDAdTypeRewardedVideo) {
            if ([placementTag isEqualToString:@""]) {
                [[Tapdaq sharedSession] loadRewardedVideo];
            } else {
                [[Tapdaq sharedSession] loadRewardedVideoForPlacementTag:placementTag];
            }
        }
    }@catch (NSException *exception) {
        FPANE_DispatchEventWithInfo(context, @"LOGGING", [@"Exception occured while trying to load interstitial: " stringByAppendingString:exception.reason]);
    }
    return NULL;
}

DEFINE_ANE_FUNCTION(AirTapdaqShowInterstitial) {
    
    @try {
        
        NSString* placementTag = FPANE_FREObjectToNSString(argv[0]);
        NSString* adTypeString = FPANE_FREObjectToNSString(argv[1]);
        TDAdTypes adType = parseAdTypeString(adTypeString);
        
        if (adType == TDAdTypeInterstitial) {
            if ([placementTag isEqualToString:@""]) {
                if ([[Tapdaq sharedSession] isInterstitialReady]) {
                    [[Tapdaq sharedSession] showInterstitial];
                } else {
                    FPANE_DispatchEventWithInfo(context, kTapdaqLibAdEvent_NOT_AVAILABLE, parseAdEventDataToJSONString(TDAdTypeInterstitial, placementTag, NULL));
                }
                
            } else {
                if ([[Tapdaq sharedSession] isInterstitialReadyForPlacementTag:placementTag]) {
                    [[Tapdaq sharedSession] showInterstitialForPlacementTag:placementTag];
                } else {
                    FPANE_DispatchEventWithInfo(context, kTapdaqLibAdEvent_NOT_AVAILABLE, parseAdEventDataToJSONString(TDAdTypeInterstitial, placementTag, NULL));
                }
            }
            
        } else if (adType == TDAdTypeVideo) {
            if ([placementTag isEqualToString:@""]) {
                if ([[Tapdaq sharedSession] isVideoReady]) {
                    [[Tapdaq sharedSession] showVideo];
                } else {
                    FPANE_DispatchEventWithInfo(context, kTapdaqLibAdEvent_NOT_AVAILABLE, parseAdEventDataToJSONString(TDAdTypeVideo, placementTag, NULL));
                }
            } else {
                if ([[Tapdaq sharedSession] isVideoReadyForPlacementTag:placementTag]) {
                    [[Tapdaq sharedSession] showVideoForPlacementTag:placementTag];
                } else {
                    FPANE_DispatchEventWithInfo(context, kTapdaqLibAdEvent_NOT_AVAILABLE, parseAdEventDataToJSONString(TDAdTypeVideo, placementTag, NULL));
                }
                
            }
            
            
        } else if (adType == TDAdTypeRewardedVideo) {
            if ([placementTag isEqualToString:@""]) {
                if ([[Tapdaq sharedSession] isRewardedVideoReady]) {
                    [[Tapdaq sharedSession] showRewardedVideo];
                } else {
                    FPANE_DispatchEventWithInfo(context, kTapdaqLibAdEvent_NOT_AVAILABLE, parseAdEventDataToJSONString(TDAdTypeRewardedVideo, placementTag, NULL));
                }
                
            } else {
                if ([[Tapdaq sharedSession] isRewardedVideoReadyForPlacementTag:placementTag]) {
                    [[Tapdaq sharedSession] showRewardedVideoForPlacementTag:placementTag];
                } else {
                    FPANE_DispatchEventWithInfo(context, kTapdaqLibAdEvent_NOT_AVAILABLE, parseAdEventDataToJSONString(TDAdTypeRewardedVideo, placementTag, NULL));
                }
            }
        }

    }
    @catch (NSException *exception) {
        FPANE_DispatchEventWithInfo(context, @"LOGGING", [@"Exception occured while trying to show interstitial: " stringByAppendingString:exception.reason]);
    }
    return NULL;
}

DEFINE_ANE_FUNCTION(AirTapdaqLoadNativeAd) {
    
    @try {
        
        NSString* nativeAdTypeString = FPANE_FREObjectToNSString(argv[0]);
        TDNativeAdType nativeAdType = parseNativeAdTypeTypeString(nativeAdTypeString);
        NSString* placementTag = FPANE_FREObjectToNSString(argv[1]);
        
        if ([TapdaqLib sharedInstance].nativeAdsByCreativeTypePlacecementTag == NULL) {
            [TapdaqLib sharedInstance].nativeAdsByCreativeTypePlacecementTag = [[NSMutableDictionary alloc]init];
        }
        
        [[Tapdaq sharedSession] loadNativeAdvertForPlacementTag:placementTag
                                                         adType:nativeAdType];
        
    }
    @catch (NSException *exception) {
        FPANE_DispatchEventWithInfo(TapdaqCtx, @"LOGGING", [@"Exception occured while trying to fetch native ad: " stringByAppendingString:exception.reason]);
    }
    
    
    return NULL;
}

DEFINE_ANE_FUNCTION(AirTapdaqGetNativeAd) {
    
    @try {
        
        NSString* nativeAdTypeString = FPANE_FREObjectToNSString(argv[0]);
        TDNativeAdType nativeAdType = parseNativeAdTypeTypeString(nativeAdTypeString);
        NSString* placementTag = FPANE_FREObjectToNSString(argv[1]);
        
        TDNativeAdvert *nativeAdvert = [[Tapdaq sharedSession] getNativeAdvertForPlacementTag:placementTag adType:nativeAdType];
        if (nativeAdvert == NULL) {
            FPANE_DispatchEventWithInfo(TapdaqCtx, kTapdaqLibAdEvent_NOT_AVAILABLE, parseNativeAdEventDataToJSONString(nativeAdType, placementTag, NULL));
            return NULL;
        }

        NSString *uniqueId = [NSString stringWithFormat:@"%@-%@", parseNativeAdTypeToString(nativeAdvert.adType), nativeAdvert.subscriptionId];
        [[TapdaqLib sharedInstance].nativeAdsByCreativeTypePlacecementTag setValue:nativeAdvert forKey:uniqueId];
        NSString *adDataString = parseNativeAdToJSONString(nativeAdvert, uniqueId);
        FPANE_DispatchEventWithInfo(TapdaqCtx, kTapdaqLibNativeAdDataEvent_AD_DATA, adDataString);
    }
    @catch (NSException *exception) {
        FPANE_DispatchEventWithInfo(TapdaqCtx, @"LOGGING", [@"Exception occured while trying to get native ad: " stringByAppendingString:exception.reason]);
    }
    
    
    return NULL;
}

DEFINE_ANE_FUNCTION(AirTapdaqTriggerClick) {
    @try {
        NSLog(@"Trigger click");
        NSString* uniqueId = FPANE_FREObjectToNSString(argv[0]);
        TDNativeAdvert *nativeAdvert = [[TapdaqLib sharedInstance].nativeAdsByCreativeTypePlacecementTag valueForKey:uniqueId];
        [nativeAdvert triggerClick];
    } @catch (NSException *exception) {
        FPANE_DispatchEventWithInfo(TapdaqCtx, @"LOGGING", [@"Exception occured while trying to trigger click on native ad: " stringByAppendingString:exception.reason]);
    }
    
    return NULL;
}

DEFINE_ANE_FUNCTION(AirTapdaqTriggerDisplay) {
    @try {
        NSLog(@"Trigger display");
        NSString* uniqueId = FPANE_FREObjectToNSString(argv[0]);
        TDNativeAdvert *nativeAdvert = [[TapdaqLib sharedInstance].nativeAdsByCreativeTypePlacecementTag valueForKey:uniqueId];
        [nativeAdvert triggerImpression];
    }
    @catch (NSException *exception) {
        FPANE_DispatchEventWithInfo(TapdaqCtx, @"LOGGING", [@"Exception occured while trying to trigger display on native ad: " stringByAppendingString:exception.reason]);
    }
    
    return NULL;
}

DEFINE_ANE_FUNCTION(AirTapdaqStartTestActivity) {
    
    @try {
        NSLog(@"starting debugger...");
        [[Tapdaq sharedSession] presentDebugViewController];
        
    }
    @catch (NSException *exception) {
        FPANE_DispatchEventWithInfo(TapdaqCtx, @"LOGGING", [@"Exception occured while trying to start debugger: " stringByAppendingString:exception.reason]);
    }
    
    return NULL;
}

//-----------------------------------------------------------------------------------------------------------

DEFINE_ANE_FUNCTION(TapdaqLoadOfferwall){
    [[Tapdaq sharedSession] loadOfferwall];
    return NULL;
}

DEFINE_ANE_FUNCTION(TapdaqIsOfferwallAvailable){
    BOOL available = [[Tapdaq sharedSession] isOfferwallReady];

    FREObject object;
    if (FRENewObjectFromBool(available, &object) != FRE_OK) {
        NSLog(@"Offerwall isn't available");
        return NULL;
    }

    return object;
}

DEFINE_ANE_FUNCTION(TapdaqShowOfferwall){
    [[Tapdaq sharedSession] showOfferwall];
    return NULL;
}

//-----------------------------------------------------------------------------------------------------------
DEFINE_ANE_FUNCTION(TapdaqLoadMoreApps){
    TDMoreAppsConfig *moreAppsConfig = [[TDMoreAppsConfig alloc] init];
    
    moreAppsConfig.headerText = [FREConversionUtil toString:[FREConversionUtil getProperty:@"headerText" fromObject:argv[0]]];
    moreAppsConfig.headerTextColor = UIColorFromRGB([FREConversionUtil toUInt:[FREConversionUtil getProperty:@"headerTextColor" fromObject:argv[0]]]);
    moreAppsConfig.headerColor = UIColorFromRGB([FREConversionUtil toUInt:[FREConversionUtil getProperty:@"headerColor" fromObject:argv[0]]]);
    moreAppsConfig.headerCloseButtonColor = UIColorFromRGB([FREConversionUtil toUInt:[FREConversionUtil getProperty:@"headerCloseButtonColor" fromObject:argv[0]]]);
    moreAppsConfig.backgroundColor = UIColorFromRGB([FREConversionUtil toUInt:[FREConversionUtil getProperty:@"backgroundColor" fromObject:argv[0]]]);
    
    moreAppsConfig.appNameColor = UIColorFromRGB([FREConversionUtil toUInt:[FREConversionUtil getProperty:@"appNameColor" fromObject:argv[0]]]);
    moreAppsConfig.appButtonColor = UIColorFromRGB([FREConversionUtil toUInt:[FREConversionUtil getProperty:@"appButtonColor" fromObject:argv[0]]]);
    moreAppsConfig.appButtonTextColor = UIColorFromRGB([FREConversionUtil toUInt:[FREConversionUtil getProperty:@"appButtonTextColor" fromObject:argv[0]]]);
    
    moreAppsConfig.installedAppButtonText = [FREConversionUtil toString:[FREConversionUtil getProperty:@"installedButtonText" fromObject:argv[0]]];
    moreAppsConfig.installedAppButtonColor = UIColorFromRGB([FREConversionUtil toUInt:[FREConversionUtil getProperty:@"installedButtonColor" fromObject:argv[0]]]);
    moreAppsConfig.installedAppButtonTextColor = UIColorFromRGB([FREConversionUtil toUInt:[FREConversionUtil getProperty:@"installedButtonTextColor" fromObject:argv[0]]]);
    
    [[Tapdaq sharedSession] loadMoreAppsWithConfig: moreAppsConfig];
    return NULL;
}

DEFINE_ANE_FUNCTION(TapdaqIsMoreAppsAvailable){
    BOOL available = [[Tapdaq sharedSession] isMoreAppsReady];
    
    FREObject object;
    if (FRENewObjectFromBool(available, &object) != FRE_OK) {
        NSLog(@"More Apps isn't available");
        return NULL;
    }
    
    return object;
}

DEFINE_ANE_FUNCTION(TapdaqShowMoreApps){
    [[Tapdaq sharedSession] showMoreApps];
    return NULL;
}

#pragma mark Banner
//-----------------------------------------------------------------------------------------------------------
DEFINE_ANE_FUNCTION(TapdaqLoadBanner){
    
    @try {
        NSString* bannerSizeString = [FREConversionUtil toString:argv[0]];
        NSLog(@"Banner size string : %@ ", bannerSizeString);
        TDMBannerSize bannerSize = getBannerSizeFromString(bannerSizeString);
        [[Tapdaq sharedSession] loadBanner:bannerSize];
    }
    @catch (NSException *exception) {
        NSLog(@"No banner size specified, cannot load banner");
    }
    
    return NULL;
}

DEFINE_ANE_FUNCTION(TapdaqIsBannerAvailable){
    BOOL available = [TapdaqLib sharedInstance].bannerView != NULL;
    
    FREObject object;
    if (FRENewObjectFromBool(available, &object) != FRE_OK) {
        NSLog(@"Tapdaq banner checking availability problem");
        return NULL;
    }
    
    return object;
}


DEFINE_ANE_FUNCTION(TapdaqShowBanner){
    @try {
        
        UIView *bannerView = [[Tapdaq sharedSession] getBanner];
        if (bannerView == nil) {
            NSLog(@"Banner isn't available");
            return NULL;
        }
    
        NSString* bannerPositionString = [FREConversionUtil toString:argv[0]];
        
        UIWindow *currentWindow = [UIApplication sharedApplication].keyWindow;
        [currentWindow addSubview:bannerView];
        bannerView.translatesAutoresizingMaskIntoConstraints = false;
        
        CGSize bannerSize = bannerView.frame.size;
        NSLog(@"Banner size : %f,%f", bannerSize.width, bannerSize.height);
        
        BOOL isTop = [[bannerPositionString lowercaseString] isEqualToString:@"top"];
        UILayoutGuide *layoutGuide;
        
           if (SYSTEM_VERSION_GREATER_THAN_OR_EQUAL_TO(@"11.0")) {
               layoutGuide = currentWindow.safeAreaLayoutGuide;
            } else {
                layoutGuide = currentWindow.layoutMarginsGuide;
            }
        
        NSLayoutConstraint *constraintYAnchor = [isTop ? bannerView.topAnchor : bannerView.bottomAnchor constraintEqualToAnchor:isTop ? layoutGuide.topAnchor : layoutGuide.bottomAnchor];
        
        NSArray *horizontalConstraints = [NSLayoutConstraint constraintsWithVisualFormat:@"H:|->=0-[bannerView(bannerWidth)]->=0-|" options:0 metrics:@{@"bannerWidth" : @(CGRectGetWidth(bannerView.frame))} views:@{ @"bannerView" : bannerView }];
        NSLayoutConstraint *constraintHeight = [NSLayoutConstraint constraintWithItem:bannerView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeHeight multiplier:1 constant:bannerSize.height];
        NSLayoutConstraint *constraintCenterX = [NSLayoutConstraint constraintWithItem:bannerView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:bannerView.superview attribute:NSLayoutAttributeCenterX multiplier:1 constant:0];
        
        NSArray *aggregateConstraints = [horizontalConstraints arrayByAddingObjectsFromArray:@[ constraintYAnchor, constraintHeight, constraintCenterX ]];
        [currentWindow addConstraints:aggregateConstraints];
        
        [TapdaqLib sharedInstance].constraintsBanner = aggregateConstraints;
        [TapdaqLib sharedInstance].bannerView = bannerView;
        
    } @catch (NSException *exception) {
            NSLog(@"Problem with showing banner");
        }
        
        return NULL;
}

DEFINE_ANE_FUNCTION(TapdaqHideBanner){
    @try {
        if ([TapdaqLib sharedInstance].bannerView == nil) {
            NSLog(@"Nothing to hide, there is no banner");
            return NULL;
        }
        
        for (NSLayoutConstraint *constraint in [TapdaqLib sharedInstance].constraintsBanner) {
            [constraint setActive:false];
        }

        [TapdaqLib sharedInstance].constraintsBanner = nil;
        [[TapdaqLib sharedInstance].bannerView removeFromSuperview];
        [TapdaqLib sharedInstance].bannerView = nil;
    } @catch (NSException *exception) {
        NSLog(@"Problem with hiding banner");
    }
    
    return NULL;
}





#pragma mark Context
//-----------------------------------------------------------------------------------------------------------

void ContextInitializer(void* extData, const uint8_t* ctxType, FREContext ctx, uint32_t* numFunctionsToTest, const FRENamedFunction** functionsToSet) {
    NSString *contextType = [NSString stringWithUTF8String: (char *)ctxType];
    
    NSLog(@"Initializing context type %@",  contextType);
    
    if ([contextType isEqualToString: TapdaqContextType]) {
        TapdaqCtx = ctx;
    
        NSLog(@"We are in tapdaq functions setup!!!");
        static FRENamedFunction functions[]= (FRENamedFunction[]){
            MAP_FUNCTION(AirTapdaqInit, NULL),
            MAP_FUNCTION(AirTapdaqLoadInterstitial, NULL),
            MAP_FUNCTION(AirTapdaqShowInterstitial, NULL),
            MAP_FUNCTION(AirTapdaqLoadNativeAd, NULL),
            MAP_FUNCTION(AirTapdaqGetNativeAd, NULL),
            MAP_FUNCTION(AirTapdaqTriggerClick, NULL),
            MAP_FUNCTION(AirTapdaqTriggerDisplay, NULL),
            MAP_FUNCTION(AirTapdaqStartTestActivity, NULL),
        };
        *numFunctionsToTest = sizeof(functions) / sizeof(FRENamedFunction);
        *functionsToSet = functions;
    }
    
    if ([contextType isEqualToString: OfferwallContextType]) {
        OfferwallCtx = ctx;

        int i = 0;
        *numFunctionsToTest = 3;
        FRENamedFunction* func = (FRENamedFunction*) malloc(sizeof(FRENamedFunction) * (*numFunctionsToTest));
        func[i].name = (const uint8_t*)"load";
        func[i].functionData = NULL;
        func[i].function = &TapdaqLoadOfferwall;
        
        i++;
        func[i].name = (const uint8_t*)"available";
        func[i].functionData = NULL;
        func[i].function = &TapdaqIsOfferwallAvailable;
        
        i++;
        func[i].name = (const uint8_t*)"show";
        func[i].functionData = NULL;
        func[i].function = &TapdaqShowOfferwall;
        
        *functionsToSet = func;
    }
    
    if ([contextType isEqualToString: MoreAppsContextType]) {
        MoreAppsCtx = ctx;
        
        int i = 0;
        *numFunctionsToTest = 3;
        FRENamedFunction* func = (FRENamedFunction*) malloc(sizeof(FRENamedFunction) * (*numFunctionsToTest));
        func[i].name = (const uint8_t*)"load";
        func[i].functionData = NULL;
        func[i].function = &TapdaqLoadMoreApps;
        
        i++;
        func[i].name = (const uint8_t*)"available";
        func[i].functionData = NULL;
        func[i].function = &TapdaqIsMoreAppsAvailable;
        
        i++;
        func[i].name = (const uint8_t*)"show";
        func[i].functionData = NULL;
        func[i].function = &TapdaqShowMoreApps;
        
        *functionsToSet = func;
    }
    
    if ([contextType isEqualToString: BannerContextType]) {
        BannerCtx = ctx;
        
        int i = 0;
        *numFunctionsToTest = 4;
        FRENamedFunction* func = (FRENamedFunction*) malloc(sizeof(FRENamedFunction) * (*numFunctionsToTest));
        func[i].name = (const uint8_t*)"load";
        func[i].functionData = NULL;
        func[i].function = &TapdaqLoadBanner;
        
        i++;
        func[i].name = (const uint8_t*)"available";
        func[i].functionData = NULL;
        func[i].function = &TapdaqIsBannerAvailable;
        
        i++;
        func[i].name = (const uint8_t*)"show";
        func[i].functionData = NULL;
        func[i].function = &TapdaqShowBanner;

        i++;
        func[i].name = (const uint8_t*)"hide";
        func[i].functionData = NULL;
        func[i].function = &TapdaqHideBanner;

        *functionsToSet = func;
    }

}

void ContextFinalizer(FREContext ctx) {
    
}

void ExtensionInitializer(void** extDataToSet, FREContextInitializer* ctxInitializerToSet, FREContextFinalizer* ctxFinalizerToSet) {
 
    *extDataToSet = NULL;
    *ctxInitializerToSet = &ContextInitializer;
    *ctxFinalizerToSet = &ContextFinalizer;
}

void ExtensionFinalizer(void *extData) {
    
}
