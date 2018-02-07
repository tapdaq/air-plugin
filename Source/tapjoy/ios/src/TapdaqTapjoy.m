#import <Foundation/Foundation.h>
#import "FlashRuntimeExtensions.h"

void TapdaqTapjoyContextInitializer(void* extData, const uint8_t* ctxType, FREContext ctx, uint32_t* numFunctionsToSet, const FRENamedFunction** functionsToSet) {
    static FRENamedFunction functionMap[] = {};
    *numFunctionsToSet = sizeof(functionMap) / sizeof(FRENamedFunction);
    *functionsToSet = functionMap;
}
void TapdaqTapjoyContextFinalizer(FREContext ctx) {
    return;
}
void TapdaqTapjoyExtensionInitializer(void** extDataToSet, FREContextInitializer* ctxInitializerToSet, FREContextFinalizer* ctxFinalizerToSet) {
    *extDataToSet = NULL;
    *ctxInitializerToSet = &TapdaqTapjoyContextInitializer;
    *ctxFinalizerToSet = &TapdaqTapjoyContextFinalizer;
}
void TapdaqTapjoyExtensionFinalizer(void* extData) {
    return;
}
