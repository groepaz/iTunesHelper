//
//  Global.h
//  iTunesUI
//
//  Created by Michael Hess on 14.11.13.
//
//

#import <Foundation/Foundation.h>

@interface GlobalAccess : NSObject{
}

+ (void) SetArrayControler: (NSArrayController *) controller;
+ (NSArrayController *) GetArrayControler;

@end
