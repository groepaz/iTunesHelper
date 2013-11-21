//
//  iTunesUIAppDelegate.m
//  iTunesUI
//
//  Created by Michael Hess on 10.07.13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//


// Broken Links
// Files die nicht in iTunes sind (PDF Boox)

#import "iTunesUIAppDelegate.h"
#import "File.h"
#import "UnusedFiles.h"
#import "Utils.h"
#import "GlobalAccess.h"


@implementation iTunesUIAppDelegate

@synthesize window;
@synthesize sizeField;
@synthesize progressIndicator;
@synthesize iTunesMusicFolder;
@synthesize xmlFileFolder;
@synthesize xmlFilePath;
@synthesize musicFilePath;
@synthesize windowUnusedFiles;


- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {

	[progressIndicator setHidden: YES];	
}


- (iTunesUIAppDelegate *) GetInstance
{
    return self;
}


- (NSArray *)GetSelectedItemsFromController{
    
	NSArray *selectedItems = [filePathsArrayController selectedObjects];
		
//	for (NSString *pathAndFile in selectedItems)
//	{
//		NSLog(pathAndFile);
//	}
	
	return selectedItems;
}


- (IBAction)showUnusedFiles:(id)sender {
    
	[windowUnusedFiles display];
	
	if(! [windowUnusedFiles isVisible] )
        [windowUnusedFiles makeKeyAndOrderFront:sender];
}

- (IBAction) setiTunesFolder:(id)sender{
	
	NSOpenPanel *panel = [NSOpenPanel openPanel];
	[panel setAllowsMultipleSelection:NO];
	[panel setCanChooseDirectories:YES];
	[panel setCanChooseFiles:NO];
	[panel setFloatingPanel:YES];
	
	NSInteger result = [panel runModalForDirectory:NSHomeDirectory() file:nil types:nil];
	if(result == NSOKButton)
	{
		NSString *musicFolder = [panel filename];
		[musicFilePath setStringValue: [@"iTunes Music Folder: " stringByAppendingString:musicFolder]];
		
		Utils *utils = [[Utils alloc] init];
		musicFolder = [utils stringReplace:musicFolder :@" " :@"%20" ];
		musicFolder = [@"files://localhost" stringByAppendingString: musicFolder];
		[self setITunesMusicFolder:musicFolder];
	}
}


- (IBAction) processFolder:(id)sender{
    
    NSArray *fileTypes = [NSArray arrayWithObjects:@"xml",nil];
    
    [progressIndicator setUsesThreadedAnimation:YES];
    [progressIndicator setIndeterminate:YES];
    [progressIndicator setDisplayedWhenStopped:NO];
    [progressIndicator setHidden: NO];
    [progressIndicator startAnimation: self];

    NSString *musicFolder = iTunesMusicFolder;

    
//    NSString *xmlFolder = [xmlFilePath stringValue];
//    
//    xmlFolder = [xmlFolder stringByReplacingOccurrencesOfString: @"iTunes Xml Export File:  /" withString: @""];
    
    
    
    UnusedFiles *worker = [[UnusedFiles alloc] init];
    NSArray *unusedFiles = [worker listOfUnusedFiles:xmlFileFolder :musicFolder];
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    
    int sumOfFilesSizes;
    
    for (NSString *pathAndFile in unusedFiles)
    {
        //NSDictionary *fileSize = [fileManager fileAttributesAtPath:pathAndFile traverseLink:YES];
        
        NSDictionary *fileSize = [fileManager fileAttributesAtPath:pathAndFile traverseLink:YES];
        
        NSNumber *totalFileSize = [fileSize objectForKey:NSFileSize];
        
        File *file = [[File alloc] init];
        [file setFilePath:pathAndFile];
        [file setFileSize:[NSString stringWithFormat:@"%i", [totalFileSize integerValue]]];
        
        sumOfFilesSizes += [totalFileSize integerValue];
        [filePathsArrayController addObject:file];
    }
    
    [GlobalAccess SetArrayControler:filePathsArrayController];
    
    int fileCount = [unusedFiles count];
    
    Utils *utils = [[Utils alloc] init];
    
    NSString *filesCount = [NSString stringWithFormat:@"%@ used by %i files",[utils stringFromFileSize:sumOfFilesSizes],fileCount];
    
    [sizeField setStringValue:[@"Space used by unused Files: " stringByAppendingString:filesCount]];
    
    [progressIndicator stopAnimation: self];
    [progressIndicator setHidden: YES];

}


- (IBAction) openXmlFile:(id)sender{

	NSString *musicFolder = iTunesMusicFolder;
    NSArray *fileTypes = [NSArray arrayWithObjects:@"xml",nil];

	
	if(musicFolder == nil || [musicFolder isEqualToString:@""])
	{
		NSString *theAlertMessage = @"You must choose your iTunes Music Folder first.";
		NSRunAlertPanel( @"Error", theAlertMessage, @"OK", nil, nil );
		return;
	}
	
    NSOpenPanel * panel = [NSOpenPanel openPanel];
	[panel setAllowsMultipleSelection:NO];
	[panel setCanChooseDirectories:YES];
	[panel setCanChooseFiles:YES];
	[panel setFloatingPanel:YES];

	NSInteger result = [panel runModalForDirectory:NSHomeDirectory() file:nil types:fileTypes];
    NSString *xmlFileDirectory = [panel filename];
    
	if(result == NSOKButton)
	{
        [xmlFilePath setStringValue: [@"iTunes Xml Export File: " stringByAppendingString:xmlFileDirectory]];
        [self setXmlFileFolder:xmlFileDirectory];
    }
}

@end
