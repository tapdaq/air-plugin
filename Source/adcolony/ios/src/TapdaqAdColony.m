#import <Foundation/Foundation.h>
#import "FlashRuntimeExtensions.h"

void TapdaqAdColonyContextInitializer(void* extData, const uint8_t* ctxType, FREContext ctx, uint32_t* numFunctionsToSet, const FRENamedFunction** functionsToSet) {
    static FRENamedFunction functionMap[] = {};
    *numFunctionsToSet = sizeof(functionMap) / sizeof(FRENamedFunction);
    *functionsToSet = functionMap;
}
void TapdaqAdColonyContextFinalizer(FREContext ctx) {
    return;
}
void TapdaqAdColonyExtensionInitializer(void** extDataToSet, FREContextInitializer* ctxInitializerToSet, FREContextFinalizer* ctxFinalizerToSet) {
    *extDataToSet = NULL;
    *ctxInitializerToSet = &TapdaqAdColonyContextInitializer;
    *ctxFinalizerToSet = &TapdaqAdColonyContextFinalizer;
}
void TapdaqAdColonyExtensionFinalizer(void* extData) {
    return;
}
