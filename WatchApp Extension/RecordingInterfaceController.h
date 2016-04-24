//
//  RecordingInterfaceController.h
//  Popuptest
//
//  Created by ship8-2 on 12/22/15.
//  Copyright © 2015 ship8-2. All rights reserved.
//

#import <WatchKit/WatchKit.h>
#import <Foundation/Foundation.h>
#import <CoreMotion/CoreMotion.h>
#import <WatchConnectivity/WatchConnectivity.h>
#import "ExtensionDelegate.h"


@class RecordingInterfaceController;

@protocol RecordingInterfaceControllerDelegate <NSObject>

-(void)RecordingInterfaceControllerDidLoad:(RecordingInterfaceController*)sender;

@end



@interface RecordingInterfaceController : WKInterfaceController<WCSessionDelegate>

@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceLabel *activityLabel;
@property (unsafe_unretained, nonatomic) IBOutlet WKInterfaceTimer *recodingTimer;


@property (weak, nonatomic) NSString *activityString;//
@property (nonatomic) NSTimeInterval timeInterval;//

@property (nonatomic, retain) NSTimer *timer;//

@property (strong,nonatomic) id<RecordingInterfaceControllerDelegate> delegate;

- (IBAction)stopButton;



@end
