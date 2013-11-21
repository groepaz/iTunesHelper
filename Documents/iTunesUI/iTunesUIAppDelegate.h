//
//  iTunesUIAppDelegate.h
//  iTunesUI
//
//  Created by Michael Hess on 10.07.13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface iTunesUIAppDelegate : NSObject <NSApplicationDelegate> {
    NSWindow *window;
    IBOutlet NSArrayController *filePathsArrayController;
	IBOutlet NSTextField *sizeField;
	IBOutlet NSTextField *xmlFilePath;
	IBOutlet NSTextField *musicFilePath;
	IBOutlet NSProgressIndicator *progressIndicator;
	IBOutlet NSWindow *windowUnusedFiles;
	NSString *iTunesMusicFolder;
}

- (IBAction) showUnusedFiles:(id)sender;
- (IBAction) openXmlFile:(id)sender;
- (IBAction) setiTunesFolder:(id)sender;
- (IBAction) processFolder:(id)sender;
- (NSArray *) GetSelectedItemsFromController;
- (iTunesUIAppDelegate *) GetInstance;

@property (nonatomic, retain) IBOutlet NSWindow *window;
@property (nonatomic, retain) IBOutlet NSTextField *sizeField;
@property (nonatomic, retain) IBOutlet NSTextField *xmlFilePath;
@property (nonatomic, retain) IBOutlet NSTextField *musicFilePath;
@property (nonatomic, retain) IBOutlet NSProgressIndicator *progressIndicator;
@property (nonatomic, retain) IBOutlet NSWindow *windowUnusedFiles;

@property (nonatomic, retain) NSString *iTunesMusicFolder;
@property (nonatomic, retain) NSString *xmlFileFolder;

@end