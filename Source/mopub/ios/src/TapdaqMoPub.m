#import <Foundation/Foundation.h>
#import "FlashRuntimeExtensions.h"

void TapdaqMoPubContextInitializer(void* extData, const uint8_t* ctxType, FREContext ctx, uint32_t* numFunctionsToSet, const FRENamedFunction** functionsToSet) {
    static FRENamedFunction functionMap[] = {};
    *numFunctionsToSet = sizeof(functionMap) / sizeof(FRENamedFunction);
    *functionsToSet = functionMap;
}
void TapdaqMoPubContextFinalizer(FREContext ctx) {
    return;
}
void TapdaqMoPubExtensionInitializer(void** extDataToSet, FREContextInitializer* ctxInitializerToSet, FREContextFinalizer* ctxFinalizerToSet) {
    *extDataToSet = NULL;
    *ctxInitializerToSet = &TapdaqMoPubContextInitializer;
    *ctxFinalizerToSet = &TapdaqMoPubContextFinalizer;
}
void TapdaqMoPubExtensionFinalizer(void* extData) {
    return;
}
