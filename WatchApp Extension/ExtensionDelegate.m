//
//  ExtensionDelegate.m
//  WatchApp Extension
//
//  Created by ship8-2 on 12/21/15.
//  Copyright © 2015 ship8-2. All rights reserved.
//

#import "ExtensionDelegate.h"

@implementation ExtensionDelegate



- (void)applicationDidFinishLaunching {
    // Perform any final initialization of your application.
}

- (void)applicationDidBecomeActive {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillResignActive {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, etc.
    
}


- (CMMotionManager *)motionManager
{
    if (!motionManager) motionManager = [[CMMotionManager alloc] init];
    
    return motionManager;
}

@end
