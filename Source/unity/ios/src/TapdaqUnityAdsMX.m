#import <Foundation/Foundation.h>
#import "FlashRuntimeExtensions.h"

void TapdaqUnityAdsContextInitializer(void* extData, const uint8_t* ctxType, FREContext ctx, uint32_t* numFunctionsToSet, const FRENamedFunction** functionsToSet) {
    static FRENamedFunction functionMap[] = {};
    *numFunctionsToSet = sizeof(functionMap) / sizeof(FRENamedFunction);
    *functionsToSet = functionMap;
}
void TapdaqUnityAdsContextFinalizer(FREContext ctx) {
    return;
}
void TapdaqUnityAdsExtensionInitializer(void** extDataToSet, FREContextInitializer* ctxInitializerToSet, FREContextFinalizer* ctxFinalizerToSet) {
    *extDataToSet = NULL;
    *ctxInitializerToSet = &TapdaqUnityAdsContextInitializer;
    *ctxFinalizerToSet = &TapdaqUnityAdsContextFinalizer;
}
void TapdaqUnityAdsExtensionFinalizer(void* extData) {
    return;
}
