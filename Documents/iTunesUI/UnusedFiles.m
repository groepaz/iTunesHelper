//
//  UnusedFiles.m
//  iTunesUI
//
//  Created by Michael Hess on 11.07.13.
//  Copyright 2013 __MyCompanyName__. All rights reserved.
//

#import "UnusedFiles.h"
#import "Utils.h"

@implementation UnusedFiles


-(NSArray *) listOfBrokenLinks:(NSString *) iTunesXmlExportFolder :(NSString *) iTunesMusicFolder{


	//TODO
	
	return Nil;
	
}



-(NSArray *) listOfUnusedFiles:(NSString *)iTunesXmlExportFolder  :(NSString *)iTunesMusic{
	
	NSArray *keys = [NSArray arrayWithObjects:
					 NSURLIsDirectoryKey, NSURLIsPackageKey, NSURLLocalizedNameKey, nil];
	
	NSURL *urli = [NSURL URLWithString:iTunesMusic];
	
	NSDirectoryEnumerator *enumerator = [[NSFileManager defaultManager]
										 enumeratorAtURL:urli   
										 includingPropertiesForKeys:keys
										 options:(NSDirectoryEnumerationSkipsPackageDescendants |
												  NSDirectoryEnumerationSkipsHiddenFiles)
										 errorHandler:^(NSURL *url, NSError *error) {
											 return NO;
										 }];
	
	Utils *utils = [[Utils alloc]init];
	
	NSXMLDocument *doc = [utils createXMLDocumentFromFile:iTunesXmlExportFolder];
	NSString *filePath;
    NSError *error;
	NSArray *itemNodes;
	
	NSMutableArray* filesFromXml = [[NSMutableArray alloc] initWithCapacity:0];
	
	itemNodes = [doc nodesForXPath:@"//dict/dict/dict/string" error:&error];
		
	for(NSXMLElement* xmlElement in itemNodes)
	{
		filePath = [xmlElement stringValue];
		
		if([filePath hasPrefix:@"file://"])
		{	
			NSURL *aLocalURL = [NSURL URLWithString:filePath];
			filePath = [aLocalURL path];			
			[filesFromXml addObject:[filePath lowercaseString]];
		}
	}
	
	NSMutableArray* unusedFiles = [[NSMutableArray alloc] initWithCapacity:0];
	
	for (NSURL *pathAndFile in enumerator) 
	{				
		NSString *pathToDelete =  [pathAndFile path];
		
		pathToDelete = [pathToDelete lowercaseString];
		
		if( [pathToDelete hasSuffix:@".mp3"])
		{			
			if(![filesFromXml containsObject:(id)pathToDelete])
			{
				[unusedFiles addObject:pathToDelete];	
			}
		}
	}
	return unusedFiles;
}

@end
