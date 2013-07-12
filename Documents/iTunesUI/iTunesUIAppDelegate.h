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
}

@property (assign) IBOutlet NSWindow *window;

@end