//
//  InterfaceController.h
//  WatchApp Extension
//
//  Created by ship8-2 on 12/21/15.
//  Copyright © 2015 ship8-2. All rights reserved.
//

#import <WatchKit/WatchKit.h>
#import <Foundation/Foundation.h>
#import <CoreMotion/CoreMotion.h>
#import <WatchConnectivity/WatchConnectivity.h>

#import "ExtensionDelegate.h"
#import "ActivityInterfaceController.h"
#import "IntervalInterfaceController.h"
#import "RecordingInterfaceController.h"


@interface InterfaceController : WKInterfaceController<ActivityInterfaceControllerDelegate,IntervalInterfaceControllerDelegate,WCSessionDelegate>
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceButton *activityButton;
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceButton *intervalButton;


@property (strong, nonatomic) NSString *activityString;
@property (strong, nonatomic) NSString *intervalString;

@property (nonatomic) NSTimeInterval timeInterval;//

@property (nonatomic, retain) NSTimer *timer;//

- (IBAction)selectActivity;
- (IBAction)selectInterval;
- (IBAction)startRecoding;

@end
