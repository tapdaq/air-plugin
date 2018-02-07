#import <Foundation/Foundation.h>
#import "FlashRuntimeExtensions.h"

void TapdaqFANContextInitializer(void* extData, const uint8_t* ctxType, FREContext ctx, uint32_t* numFunctionsToSet, const FRENamedFunction** functionsToSet) {
    static FRENamedFunction functionMap[] = {};
    *numFunctionsToSet = sizeof(functionMap) / sizeof(FRENamedFunction);
    *functionsToSet = functionMap;
}
void TapdaqFANContextFinalizer(FREContext ctx) {
    return;
}
void TapdaqFANExtensionInitializer(void** extDataToSet, FREContextInitializer* ctxInitializerToSet, FREContextFinalizer* ctxFinalizerToSet) {
    *extDataToSet = NULL;
    *ctxInitializerToSet = &TapdaqFANContextInitializer;
    *ctxFinalizerToSet = &TapdaqFANContextFinalizer;
}
void TapdaqFANExtensionFinalizer(void* extData) {
    return;
}
