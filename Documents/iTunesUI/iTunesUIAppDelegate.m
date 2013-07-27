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


@implementation iTunesUIAppDelegate

@synthesize window;
@synthesize sizeField;
@synthesize progressIndicator;
@synthesize iTunesMusicFolder;
//@synthesize xmlFileDirectory;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {

	[progressIndicator setHidden: YES];	
}

- (IBAction)deleteItems:(id)sender {
}

- (IBAction) setiTunesFolder:(id)sender{
	
	
//	if(! [windowUnusedFiles isVisible] )
//        [windowUnusedFiles makeKeyAndOrderFront:sender];
//	
//	return;
	
	
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


- (IBAction) openXmlFile:(id)sender{

	NSString *musicFolder = iTunesMusicFolder;
	
	if(musicFolder == nil || [musicFolder isEqualToString:@""])
	{
		NSString *theAlertMessage = @"You must choose your iTunes Music Folder first.";
		NSRunAlertPanel( @"Error", theAlertMessage, @"OK", nil, nil );
		return;
	}
	
	NSArray *fileTypes = [NSArray arrayWithObjects:@"xml",nil];
	NSOpenPanel * panel = [NSOpenPanel openPanel];
	[panel setAllowsMultipleSelection:NO];
	[panel setCanChooseDirectories:YES];
	[panel setCanChooseFiles:YES];
	[panel setFloatingPanel:YES];
	
	NSInteger result = [panel runModalForDirectory:NSHomeDirectory() file:nil types:fileTypes];
	
	if(result == NSOKButton)
	{
		[progressIndicator setUsesThreadedAnimation:YES]; 
		[progressIndicator setIndeterminate:YES];
		[progressIndicator setDisplayedWhenStopped:NO];
		[progressIndicator setHidden: NO];
		[progressIndicator startAnimation: self];
		
		NSString *xmlFileDirectory = [panel filename];
		[xmlFilePath setStringValue: [@"iTunes Xml Export File: " stringByAppendingString:xmlFileDirectory]];
		
		UnusedFiles *worker = [[UnusedFiles alloc] init];
		NSArray *unusedFiles = [worker listOfUnusedFiles:xmlFileDirectory :musicFolder];
		NSFileManager *fileManager = [[NSFileManager alloc] init];	

		int sumOfFilesSizes;
			
		for (NSString *pathAndFile in unusedFiles)
		{
			NSDictionary *fileSize = [fileManager fileAttributesAtPath:pathAndFile traverseLink:YES];
			NSNumber *totalFileSize = [fileSize objectForKey:NSFileSize];
			
			File *file = [[File alloc] init];
			[file setFilePath:pathAndFile];
			[file setFileSize:[NSString stringWithFormat:@"%i", [totalFileSize integerValue]]];
			
			sumOfFilesSizes += [totalFileSize integerValue];
			[filePathsArrayController addObject:file]; 
		}
		
		int fileCount = [unusedFiles count];
		
		Utils *utils = [[Utils alloc] init];
		
		NSString *filesCount = [NSString stringWithFormat:@"%@ by %i files",[utils stringFromFileSize:sumOfFilesSizes],fileCount];
		
		[sizeField setStringValue:[@"Space used: " stringByAppendingString:filesCount]];									
		[progressIndicator stopAnimation: self];
		[progressIndicator setHidden: YES];
	}	
}

@end
