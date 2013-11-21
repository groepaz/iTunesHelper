//
//  windowUnusedFilesController.h
//  iTunesUI
//
//  Created by Michael Hess on 16.07.13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface windowUnusedFilesController : NSObject {
    NSWindow *window;

}

- (IBAction) deleteAllFiles:(id)sender;

- (IBAction) deleteSelectedFiles:(id)sender;

@property (nonatomic, retain) IBOutlet NSWindow *window;

@end
