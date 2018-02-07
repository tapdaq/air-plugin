#import <Foundation/Foundation.h>
#import "FlashRuntimeExtensions.h"

void TapdaqInMobiContextInitializer(void* extData, const uint8_t* ctxType, FREContext ctx, uint32_t* numFunctionsToSet, const FRENamedFunction** functionsToSet) {
    static FRENamedFunction functionMap[] = {};
    *numFunctionsToSet = sizeof(functionMap) / sizeof(FRENamedFunction);
    *functionsToSet = functionMap;
}
void TapdaqInMobiContextFinalizer(FREContext ctx) {
    return;
}
void TapdaqInMobiExtensionInitializer(void** extDataToSet, FREContextInitializer* ctxInitializerToSet, FREContextFinalizer* ctxFinalizerToSet) {
    *extDataToSet = NULL;
    *ctxInitializerToSet = &TapdaqInMobiContextInitializer;
    *ctxFinalizerToSet = &TapdaqInMobiContextFinalizer;
}
void TapdaqInMobiExtensionFinalizer(void* extData) {
    return;
}
