#import <Foundation/Foundation.h>
#import "FlashRuntimeExtensions.h"

void TapdaqAdMobContextInitializer(void* extData, const uint8_t* ctxType, FREContext ctx, uint32_t* numFunctionsToSet, const FRENamedFunction** functionsToSet);
void TapdaqAdMobContextFinalizer(FREContext ctx);
void TapdaqAdMobExtensionInitializer(void** extDataToSet, FREContextInitializer* ctxInitializerToSet, FREContextFinalizer* ctxFinalizerToSet);
void TapdaqAdMobExtensionFinalizer(void* extData);
