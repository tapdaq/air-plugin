#import <Foundation/Foundation.h>
#import "FlashRuntimeExtensions.h"

void TapdaqAppLovinContextInitializer(void* extData, const uint8_t* ctxType, FREContext ctx, uint32_t* numFunctionsToSet, const FRENamedFunction** functionsToSet) {
    static FRENamedFunction functionMap[] = {};
    *numFunctionsToSet = sizeof(functionMap) / sizeof(FRENamedFunction);
    *functionsToSet = functionMap;
}
void TapdaqAppLovinContextFinalizer(FREContext ctx) {
    return;
}
void TapdaqAppLovinExtensionInitializer(void** extDataToSet, FREContextInitializer* ctxInitializerToSet, FREContextFinalizer* ctxFinalizerToSet) {
    *extDataToSet = NULL;
    *ctxInitializerToSet = &TapdaqAppLovinContextInitializer;
    *ctxFinalizerToSet = &TapdaqAppLovinContextFinalizer;
}
void TapdaqAppLovinExtensionFinalizer(void* extData) {
    return;
}
