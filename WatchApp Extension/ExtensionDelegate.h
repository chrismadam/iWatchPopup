//
//  ExtensionDelegate.h
//  WatchApp Extension
//
//  Created by ship8-2 on 12/21/15.
//  Copyright © 2015 ship8-2. All rights reserved.
//

#import <WatchKit/WatchKit.h>
#import <Foundation/Foundation.h>
#import <CoreMotion/CoreMotion.h>
#import <WatchConnectivity/WatchConnectivity.h>

@interface ExtensionDelegate : NSObject <WKExtensionDelegate>{
    CMMotionManager *motionManager;
}

@property (readonly) CMMotionManager *motionManager;//

@end
