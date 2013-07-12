//
//  Utils.m
//  iTunesUI
//
//  Created by Michael Hess on 11.07.13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "Utils.h"


@implementation Utils

- (NSXMLDocument *)createXMLDocumentFromFile:(NSString *)file
{
    NSError *err = nil;
	
    NSURL *furl = [NSURL fileURLWithPath:file];
    if( !furl )
    {
        NSLog(@"Can't create an URL from file %@.", file );
        return nil;
    }
	
	NSXMLDocument *xmlDoc = [NSXMLDocument alloc] ;
	
    xmlDoc = [[NSXMLDocument alloc] initWithContentsOfURL:furl options:(NSXMLNodePreserveWhitespace|NSXMLNodePreserveCDATA) error:&err];
    if( xmlDoc == nil )
    {
        // in previous attempt, it failed creating XMLDocument because it 
        // was malformed.
        xmlDoc = [[NSXMLDocument alloc] initWithContentsOfURL:furl options:NSXMLDocumentTidyXML error:&err];
    }
	
	return xmlDoc;
}

- (NSString *)normalizeUrl:(NSString *)url
{
	NSMutableArray* aList = [[NSMutableArray alloc] initWithObjects:@"%20",nil];
	NSMutableArray* bList = [[NSMutableArray alloc] initWithObjects:@" ",nil];
	
	for (int i=0; i<[aList count];i++)
	{
		url = [url stringByReplacingOccurrencesOfString:[aList objectAtIndex:i] 
											 withString:[bList objectAtIndex:i]];
	}
	
	aList = [[NSMutableArray alloc] initWithObjects:@"file://localhost",nil];
	bList = [[NSMutableArray alloc] initWithObjects:@"",nil];
	
	
	for (int i=0; i<[aList count];i++)
	{
		url = [url stringByReplacingOccurrencesOfString:[aList objectAtIndex:i] 
											 withString:[bList objectAtIndex:i]];
	}
	
	return url;
}



@end
