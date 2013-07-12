//
//  Utils.h
//  iTunesUI
//
//  Created by Michael Hess on 11.07.13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import <Cocoa/Cocoa.h>


@interface Utils : NSObject {

}

- (NSXMLDocument *) createXMLDocumentFromFile:(NSString *)file;

- (NSString *)normalizeUrl:(NSString *)url;

@end
