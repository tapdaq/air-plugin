#import <Foundation/Foundation.h>
#import "FlashRuntimeExtensions.h"

void TapdaqVungleContextInitializer(void* extData, const uint8_t* ctxType, FREContext ctx, uint32_t* numFunctionsToSet, const FRENamedFunction** functionsToSet) {
    static FRENamedFunction functionMap[] = {};
    *numFunctionsToSet = sizeof(functionMap) / sizeof(FRENamedFunction);
    *functionsToSet = functionMap;
}
void TapdaqVungleContextFinalizer(FREContext ctx) {
    return;
}
void TapdaqVungleExtensionInitializer(void** extDataToSet, FREContextInitializer* ctxInitializerToSet, FREContextFinalizer* ctxFinalizerToSet) {
    *extDataToSet = NULL;
    *ctxInitializerToSet = &TapdaqVungleContextInitializer;
    *ctxFinalizerToSet = &TapdaqVungleContextFinalizer;
}
void TapdaqVungleExtensionFinalizer(void* extData) {
    return;
}
