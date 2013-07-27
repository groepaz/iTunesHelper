//
//  File.h
//  iTunesUI
//
//  Created by Michael Hess on 11.07.13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface File : NSObject {
	
	NSString *filePath;
	NSString *fileSize;
}

@property (nonatomic,retain) NSString *filePath;
@property (nonatomic,retain) NSString *fileSize;

@end
