#import "TapdaqAdMob.h"

void TapdaqAdMobContextInitializer(void* extData, const uint8_t* ctxType, FREContext ctx, uint32_t* numFunctionsToSet, const FRENamedFunction** functionsToSet) {
    static FRENamedFunction functionMap[] = {};
    *numFunctionsToSet = sizeof(functionMap) / sizeof(FRENamedFunction);
    *functionsToSet = functionMap;
}
void TapdaqAdMobContextFinalizer(FREContext ctx) {
    return;
}
void TapdaqAdMobExtensionInitializer(void** extDataToSet, FREContextInitializer* ctxInitializerToSet, FREContextFinalizer* ctxFinalizerToSet) {
    *extDataToSet = NULL;
    *ctxInitializerToSet = &TapdaqAdMobContextInitializer;
    *ctxFinalizerToSet = &TapdaqAdMobContextFinalizer;
}
void TapdaqAdMobExtensionFinalizer(void* extData) {
    return;
}
