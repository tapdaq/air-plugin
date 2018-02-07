#import <Foundation/Foundation.h>
#import "FlashRuntimeExtensions.h"

void TapdaqHyprMXContextInitializer(void* extData, const uint8_t* ctxType, FREContext ctx, uint32_t* numFunctionsToSet, const FRENamedFunction** functionsToSet) {
    static FRENamedFunction functionMap[] = {};
    *numFunctionsToSet = sizeof(functionMap) / sizeof(FRENamedFunction);
    *functionsToSet = functionMap;
}
void TapdaqHyprMXContextFinalizer(FREContext ctx) {
    return;
}
void TapdaqHyprMXExtensionInitializer(void** extDataToSet, FREContextInitializer* ctxInitializerToSet, FREContextFinalizer* ctxFinalizerToSet) {
    *extDataToSet = NULL;
    *ctxInitializerToSet = &TapdaqHyprMXContextInitializer;
    *ctxFinalizerToSet = &TapdaqHyprMXContextFinalizer;
}
void TapdaqHyprMXExtensionFinalizer(void* extData) {
    return;
}
