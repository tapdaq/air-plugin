#import <Foundation/Foundation.h>
#import "FlashRuntimeExtensions.h"

#define DEFINE_ANE_FUNCTION(fn) FREObject fn(FREContext context, void* functionData, uint32_t argc, FREObject argv[])

#define MAP_FUNCTION(fn, data) { (const uint8_t*)(#fn), (data), &(fn) }
#define MAP_NEW_FUNCTION(fn, name, data) { (const uint8_t*)(#name), (data), &(fn) }

#define ROOT_VIEW_CONTROLLER [[[UIApplication sharedApplication] keyWindow] rootViewController]

#define UIColorFromRGB(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0];

void FPANE_DispatchEvent(FREContext context, NSString *eventName);
void FPANE_DispatchEventWithInfo(FREContext context, NSString *eventName, NSString *eventInfo);
void FPANE_Log(FREContext context, NSString *message);

NSString * FPANE_FREObjectToNSString(FREObject object);
NSArray * FPANE_FREObjectToNSArrayOfNSString(FREObject object);
NSDictionary * FPANE_FREObjectsToNSDictionaryOfNSString(FREObject keys, FREObject values);
BOOL FPANE_FREObjectToBool(FREObject object);
NSInteger FPANE_FREObjectToInt(FREObject object);

FREObject FPANE_BOOLToFREObject(BOOL boolean);
FREObject FPANE_IntToFREObject(NSInteger i);
FREObject FPANE_DoubleToFREObject(double d);
FREObject FPANE_NSStringToFREObject(NSString *string);

FREObject FPANE_CreateError( NSString* error, NSInteger* id );
