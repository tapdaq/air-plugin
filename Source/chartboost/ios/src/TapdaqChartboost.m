#import <Foundation/Foundation.h>
#import "FlashRuntimeExtensions.h"

void TapdaqChartboostContextInitializer(void* extData, const uint8_t* ctxType, FREContext ctx, uint32_t* numFunctionsToSet, const FRENamedFunction** functionsToSet) {
    static FRENamedFunction functionMap[] = {};
    *numFunctionsToSet = sizeof(functionMap) / sizeof(FRENamedFunction);
    *functionsToSet = functionMap;
}
void TapdaqChartboostContextFinalizer(FREContext ctx) {
    return;
}
void TapdaqChartboostExtensionInitializer(void** extDataToSet, FREContextInitializer* ctxInitializerToSet, FREContextFinalizer* ctxFinalizerToSet) {
    *extDataToSet = NULL;
    *ctxInitializerToSet = &TapdaqChartboostContextInitializer;
    *ctxFinalizerToSet = &TapdaqChartboostContextFinalizer;
}
void TapdaqChartboostExtensionFinalizer(void* extData) {
    return;
}
