//
//  RecordingInterfaceController.m
//  Popuptest
//
//  Created by ship8-2 on 12/22/15.
//  Copyright © 2015 ship8-2. All rights reserved.
//

#import "RecordingInterfaceController.h"


@interface RecordingInterfaceController ()

@end

NSString *xAccLabel;
NSString *yAccLabel;
NSString *zAccLabel;

NSString *xGyroLabel;
NSString *yGyroLabel;
NSString *zGyroLabel;

NSString *rollLabel;
NSString *pitchLabel;
NSString *yawLabel;

NSString *xRotLabel;
NSString *yRotLabel;
NSString *zRotLabel;

NSString *xGravLabel;
NSString *yGravLabel;
NSString *zGravLabel;

NSString *xUserAccLabel;
NSString *yUserAccLabel;
NSString *zUserAccLabel;

NSString *xMagLabel;
NSString *yMagLabel;
NSString *zMagLabel;



@implementation RecordingInterfaceController

- (void)awakeWithContext:(id)context {
    [super awakeWithContext:context];
    
    self.delegate=context;
    // Configure interface objects here.
    [self.delegate RecordingInterfaceControllerDidLoad:self];
    
    //recoding data initialize
    xAccLabel=@"0.0";
    yAccLabel=@"0.0";
    zAccLabel=@"0.0";
    
    xGyroLabel=@"0.0";
    yGyroLabel=@"0.0";
    zGyroLabel=@"0.0";
    
    rollLabel=@"0.0";
    pitchLabel=@"0.0";
    yawLabel=@"0.0";
    
    xRotLabel=@"0.0";
    yRotLabel=@"0.0";
    zRotLabel=@"0.0";
    
    xGravLabel=@"0.0";
    yGravLabel=@"0.0";
    zGravLabel=@"0.0";
    
    xUserAccLabel=@"0.0";
    yUserAccLabel=@"0.0";
    zUserAccLabel=@"0.0";
    
    xMagLabel=@"0.0";
    yMagLabel=@"0.0";
    zMagLabel=@"0.0";
    
    [self.activityLabel setText:self.activityString];
    [self.recodingTimer start];

    
}

- (void)willActivate {
    // This method is called when watch view controller is about to be visible to user
    [super willActivate];
    
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
                  scheduledTimerWithTimeInterval: self.timeInterval
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

//this fuction send recording data in real time
- (void)recording:(NSTimer *)timer{
    
    NSLog(@"recording");
    

    NSMutableDictionary *applicationData = [[NSMutableDictionary alloc] init];
    
    [applicationData setObject:@"Recording" forKey:@"Recording"];

    [applicationData setObject:xAccLabel forKey:@"xAccLabel"];
    [applicationData setObject:yAccLabel forKey:@"yAccLabel"];
    [applicationData setObject:zAccLabel forKey:@"zAccLabel"];
    
    [applicationData setObject:xGyroLabel forKey:@"xGyroLabel"];
    [applicationData setObject:yGyroLabel forKey:@"yGyroLabel"];
    [applicationData setObject:zGyroLabel forKey:@"zGyroLabel"];
    
    [applicationData setObject:rollLabel forKey:@"rollLabel"];
    [applicationData setObject:pitchLabel forKey:@"pitchLabel"];
    [applicationData setObject:yawLabel forKey:@"yawLabel"];
    
    [applicationData setObject:xRotLabel forKey:@"xRotLabel"];
    [applicationData setObject:yRotLabel forKey:@"yRotLabel"];
    [applicationData setObject:zRotLabel forKey:@"zRotLabel"];
    
    [applicationData setObject:xGravLabel forKey:@"xGravLabel"];
    [applicationData setObject:yGravLabel forKey:@"yGravLabel"];
    [applicationData setObject:zGravLabel forKey:@"zGravLabel"];
    
    [applicationData setObject:xUserAccLabel forKey:@"xUserAccLabel"];
    [applicationData setObject:yUserAccLabel forKey:@"yUserAccLabel"];
    [applicationData setObject:zUserAccLabel forKey:@"zUserAccLabel"];
    
    [applicationData setObject:xMagLabel forKey:@"xMagLabel"];
    [applicationData setObject:yMagLabel forKey:@"yMagLabel"];
    [applicationData setObject:zMagLabel forKey:@"zMagLabel"];
    

    [[WCSession defaultSession] updateApplicationContext:applicationData error:nil];
    
}

//this fuction recieve stop message to iPhone.
- (void)session:(nonnull WCSession *)session didReceiveMessage:(nonnull NSDictionary<NSString *,id> *)message replyHandler:(nonnull void (^)(NSDictionary<NSString *,id> * __nonnull))replyHandler {
    NSString *operation = [message objectForKey:@"Operation"];
    if ([operation isEqualToString:@"Stop"]) {
        [self stop];
        return;
    }
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
             xAccLabel = [NSString stringWithFormat:@"%f",
                                    data.acceleration.x];
             yAccLabel = [NSString stringWithFormat:@"%f",
                                    data.acceleration.y];
             zAccLabel = [NSString stringWithFormat:@"%f",
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
             xGyroLabel = [NSString stringWithFormat:@"%f",
                                     data.rotationRate.x];
             yGyroLabel = [NSString stringWithFormat:@"%f",
                                     data.rotationRate.y];
             zGyroLabel = [NSString stringWithFormat:@"%f",
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
             rollLabel =  [NSString stringWithFormat:@"%f",
                                     deviceMotion.attitude.roll];
             pitchLabel = [NSString stringWithFormat:@"%f",
                                     deviceMotion.attitude.pitch];
             yawLabel =   [NSString stringWithFormat:@"%f",
                                     deviceMotion.attitude.yaw];
             
             // Update rotation rate labels
             xRotLabel = [NSString stringWithFormat:@"%f",
                                    deviceMotion.rotationRate.x];
             yRotLabel = [NSString stringWithFormat:@"%f",
                                    deviceMotion.rotationRate.y];
             zRotLabel = [NSString stringWithFormat:@"%f",
                                    deviceMotion.rotationRate.z];
             
             // Update user acceleration labels
             xGravLabel = [NSString stringWithFormat:@"%f",
                                     deviceMotion.gravity.x];
             yGravLabel = [NSString stringWithFormat:@"%f",
                                     deviceMotion.gravity.y];
             zGravLabel = [NSString stringWithFormat:@"%f",
                                     deviceMotion.gravity.z];
             
             // Update user acceleration labels
             xUserAccLabel = [NSString stringWithFormat:@"%f",
                                    deviceMotion.userAcceleration.x];
             yUserAccLabel = [NSString stringWithFormat:@"%f",
                                    deviceMotion.userAcceleration.y];
             zUserAccLabel = [NSString stringWithFormat:@"%f",
                                    deviceMotion.userAcceleration.z];
             
             // Update magnetic field labels
             xMagLabel = [NSString stringWithFormat:@"%f",
                                    deviceMotion.magneticField.field.x];
             yMagLabel = [NSString stringWithFormat:@"%f",
                                    deviceMotion.magneticField.field.y];
             zMagLabel = [NSString stringWithFormat:@"%f",
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



- (IBAction)stopButton {
    [self stop];
}

//when stop button press, send stop message to iPhene.
-(void)stop{
    NSLog(@"stopRecoding");
    
    NSString *messageString = [NSString stringWithFormat:@"%@", @"Stop"];
    NSDictionary *applicationData = [[NSDictionary alloc] initWithObjects:@[messageString] forKeys:@[@"Operation"]];
    
    [[WCSession defaultSession] sendMessage:applicationData
                               replyHandler:^(NSDictionary *reply) {
                                   //handle reply from iPhone app here
                               }
                               errorHandler:^(NSError *error) {
                                   //catch any errors here
                               }
     ];
    
    //Timer Stop
    if ([self.timer isValid]) {
        [self.timer invalidate];
    }
    self.timer = nil;
    
    [self stopUpdates];
    
    [self.recodingTimer stop];
    
    [self dismissController];

}


@end



