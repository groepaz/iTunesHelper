//
//  iTunesUIAppDelegate.m
//  iTunesUI
//
//  Created by Michael Hess on 10.07.13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "iTunesUIAppDelegate.h"
#import "File.h"
#import "UnusedFiles.h"


@implementation iTunesUIAppDelegate

@synthesize window;

- (void)applicationDidFinishLaunching:(NSNotification *)aNotification {
	
	UnusedFiles *worker = [[UnusedFiles alloc] init];
	
	NSArray *unusedFiles = [worker listOfUnusedFiles:@"/Users/michaelhess/Music/iTunes/iTunes Music Library.xml"];
	
	for (NSString *pathAndFile in unusedFiles)
	{
		File *file = [[File alloc] init];
		[file setFilePath:pathAndFile];
		[filePathsArrayController addObject:file]; 
	}
}

@end
