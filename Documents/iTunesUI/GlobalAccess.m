//
//  Global.m
//  iTunesUI
//
//  Created by Michael Hess on 14.11.13.
//
//

#import "GlobalAccess.h"

@implementation GlobalAccess


static NSArrayController *filePathsArrayController;


+ (void) SetArrayControler: (NSArrayController *) controller{

    filePathsArrayController = controller;
}


+ (NSArrayController *) GetArrayControler{

    return filePathsArrayController;
}

@end
