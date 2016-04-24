//
//  InterfaceController.m
//  WatchApp Extension
//
//  Created by ship8-2 on 12/21/15.
//  Copyright © 2015 ship8-2. All rights reserved.
//

#import "InterfaceController.h"
#import "ActivityInterfaceController.h"
#import "IntervalInterfaceController.h"
#import "RecordingInterfaceController.h"


@interface InterfaceController()

@end

NSString *xAccLabel1;
NSString *yAccLabel1;
NSString *zAccLabel1;

NSString *xGyroLabel1;
NSString *yGyroLabel1;
NSString *zGyroLabel1;

NSString *rollLabel1;
NSString *pitchLabel1;
NSString *yawLabel1;

NSString *xRotLabel1;
NSString *yRotLabel1;
NSString *zRotLabel1;

NSString *xGravLabel1;
NSString *yGravLabel1;
NSString *zGravLabel1;

NSString *xUserAccLabel1;
NSString *yUserAccLabel1;
NSString *zUserAccLabel1;

NSString *xMagLabel1;
NSString *yMagLabel1;
NSString *zMagLabel1;



@implementation InterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];

    // Configure interface objects here.
    self.activityString=@"";
    self.intervalString=@"";
    
    self.timeInterval=1.0;
    
    
    //recoding data initialize
    xAccLabel1=@"0.0";
    yAccLabel1=@"0.0";
    zAccLabel1=@"0.0";
    
    xGyroLabel1=@"0.0";
    yGyroLabel1=@"0.0";
    zGyroLabel1=@"0.0";
    
    rollLabel1=@"";
    pitchLabel1=@"";
    yawLabel1=@"";
    
    xRotLabel1=@"";
    yRotLabel1=@"";
    zRotLabel1=@"";
    
    xGravLabel1=@"";
    yGravLabel1=@"";
    zGravLabel1=@"";
    
    xUserAccLabel1=@"";
    yUserAccLabel1=@"";
    zUserAccLabel1=@"";
    
    xMagLabel1=@"";
    yMagLabel1=@"";
    zMagLabel1=@"";
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
    
    
    if(!([self.activityString isEqualToString:@""]))
        [self.activityButton setTitle:self.activityString];
    
    if(!([self.intervalString isEqualToString:@""]))
        [self.intervalButton setTitle:self.intervalString];
    
    if ([WCSession isSupported]) {
        WCSession *session = [WCSession defaultSession];
        session.delegate = self;
        [session activateSession];
    }

    
}

- (void)didAppear{
    //Motion manager start
    [self startUpdates];

    //Timer start
    if ([self.timer isValid]){
    }else{
        self.timer = [NSTimer
                      scheduledTimerWithTimeInterval: 0.3
                      target:self
                      selector:@selector(recording:)
                      userInfo:nil
                      repeats:YES];
    }
}

- (void)willDisappear{
    //Motion manager stop
    [self stopUpdates];
    
    
    //Timer Stop
    if ([self.timer isValid]) {
        [self.timer invalidate];
    }
    self.timer = nil;

}

- (void)didDeactivate {
    // This method is called when watch view controller is no longer visible
    [super didDeactivate];
 }

- (void)recording:(NSTimer *)timer{
    NSLog(@"recording-1");
    
    NSMutableDictionary *applicationData = [[NSMutableDictionary alloc] init];
    
    [applicationData setObject:@"Recording" forKey:@"Recording"];
    
    [applicationData setObject:xAccLabel1 forKey:@"xAccLabel"];
    [applicationData setObject:yAccLabel1 forKey:@"yAccLabel"];
    [applicationData setObject:zAccLabel1 forKey:@"zAccLabel"];
    
    [applicationData setObject:xGyroLabel1 forKey:@"xGyroLabel"];
    [applicationData setObject:yGyroLabel1 forKey:@"yGyroLabel"];
    [applicationData setObject:zGyroLabel1 forKey:@"zGyroLabel"];
    
    [applicationData setObject:rollLabel1 forKey:@"rollLabel"];
    [applicationData setObject:pitchLabel1 forKey:@"pitchLabel"];
    [applicationData setObject:yawLabel1 forKey:@"yawLabel"];
    
    [applicationData setObject:xRotLabel1 forKey:@"xRotLabel"];
    [applicationData setObject:yRotLabel1 forKey:@"yRotLabel"];
    [applicationData setObject:zRotLabel1 forKey:@"zRotLabel"];
    
    [applicationData setObject:xGravLabel1 forKey:@"xGravLabel"];
    [applicationData setObject:yGravLabel1 forKey:@"yGravLabel"];
    [applicationData setObject:zGravLabel1 forKey:@"zGravLabel"];
    
    [applicationData setObject:xUserAccLabel1 forKey:@"xUserAccLabel"];
    [applicationData setObject:yUserAccLabel1 forKey:@"yUserAccLabel"];
    [applicationData setObject:zUserAccLabel1 forKey:@"zUserAccLabel"];
    
    [applicationData setObject:xMagLabel1 forKey:@"xMagLabel"];
    [applicationData setObject:yMagLabel1 forKey:@"yMagLabel"];
    [applicationData setObject:zMagLabel1 forKey:@"zMagLabel"];
    

    [[WCSession defaultSession] updateApplicationContext:applicationData error:nil];
}

- (CMMotionManager *)motionManager
{
    CMMotionManager *motionManager = nil;
    
    ExtensionDelegate* extentionDelegate=(ExtensionDelegate*)[[WKExtension sharedExtension] delegate];
    
    if ([extentionDelegate respondsToSelector:@selector(motionManager)]) {
        motionManager = [extentionDelegate motionManager];
    }
    
    return motionManager;
}

- (void)startUpdates
{
    // Start accelerometer if available
    if ([self.motionManager isAccelerometerAvailable])
    {
        [self.motionManager setAccelerometerUpdateInterval:0.01];
        [self.motionManager startAccelerometerUpdatesToQueue:
         [NSOperationQueue mainQueue]
                                                 withHandler:
         ^(CMAccelerometerData *data, NSError *error)
         {
             xAccLabel1 = [NSString stringWithFormat:@"%f",
                          data.acceleration.x];
             yAccLabel1 = [NSString stringWithFormat:@"%f",
                          data.acceleration.y];
             zAccLabel1 = [NSString stringWithFormat:@"%f",
                          data.acceleration.z];
             
         }];
        
    }
    
    // Start gyroscope if available
    if ([self.motionManager isGyroAvailable])
    {
        [self.motionManager setGyroUpdateInterval:0.01];
        [self.motionManager startGyroUpdatesToQueue:
         [NSOperationQueue mainQueue]
                                        withHandler:
         ^(CMGyroData *data, NSError *error)
         {
             xGyroLabel1 = [NSString stringWithFormat:@"%f",
                           data.rotationRate.x];
             yGyroLabel1 = [NSString stringWithFormat:@"%f",
                           data.rotationRate.y];
             zGyroLabel1 = [NSString stringWithFormat:@"%f",
                           data.rotationRate.z];
         }];
    }
    
    // Start device motion updates
    if ([self.motionManager isDeviceMotionAvailable])
    {
        //Update twice per second
        [self.motionManager setDeviceMotionUpdateInterval:0.01];
        [self.motionManager startDeviceMotionUpdatesUsingReferenceFrame:
         CMAttitudeReferenceFrameXMagneticNorthZVertical
                                                                toQueue:[NSOperationQueue mainQueue]
                                                            withHandler:
         ^(CMDeviceMotion *deviceMotion, NSError *error)
         
         {
             // Update attitude labels
             rollLabel1 =  [NSString stringWithFormat:@"%f",
                           deviceMotion.attitude.roll];
             pitchLabel1 = [NSString stringWithFormat:@"%f",
                           deviceMotion.attitude.pitch];
             yawLabel1 =   [NSString stringWithFormat:@"%f",
                           deviceMotion.attitude.yaw];
             
             // Update rotation rate labels
             xRotLabel1 = [NSString stringWithFormat:@"%f",
                          deviceMotion.rotationRate.x];
             yRotLabel1 = [NSString stringWithFormat:@"%f",
                          deviceMotion.rotationRate.y];
             zRotLabel1 = [NSString stringWithFormat:@"%f",
                          deviceMotion.rotationRate.z];
             
             // Update user acceleration labels
             xGravLabel1 = [NSString stringWithFormat:@"%f",
                           deviceMotion.gravity.x];
             yGravLabel1 = [NSString stringWithFormat:@"%f",
                           deviceMotion.gravity.y];
             zGravLabel1 = [NSString stringWithFormat:@"%f",
                           deviceMotion.gravity.z];
             
             // Update user acceleration labels
             xUserAccLabel1 = [NSString stringWithFormat:@"%f",
                              deviceMotion.userAcceleration.x];
             yUserAccLabel1 = [NSString stringWithFormat:@"%f",
                              deviceMotion.userAcceleration.y];
             zUserAccLabel1 = [NSString stringWithFormat:@"%f",
                              deviceMotion.userAcceleration.z];
             
             // Update magnetic field labels
             xMagLabel1 = [NSString stringWithFormat:@"%f",
                          deviceMotion.magneticField.field.x];
             yMagLabel1 = [NSString stringWithFormat:@"%f",
                          deviceMotion.magneticField.field.y];
             zMagLabel1 = [NSString stringWithFormat:@"%f",
                          deviceMotion.magneticField.field.z];
             
         }];
    }
    
    
}

-(void)stopUpdates
{
    if ([self.motionManager isAccelerometerAvailable] &&
        [self.motionManager isAccelerometerActive])
    {
        [self.motionManager stopAccelerometerUpdates];
    }
    
    if ([self.motionManager isGyroAvailable] &&
        [self.motionManager isGyroActive])
    {
        [self.motionManager stopGyroUpdates];
    }
    
    if ([self.motionManager isDeviceMotionAvailable] &&
        [self.motionManager isDeviceMotionActive])
    {
        [self.motionManager stopDeviceMotionUpdates];
    }
    
}

//Type of Activity View modal.when button press

- (IBAction)selectActivity {
    //Motion manager stop
    [self stopUpdates];
    
    
    //Timer Stop
    if ([self.timer isValid]) {
        [self.timer invalidate];
    }
    self.timer = nil;
    
    [self presentControllerWithName:@"ActivityInterfaceController" context:self];
}

//Time interval View modal. when button press
- (IBAction)selectInterval {
    //Motion manager stop
    [self stopUpdates];
    
    
    //Timer Stop
    if ([self.timer isValid]) {
        [self.timer invalidate];
    }
    self.timer = nil;
    
    [self presentControllerWithName:@"IntervalInterfaceController" context:self];
}

//recording View modal and start recording when button press.
- (IBAction)startRecoding {
    [self start];
}

//when recording start ,this fuction send start messege to iPhone.

-(void)start{
    NSLog(@"startRecoding");
    
    //Motion manager stop
    [self stopUpdates];


    //Timer Stop
    if ([self.timer isValid]) {
        [self.timer invalidate];
    }
    self.timer = nil;

    
    NSString *messageString = [NSString stringWithFormat:@"%@", @"Start"];
    NSDictionary *applicationData = [[NSDictionary alloc] initWithObjects:@[messageString] forKeys:@[@"Operation"]];
    
    [[WCSession defaultSession] sendMessage:applicationData
                               replyHandler:^(NSDictionary *reply) {
                                   //handle reply from iPhone app here
                               }
                               errorHandler:^(NSError *error) {
                                   //catch any errors here
                               }
     ];
    
    [self presentControllerWithName:@"RecordingInterfaceController" context:self];

}

//ActivityInterfaceControllerDelegate function
//when Type of Activity is selected, this function send Activity type message to iPhone.
-(void)ActivityDidSelect:(ActivityInterfaceController*)sender{
    self.activityString=sender.activityString;
    
    NSLog(@"ActivityDidSelect");
    
    
    NSDictionary *applicationData = [[NSDictionary alloc] initWithObjects:@[self.activityString] forKeys:@[@"Activity"]];
    
    [[WCSession defaultSession] sendMessage:applicationData
                               replyHandler:^(NSDictionary *reply) {
                                   //handle reply from iPhone app here
                               }
                               errorHandler:^(NSError *error) {
                                   //catch any errors here
                               }
     ];
   
 }

//IntervalInterfaceControllerDelegate function
//when time interval is selected, this function send interval message to iPhone.
-(void)IntervalDidSelect:(IntervalInterfaceController*)sender{
    self.timeInterval=sender.timeInterval;
    self.intervalString=sender.timeIntervalString;
    
    NSLog(@"IntervalDidSelect");
    
    NSString *messageString = [NSString stringWithFormat:@"%f", self.timeInterval];
    NSDictionary *applicationData = [[NSDictionary alloc] initWithObjects:@[messageString] forKeys:@[@"Interval"]];
    
    [[WCSession defaultSession] sendMessage:applicationData
                               replyHandler:^(NSDictionary *reply) {
                                   //handle reply from iPhone app here
                               }
                               errorHandler:^(NSError *error) {
                                   //catch any errors here
                               }
     ];
    
    
   
    applicationData = [[NSDictionary alloc] initWithObjects:@[self.intervalString] forKeys:@[@"IntervalString"]];
    
    [[WCSession defaultSession] sendMessage:applicationData
                               replyHandler:^(NSDictionary *reply) {
                                   //handle reply from iPhone app here
                               }
                               errorHandler:^(NSError *error) {
                                   //catch any errors here
                               }
     ];
    
}

-(void)RecordingInterfaceControllerDidLoad:(RecordingInterfaceController*)sender{
    sender.activityString=self.activityString;
    sender.timeInterval=self.timeInterval;
}

//this fuction recieve messages from iPhone
- (void)session:(nonnull WCSession *)session didReceiveMessage:(nonnull NSDictionary<NSString *,id> *)message replyHandler:(nonnull void (^)(NSDictionary<NSString *,id> * __nonnull))replyHandler {
    
    NSString *operation = [message objectForKey:@"Operation"];
    if ([operation isEqualToString:@"Start"]) {
        [self start];
        return;
    }
    
    NSString *activity = [message objectForKey:@"Activity"];
    if (activity!=nil) {
        self.activityString=activity;
        if ([self.activityString isEqualToString:@""]) {
            [self.activityButton setTitle:@"Type of Activity"];

        }else{
            [self.activityButton setTitle:self.activityString];
        }
        

        return;
    }
    
    NSString *interval = [message objectForKey:@"Interval"];
    if (interval!=nil) {
        self.timeInterval=[interval doubleValue];
        
        return;
    }
    
    NSString *intervalString = [message objectForKey:@"IntervalString"];
    if (intervalString!=nil) {
        self.intervalString=intervalString;
        
        [self.intervalButton setTitle:self.intervalString];
       
        return;
    }

    
}

@end



