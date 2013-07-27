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

-(NSArray *) listOfUnusedFiles:(NSString *)iTunesXmlExportFolder  :(NSString *)iTunesMusic{

	//NSDirectoryEnumerator *enumerator = [[NSFileManager defaultManager] enumeratorAtPath:iTunesMusicFolder];
	
	NSArray *keys = [NSArray arrayWithObjects:
					 NSURLIsDirectoryKey, NSURLIsPackageKey, NSURLLocalizedNameKey, nil];
	
	NSURL *urli = [NSURL URLWithString:iTunesMusic];

	
	NSDirectoryEnumerator *enumerator = [[NSFileManager defaultManager]
										 enumeratorAtURL:urli   
										 includingPropertiesForKeys:keys
										 options:(NSDirectoryEnumerationSkipsPackageDescendants |
												  NSDirectoryEnumerationSkipsHiddenFiles)
										 errorHandler:^(NSURL *url, NSError *error) {
											 // Handle the error.
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
			
//			NSString *check=@"Cold Mirrors";
// 			
//			if([filePath rangeOfString:check].location!=NSNotFound)
//            {
//				fileIniTunes = [filePath lowercaseString];
//				NSLog([NSString stringWithFormat:@"Found in iTunes: %@", [filePath lowercaseString]]);
//			}
			
			
		}
	}
	
	NSMutableArray* unusedFiles = [[NSMutableArray alloc] initWithCapacity:0];
	
	for (NSURL *pathAndFile in enumerator) 
	{				
		NSString *pathToDelete =  [pathAndFile path];   // [NSString stringWithFormat:@"%@/%@", iTunesMusicFolder, pathAndFile]; 
		
		pathToDelete = [pathToDelete lowercaseString];
		
		if( [pathToDelete hasSuffix:@".mp3"])
		{			
			if(![filesFromXml containsObject:(id)pathToDelete])
			{
				[unusedFiles addObject:pathToDelete];	
			
//				NSString *check=@"cold mirrors";
//			
//				if([pathToDelete rangeOfString:check].location!=NSNotFound)
//				{
//					bool test = [[pathToDelete lowercaseString] isEqualToString:fileIniTunes];
//					
//					if(!test)
//					{
//
//						NSLog([NSString stringWithFormat:@"Found in unused Files: %@", [pathToDelete lowercaseString]]);
//
//						
//						NSUInteger length = [pathToDelete length];
//						unichar buffer[length];
//						
//						NSUInteger lengthSource = [fileIniTunes length];
//						unichar bufferSource[lengthSource];
//					
//						if(length != lengthSource)
//							NSLog(@"The length Fucked up!");
//						
//						[pathToDelete getCharacters:buffer range:NSMakeRange(0, length)];
//						[fileIniTunes getCharacters:bufferSource range:NSMakeRange(0, length)];
//
//						
//						for (NSUInteger i = 0; i < length; i++)
//						{
//							if(buffer[i] != bufferSource[i])
//								NSLog(@"Found da fuck!");
//							
//							printf("%c\n", buffer[i]);
//						}
//					}					
//					
				//	NSLog(@"Found at index %i", [filesFromXml indexOfObject:pathToDelete]);

				//}
			}
		}
	}
	return unusedFiles;
}

@end
