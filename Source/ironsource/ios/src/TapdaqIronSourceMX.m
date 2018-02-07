#import <Foundation/Foundation.h>
#import "FlashRuntimeExtensions.h"

void TapdaqIronSourceContextInitializer(void* extData, const uint8_t* ctxType, FREContext ctx, uint32_t* numFunctionsToSet, const FRENamedFunction** functionsToSet) {
    static FRENamedFunction functionMap[] = {};
    *numFunctionsToSet = sizeof(functionMap) / sizeof(FRENamedFunction);
    *functionsToSet = functionMap;
}
void TapdaqIronSourceContextFinalizer(FREContext ctx) {
    return;
}
void TapdaqIronSourceExtensionInitializer(void** extDataToSet, FREContextInitializer* ctxInitializerToSet, FREContextFinalizer* ctxFinalizerToSet) {
    *extDataToSet = NULL;
    *ctxInitializerToSet = &TapdaqIronSourceContextInitializer;
    *ctxFinalizerToSet = &TapdaqIronSourceContextFinalizer;
}
void TapdaqIronSourceExtensionFinalizer(void* extData) {
    return;
}
