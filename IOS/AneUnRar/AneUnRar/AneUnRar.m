//
//  AneUnRar.m
//  AneUnRar
//
//  Created by Pedro Casaubon on 17/06/2012.
//  Copyright (c)2012 Pedro Casaubon. All rights reserved.
//

#import "FlashRuntimeExtensions.h"
#import "AneUnRar.h"
#import "AneUnRarHelper.h"
#import "AneUnRarEventMessages.h"


@implementation AneUnRar 

AneUnRarHelper *rarHelper;
FREContext context;
BOOL skipInvisibleFiles;

-(id)init
{
    self = [super init];
    if (self) {
        // Initialization code here.
    }
    return self;
}



/****************************************************************************************
 * @method:extractFileAsync( rarFile:String,fileName:String,outputFileName:String):void
 ****************************************************************************************/
DEFINE_ANE_FUNCTION( extractFileAsync )
{
	
	//  rarFile:String = argument[0];
    
	uint32_t rarFileLength;
	const uint8_t *rarFile_CString;
	FREGetObjectAsUTF8(argv[0], &rarFileLength, &rarFile_CString);
	NSString *rarFile = [NSString stringWithUTF8String:(char*)rarFile_CString];
	
    
	//  fileName:String = argument[1];
    
	uint32_t fileNameLength;
	const uint8_t *fileName_CString;
	FREGetObjectAsUTF8(argv[1], &fileNameLength, &fileName_CString);
	NSString *fileName = [NSString stringWithUTF8String:(char*)fileName_CString];
	
    
	//  outputFileName:String = argument[2];
    
	uint32_t outputFileNameLength;
	const uint8_t *outputFileName_CString;
	FREGetObjectAsUTF8(argv[2], &outputFileNameLength, &outputFileName_CString);
	NSString *outputFileName = [NSString stringWithUTF8String:(char*)outputFileName_CString];
	
    // call async process
    [rarHelper extractFileAsync:rarFile fromFile:fileName toPath:outputFileName];

	return NULL;
}


/****************************************************************************************
 * @method:extractFileSync( rarFile:String,fileName:String,outputFileName:String):Boolean
 ****************************************************************************************/
DEFINE_ANE_FUNCTION( extractFileSync )
{
    BOOL success = NO;
	
	// rarFile:String = argument[0];
    
	uint32_t rarFileLength;
	const uint8_t *rarFile_CString;
	FREGetObjectAsUTF8(argv[0], &rarFileLength, &rarFile_CString);
	NSString *rarFile = [NSString stringWithUTF8String:(char*)rarFile_CString];
	
    
	// fileName:String = argument[1];
    
	uint32_t fileNameLength;
	const uint8_t *fileName_CString;
	FREGetObjectAsUTF8(argv[1], &fileNameLength, &fileName_CString);
	NSString *fileName = [NSString stringWithUTF8String:(char*)fileName_CString];
	
    
	// outputFileName:String = argument[2];
    
	uint32_t outputFileNameLength;
	const uint8_t *outputFileName_CString;
	FREGetObjectAsUTF8(argv[2], &outputFileNameLength, &outputFileName_CString);
	NSString *outputFileName = [NSString stringWithUTF8String:(char*)outputFileName_CString];
	

    // extract file
    success = [rarHelper extractFileSync:rarFile fromFile:fileName toPath:outputFileName];

	//  return->as3 ( resultFromBoolean as Boolean );
	FREObject ane_resultFromBoolean= nil;
	FRENewObjectFromBool(success, &ane_resultFromBoolean);
	return ane_resultFromBoolean;
    
}


/****************************************************************************************
 * @method:extractRarAsync( rarFile:String,outputDir:String):void
 ****************************************************************************************/
DEFINE_ANE_FUNCTION( extractRarAsync )
{
	
	//  rarFile:String = argument[0];
    
	uint32_t rarFileLength;
	const uint8_t *rarFile_CString;
	FREGetObjectAsUTF8(argv[0], &rarFileLength, &rarFile_CString);
	NSString *rarFile = [NSString stringWithUTF8String:(char*)rarFile_CString];
	
    
	//  outputDir:String = argument[1];
    
	uint32_t outputDirLength;
	const uint8_t *outputDir_CString;
	FREGetObjectAsUTF8(argv[1], &outputDirLength, &outputDir_CString);
	NSString *outputDir = [NSString stringWithUTF8String:(char*)outputDir_CString];

    // call async process
    [rarHelper extractRarAsync:rarFile toPath:outputDir];
              
    
	return NULL;
}


/****************************************************************************************
 * @method:extractRarSync( rarFile:String,outputDir:String):Boolean
 ****************************************************************************************/
DEFINE_ANE_FUNCTION( extractRarSync )
{
    BOOL success = NO;    
	
	//  rarFile:String = argument[0];
    
	uint32_t rarFileLength;
	const uint8_t *rarFile_CString;
	FREGetObjectAsUTF8(argv[0], &rarFileLength, &rarFile_CString);
	NSString *rarFile = [NSString stringWithUTF8String:(char*)rarFile_CString];
	
    
	//  outputDir:String = argument[1];
    
	uint32_t outputDirLength;
	const uint8_t *outputDir_CString;
	FREGetObjectAsUTF8(argv[1], &outputDirLength, &outputDir_CString);
	NSString *outputDir = [NSString stringWithUTF8String:(char*)outputDir_CString];
	
    // extract RAR to disk
    success = [rarHelper extractRarSync:rarFile toPath:outputDir];
 
	//  return->as3 ( resultFromBoolean as Boolean );
	FREObject ane_resultFromBoolean= nil;
	FRENewObjectFromBool(success, &ane_resultFromBoolean);
	
	return ane_resultFromBoolean;
    
}


/****************************************************************************************
 * @method:getFilesAsync( rarFile:String):void
 ****************************************************************************************/
DEFINE_ANE_FUNCTION( getFilesAsync )
{
	
	//  rarFile:String = argument[0];
    
	uint32_t rarFileLength;
	const uint8_t *rarFile_CString;
	FREGetObjectAsUTF8(argv[0], &rarFileLength, &rarFile_CString);
	NSString *rarFile = [NSString stringWithUTF8String:(char*)rarFile_CString];
	
    // call async process
    [rarHelper getFilesAsync:rarFile];
    
	return NULL;
}


/****************************************************************************************
 * @method:getCurrentFilesArray( ):Array
 ****************************************************************************************/
DEFINE_ANE_FUNCTION( getResultFromGetFilesAsync )
{
	return [rarHelper resultFromBackgroundGetFilesAsync];
}



/****************************************************************************************
 * @method:getFilesSync( rarFile:String):Array
 ****************************************************************************************/
DEFINE_ANE_FUNCTION( getFilesSync )
{
	
	//  rarFile:String = argument[0];
    
	uint32_t rarFileLength;
	const uint8_t *rarFile_CString;
	FREGetObjectAsUTF8(argv[0], &rarFileLength, &rarFile_CString);
	NSString *rarFile = [NSString stringWithUTF8String:(char*)rarFile_CString];
	
	return [rarHelper getFilesSync:rarFile];
	
}

/****************************************************************************************
 * @method:extractInvisibleFiles( mode:Boolean):void
 ****************************************************************************************/
DEFINE_ANE_FUNCTION( extractInvisibleFiles )
{
	//  mode:Boolean = argument[0];
    
    uint32_t mode;
    FREGetObjectAsBool(argv[0], &mode);
    
    [rarHelper skipInvisibleFiles:mode];
    
    return NULL;
	
}

/****************************************************************************************
 *																						*
 *	EXTENSION & CONTEXT																	*
 *																						*
 ****************************************************************************************/

void AneUnRarContextInitializer( void* extData, const uint8_t* ctxType, FREContext ctx, uint32_t* numFunctionsToSet, const FRENamedFunction** functionsToSet )
{
	static FRENamedFunction functionMap[] = {
		// METHODS
		MAP_FUNCTION( extractFileAsync, NULL ),
		MAP_FUNCTION( extractFileSync, NULL ),
		MAP_FUNCTION( extractRarAsync, NULL ),
		MAP_FUNCTION( extractRarSync, NULL ),
		MAP_FUNCTION( getFilesAsync, NULL ),
		MAP_FUNCTION( getFilesSync, NULL ),
        MAP_FUNCTION( getResultFromGetFilesAsync, NULL ),
        MAP_FUNCTION( extractInvisibleFiles, NULL )
        
	};
	*numFunctionsToSet = sizeof( functionMap ) / sizeof( FRENamedFunction );
	*functionsToSet = functionMap;
    context = ctx;
    rarHelper = [[AneUnRarHelper alloc] init];
    [rarHelper initContext:ctx];    

}
void AneUnRarContextFinalizer( FREContext ctx )
{
	NSLog(@"Entering AneUnRarContextFinalizer()");
	NSLog(@"Exiting AneUnRarContextFinalizer()");
    [rarHelper release];
    context = nil;
	return;
}
void AneUnRarExtensionInitializer( void** extDataToSet, FREContextInitializer* ctxInitializerToSet, FREContextFinalizer* ctxFinalizerToSet ) 
{ 
	NSLog(@"Entering AneUnRarExtensionInitializer()");
	extDataToSet = NULL;  // This example does not use any extension data.
	*ctxInitializerToSet = &AneUnRarContextInitializer;
	*ctxFinalizerToSet = &AneUnRarContextFinalizer;
}
void AneUnRarExtensionFinalizer()
{
	NSLog(@"Entering AneUnRarExtensionFinalizer()");
	return;
}
@end  
