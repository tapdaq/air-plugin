#import <Foundation/Foundation.h>
#import "FlashRuntimeExtensions.h"

void TapdaqReceptivContextInitializer(void* extData, const uint8_t* ctxType, FREContext ctx, uint32_t* numFunctionsToSet, const FRENamedFunction** functionsToSet) {
    static FRENamedFunction functionMap[] = {};
    *numFunctionsToSet = sizeof(functionMap) / sizeof(FRENamedFunction);
    *functionsToSet = functionMap;
}
void TapdaqReceptivContextFinalizer(FREContext ctx) {
    return;
}
void TapdaqReceptivExtensionInitializer(void** extDataToSet, FREContextInitializer* ctxInitializerToSet, FREContextFinalizer* ctxFinalizerToSet) {
    *extDataToSet = NULL;
    *ctxInitializerToSet = &TapdaqReceptivContextInitializer;
    *ctxFinalizerToSet = &TapdaqReceptivContextFinalizer;
}
void TapdaqReceptivExtensionFinalizer(void* extData) {
    return;
}
