//
//  AneUnRar.h
//  AneUnRar
//
//  Created by Pedro Casaubon on 16/06/12.
//  Copyright (c) 2012 xperiments. All rights reserved.
//
#import "FlashRuntimeExtensions.h"
#import "UnRAR.h"
#define DEFINE_ANE_FUNCTION(fn) FREObject (fn)(FREContext context, void* functionData, uint32_t argc, FREObject argv[])
#define DISPATCH_STATUS_EVENT(extensionContext, code, status) FREDispatchStatusEventAsync((extensionContext), (uint8_t*)code, (uint8_t*)status)
#define MAP_FUNCTION(fn, data) { (const uint8_t*)(#fn), (data), &(fn) }


@interface AneUnRar : NSObject {
    

}


FREObject extractFileAsync (FREContext ctx, void* funcData, uint32_t argc, FREObject argv[]);
FREObject extractFileSync (FREContext ctx, void* funcData, uint32_t argc, FREObject argv[]);

FREObject extractRarAsync (FREContext ctx, void* funcData, uint32_t argc, FREObject argv[]);
FREObject extractRarSync (FREContext ctx, void* funcData, uint32_t argc, FREObject argv[]);

FREObject getFilesAsync (FREContext ctx, void* funcData, uint32_t argc, FREObject argv[]);
FREObject getResultFromGetFilesAsync (FREContext ctx, void* funcData, uint32_t argc, FREObject argv[]);

FREObject getFilesSync (FREContext ctx, void* funcData, uint32_t argc, FREObject argv[]);

FREObject extractInvisibleFiles (FREContext ctx, void* funcData, uint32_t argc, FREObject argv[]);


void AneUnRarContextInitializer(void* extData, const uint8_t* ctxType, FREContext ctx, uint32_t* numFunctionsToTest, const FRENamedFunction** functionsToSet);
void AneUnRarContextFinalizer(FREContext ctx);
void AneUnRarExtensionInitializer(void** extDataToSet, FREContextInitializer* ctxInitializerToSet, FREContextFinalizer* ctxFinalizerToSet);
void AneUnRarExtensionFinalizer(void* extData);

@end
