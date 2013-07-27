//
//  Utils.m
//  iTunesUI
//
//  Created by Michael Hess on 11.07.13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "Utils.h"


@implementation Utils

- (NSString *)stringFromFileSize:(int)theSize
{
	float floatSize = theSize;
	if (theSize<1023)
		return([NSString stringWithFormat:@"%i bytes",theSize]);
	floatSize = floatSize / 1024;
	if (floatSize<1023)
		return([NSString stringWithFormat:@"%1.1f KB",floatSize]);
	floatSize = floatSize / 1024;
	if (floatSize<1023)
		return([NSString stringWithFormat:@"%1.1f MB",floatSize]);
	floatSize = floatSize / 1024;
	
	return([NSString stringWithFormat:@"%1.1f GB",floatSize]);
}


- (NSXMLDocument *)createXMLDocumentFromFile:(NSString *)file
{
    NSError *err = nil;
	
    NSURL *furl = [NSURL fileURLWithPath:file];
    if( !furl )
    {
        NSLog(@"Can't create an URL from file %@.", file );
        return nil;
    }
	
	
    NSXMLDocument *xmlDoc = [[NSXMLDocument alloc] initWithContentsOfURL:furl options:(NSXMLNodePreserveWhitespace|NSXMLNodePreserveCDATA) error:&err];
	if( xmlDoc == nil )
    {
        xmlDoc = [[NSXMLDocument alloc] initWithContentsOfURL:furl options:NSXMLDocumentTidyXML error:&err];
    }
	
	return xmlDoc;
}

- (NSString *)stringReplace:(NSString*) sourceString :(NSString*) source :(NSString *) replace{

	
	NSMutableArray* aList = [[[NSMutableArray alloc] initWithObjects:source,nil] autorelease];
	NSMutableArray* bList = [[[NSMutableArray alloc] initWithObjects:replace,nil] autorelease];

	for (int i=0; i<[aList count];i++)
	{
		sourceString = [sourceString stringByReplacingOccurrencesOfString:[aList objectAtIndex:i] 
											 withString:[bList objectAtIndex:i]];
	}
	
	return sourceString;	
}


- (NSString *)normalizeUrl:(NSString *)url
{
	NSMutableArray* aList = [[[NSMutableArray alloc] initWithObjects:@"%20",nil]autorelease];
	NSMutableArray* bList = [[[NSMutableArray alloc] initWithObjects:@" ",nil]autorelease];
	
	for (int i=0; i<[aList count];i++)
	{
		url = [url stringByReplacingOccurrencesOfString:[aList objectAtIndex:i] 
											 withString:[bList objectAtIndex:i]];
	}
	
	aList = [[[NSMutableArray alloc] initWithObjects:@"file://localhost",nil]autorelease];
	bList = [[[NSMutableArray alloc] initWithObjects:@"",nil]autorelease];
	
	
	for (int i=0; i<[aList count];i++)
	{
		url = [url stringByReplacingOccurrencesOfString:[aList objectAtIndex:i] 
											 withString:[bList objectAtIndex:i]];
	}
	
	return url;
}



@end
