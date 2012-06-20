//
//  AneUnRarHelper.h
//  AneUnRar
//
//  Created by Pedro Casaubon on 16/06/12.
//  Copyright (c) 2012 xperiments. All rights reserved.
//
#import "FlashRuntimeExtensions.h"
#import <Foundation/Foundation.h>
#import "AneUnRar.h"
#import "UnRAR.h"

#define DISPATCH_STATUS_EVENT(extensionContext, code, status) FREDispatchStatusEventAsync((extensionContext), (uint8_t*)code, (uint8_t*)status)

@interface AneUnRarHelper : NSObject{

}

-(void)initContext:(FREContext)ctx;


// Async Extract single file to disc
-(void)extractFileAsync:(NSString *)rarFile
               fromFile:(NSString *)fileName
                 toPath:(NSString *)outputPath;

-(void)inBackgroundExtractFileAsync:(NSArray *)paths;

-(void)onBackgroundExtractFileAsync:(NSNumber *)result;

// Sync Extract single file to disc
-(BOOL)extractFileSync:(NSString *)rarFile
              fromFile:(NSString *)fileName
                toPath:(NSString *)outputPath;



// Async Extract RAR to disc 
-(void)extractRarAsync:(NSString *)rarFile
                toPath:(NSString *)outputPath;

-(void)inBackgroundExtractRarAsync:(NSArray *)paths;

-(void)onBackgroundExtractRarAsync:(NSNumber *)result;

// Sync Extract RAR to disc
-(BOOL)extractRarSync:(NSString *)rarFile
               toPath:(NSString *)outputPath;




// Async get files from RAR
-(void)getFilesAsync:(NSString *)rarFile;

-(void)inBackgroundGetFilesAsync:(NSString *)rarFile;

-(void)onBackgroundGetFilesAsync:(NSArray *)files;

-(FREObject)resultFromBackgroundGetFilesAsync;


// Sync get files from RAR
-(FREObject)getFilesSync:(NSString *)rarFile;

// SET EXTRACT INVISIBLE FILES MODE
-(void)skipInvisibleFiles:(BOOL)mode;

@end