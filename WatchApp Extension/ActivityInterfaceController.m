//
//  ActivityInterfaceController.m
//  Popuptest
//
//  Created by ship8-2 on 12/22/15.
//  Copyright © 2015 ship8-2. All rights reserved.
//

#import "ActivityInterfaceController.h"

@interface ActivityInterfaceController ()

@end




@implementation ActivityInterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    
    self.delegate=context;
    
    // Configure interface objects here.
    
    self.activityString=@"";

}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}

- (IBAction)sittingButton {
    self.activityString=@"Sitting";
    [self.delegate ActivityDidSelect:self];
    [self dismissController];
}
- (IBAction)runningButton{
    self.activityString=@"Running";
    [self.delegate ActivityDidSelect:self];
    [self dismissController];
}
- (IBAction)standingButton{
    self.activityString=@"Standing";
    [self.delegate ActivityDidSelect:self];
    [self dismissController];
}
- (IBAction)walkingButton{
    self.activityString=@"Walking";
    [self.delegate ActivityDidSelect:self];
    [self dismissController];
}
- (IBAction)sleepingButton{
    self.activityString=@"Sleeping";
    [self.delegate ActivityDidSelect:self];
    [self dismissController];
}
- (IBAction)drivingButton{
    self.activityString=@"Driving";
    [self.delegate ActivityDidSelect:self];
    [self dismissController];
}

@end



