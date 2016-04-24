//
//  ActivityInterfaceController.h
//  Popuptest
//
//  Created by ship8-2 on 12/22/15.
//  Copyright © 2015 ship8-2. All rights reserved.
//

#import <WatchKit/WatchKit.h>
#import <Foundation/Foundation.h>

@class ActivityInterfaceController;

@protocol ActivityInterfaceControllerDelegate<NSObject>

-(void)ActivityDidSelect:(ActivityInterfaceController*)sender;

@end



@interface ActivityInterfaceController : WKInterfaceController

@property (strong, nonatomic) id<ActivityInterfaceControllerDelegate> delegate;

@property (strong, nonatomic) NSString *activityString;

- (IBAction)sittingButton;
- (IBAction)runningButton;
- (IBAction)standingButton;
- (IBAction)walkingButton;
- (IBAction)sleepingButton;
- (IBAction)drivingButton;

@end
