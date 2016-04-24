//
//  IntervalInterfaceController.m
//  Popuptest
//
//  Created by ship8-2 on 12/22/15.
//  Copyright © 2015 ship8-2. All rights reserved.
//

#import "IntervalInterfaceController.h"

@interface IntervalInterfaceController ()

@end

@implementation IntervalInterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    
    self.delegate=context;
    
    // Configure interface objects here.

    self.timeInterval=1.0;
    
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
}

- (IBAction)times100Button {
    self.timeInterval=1.0/5.0;
    self.timeIntervalString=@"100 times/second";
    
    [self.delegate IntervalDidSelect:self];
    [self dismissController];
}

- (IBAction)times50Button {
    self.timeInterval=1.0/5.0;
    self.timeIntervalString=@"50 times/second";
    
    [self.delegate IntervalDidSelect:self];
    [self dismissController];
}

- (IBAction)times25Button {
    self.timeInterval=1.0/5.0;
    self.timeIntervalString=@"25 times/second";
    
    [self.delegate IntervalDidSelect:self];
    [self dismissController];
}

- (IBAction)times10Button {
    self.timeInterval=1.0/5.0;
    self.timeIntervalString=@"10 times/second";
    
    [self.delegate IntervalDidSelect:self];
    [self dismissController];
}

- (IBAction)times5Button {
    self.timeInterval=1.0/5.0;
    self.timeIntervalString=@"5 times/second";
    
    [self.delegate IntervalDidSelect:self];
    [self dismissController];
}

- (IBAction)times1Button {
    self.timeInterval=1.0;
    self.timeIntervalString=@"1 times/second";
    
    [self.delegate IntervalDidSelect:self];
    [self dismissController];
}

@end



