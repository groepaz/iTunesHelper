//
//  windowUnusedFilesController.m
//  iTunesUI
//
//  Created by Michael Hess on 16.07.13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "windowUnusedFilesController.h"
#import "iTunesUIAppDelegate.h"
#import "GlobalAccess.h"
#import "File.h"


@implementation windowUnusedFilesController

@synthesize window;


- (IBAction) deleteSelectedFiles:(id)sender{

}

- (IBAction) deleteAllFiles:(id)sender{

    NSArrayController *filePathsArrayController = [GlobalAccess GetArrayControler];
    
    NSFileManager *fileManager = [[NSFileManager alloc] init];
    
    NSArray *strings = [[NSArray alloc]initWithArray:[filePathsArrayController arrangedObjects]];
    
	for ( File *file  in strings)
	{
        [fileManager removeItemAtPath:[file filePath] error:nil];
		NSLog([file filePath]);
	}
}
@end
