//
//  AneUnRarHelper.m
//  AneUnRar
//
//  Created by Pedro Casaubon on 16/06/12.
//  Copyright (c) 2012 xperiments. All rights reserved.
//
#import "FlashRuntimeExtensions.h"
#import "AneUnRarEventMessages.h"
#import "AneUnRarHelper.h"
#import "UnRAR.h"



@implementation AneUnRarHelper

FREContext context;
UnRAR* unRarProcess;
BOOL active;

NSArray * savedList;
  

-(id)init
{
    self = [super init];
    if (self)
    {
        active = NO;
        unRarProcess = [[UnRAR alloc] init];
    }
    return self;
}

-(void)initContext:(FREContext)ctx
{
    context = ctx;
}


/* UNRAR TO DISK ASYNC*/

-(void)extractRarAsync:(NSString *)rarFile
                toPath:(NSString *)outputPath
{
    
    NSArray *filePaths = [ NSArray arrayWithObjects:rarFile,outputPath, nil ];
    [self performSelectorInBackground:@selector(inBackgroundExtractRarAsync:) withObject:filePaths];    
}

-(void)inBackgroundExtractRarAsync:(NSArray *)paths
{
    BOOL success = NO;
    if(!active)
    {
        active = YES;
        
        NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];  
            NSString *inRar = [paths objectAtIndex:0];
            NSString *outRar = [paths objectAtIndex:1];
        
            [unRarProcess initWithArchiveAtPath:inRar];
            success = [unRarProcess extractToPath:outRar];
        [pool drain];

        [self performSelectorOnMainThread:@selector(onBackgroundExtractRarAsync:) withObject:[NSNumber numberWithBool:success] waitUntilDone:NO];
        active = NO;
    }    
    
}

-(void)onBackgroundExtractRarAsync:(NSNumber *)result
{
    if([result boolValue] == NO)
    {
        DISPATCH_STATUS_EVENT( context, event_error, @"extractRarAsync" );
    }
    else
    {
        DISPATCH_STATUS_EVENT( context, event_on_extract_rar_complete, @"" );
    }
        

}

/* UNRAR TO DISK SYNC */

-(BOOL)extractRarSync:(NSString *)rarFile
               toPath:(NSString *)outputPath
{
    BOOL success;
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];  

    //UnRAR *unRarProcess = [[UnRAR alloc] initWithArchiveAtPath:rarFile];
    [unRarProcess initWithArchiveAtPath:rarFile];
    success = [unRarProcess extractToPath:outputPath];
    //[unRarProcess release];
    [pool drain];
    
    return success;
}


/* UNRAR FILE TO DISK ASYNC*/


-(void)extractFileAsync:(NSString *)rarFile
               fromFile:(NSString *)fileName
                 toPath:(NSString *)outputPath
{
    NSArray *filePaths = [ NSArray arrayWithObjects:rarFile,fileName, outputPath,nil ];
    [self performSelectorInBackground:@selector(inBackgroundExtractFileAsync:) withObject:filePaths];       
}


-(void)inBackgroundExtractFileAsync:(NSArray *)paths
{
    BOOL success = NO;
    if(!active)
    {
        active = YES;
        NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];  
            NSString *inRar = [paths objectAtIndex:0];
            NSString *inFile = [paths objectAtIndex:1];
            NSString *outFile = [paths objectAtIndex:2];
        
            [unRarProcess initWithArchiveAtPath:inRar];
            success = [unRarProcess extractFile:inFile toPath:outFile];
        [pool drain];
        
        [self performSelectorOnMainThread:@selector(onBackgroundExtractFileAsync:) withObject:[NSNumber numberWithBool:success] waitUntilDone:NO];
        active = NO;
    }    
    
}
-(void)onBackgroundExtractFileAsync:(NSNumber *)result
{
    if([result boolValue] == NO)
    {
        DISPATCH_STATUS_EVENT( context, event_error, @"extractFileAsync" );
    }
    else
    {
        DISPATCH_STATUS_EVENT( context, event_on_extract_file_complete, @"" );
    }    
}

/* UNRAR FILE TO DISK SYNC*/

-(BOOL)extractFileSync:(NSString *)rarFile
              fromFile:(NSString *)fileName
                toPath:(NSString *)outputPath
{
    BOOL success = NO;
    NSAutoreleasePool *pool = [[NSAutoreleasePool alloc] init];  

        [unRarProcess initWithArchiveAtPath:rarFile];
        success = [unRarProcess extractFile:fileName toPath:outputPath];

    [pool drain];
    
    return success;    
}



/* UNRAR GET FILES ASYNC */

-(void)getFilesAsync:(NSString *)rarFile
{
    [self performSelectorInBackground:@selector(inBackgroundGetFilesAsync:) withObject:rarFile];     
}
-(void)inBackgroundGetFilesAsync:(NSString *)rarFile
{
    [unRarProcess initWithArchiveAtPath:rarFile];
    savedList = [ [unRarProcess retrieveFileList] retain];
    [self performSelectorOnMainThread:@selector(onBackgroundGetFilesAsync:) withObject:savedList waitUntilDone:YES ];
}
-(void)onBackgroundGetFilesAsync:(NSArray *)files
{
    savedList = files;
    if (savedList == nil || [savedList count] == 0)
    {
        DISPATCH_STATUS_EVENT( context, event_error, @"getFilesAsync" );
    }
    else
    {
        DISPATCH_STATUS_EVENT( context, event_on_get_files, @"" );
    }
    
}

-(FREObject)resultFromBackgroundGetFilesAsync
{
    FREObject populatedArray = NULL;
    
    FRENewObject((const uint8_t*)"Array", 0, NULL, &populatedArray, nil);    
    
    int count = [savedList count];
    
    for(int i = 0; i<count; i++ )
    {
        FREObject element;
        NSString *currentPath = [savedList objectAtIndex:i];
        const char *currentPathC = [currentPath UTF8String];
        FRENewObjectFromUTF8(strlen(currentPathC)+1, (const uint8_t*)currentPathC, &element );
        
        FRESetArrayElementAt(populatedArray, i, element);
    }
    
    return populatedArray;
}

// UNRAR GET FILES SYNC 
-(FREObject)getFilesSync:(NSString *)rarFile
{
    FREObject populatedArray = NULL;
    // Create a new AS3 Array, pass 0 arguments to the constructor (and no arguments values = NULL)
    FRENewObject((const uint8_t*)"Array", 0, NULL, &populatedArray, nil);                
    
    //UnRAR *unRarProcess = [[UnRAR alloc] initWithArchiveAtPath:rarFile];
    [unRarProcess initWithArchiveAtPath:rarFile];
    NSArray *files = [unRarProcess retrieveFileList];
    int count = [files count];
    
    for(int i = 0; i<count; i++ )
    {
        FREObject element;
        NSString *currentPath = [files objectAtIndex:i];
        const char *currentPathC = [currentPath UTF8String];
        FRENewObjectFromUTF8(strlen(currentPathC)+1, (const uint8_t*)currentPathC, &element );
        
        FRESetArrayElementAt(populatedArray, i, element);
    }
    
    
    return populatedArray;
    
}

-(void)skipInvisibleFiles:(BOOL)mode
{
    unRarProcess.skipInvisibleFiles = mode;
}

@end
