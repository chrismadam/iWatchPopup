//
//  ViewController.m
//  Popuptest
//
//  Created by ship8-2 on 12/17/15.
//  Copyright © 2015 ship8-2. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

NSString *timeLabel;

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

BOOL operationBool;
BOOL recodingBool;


BOOL activityBool;
BOOL intervalBool;

NSString *ttt;

NSTimeInterval dt;
NSTimeInterval count;


@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    [self.startButton setTitle:@"Stop" forState:UIControlStateSelected];
    [self.startButton setTitle:@"Start" forState:UIControlStateNormal];
    
    AppDelegate* appDelegate=(AppDelegate*)[[UIApplication sharedApplication] delegate];
    self.managedObjectContext=appDelegate.managedObjectContext;
    

    if ([WCSession isSupported]) {
        WCSession *session = [WCSession defaultSession];
        session.delegate = self;
        [session activateSession];
    }

    
    // Configure interface objects here.
    self.activityString=@"";
    self.intervalString=@"";
    self.timeInterval=1.0;
    dt=0.01;
    count=0.0;
    operationBool=FALSE;
    recodingBool=FALSE;
    activityBool=FALSE;
    intervalBool=FALSE;
    
    
    xAccLabel=@"";yAccLabel=@"";zAccLabel=@"";
    
    xGyroLabel=@"";yGyroLabel=@"";zGyroLabel=@"";
    
    rollLabel=@"";pitchLabel=@"";yawLabel=@"";
    
    xRotLabel=@"";yRotLabel=@"";zRotLabel=@"";
    
    xGravLabel=@"";yGravLabel=@"";zGravLabel=@"";
    
    xUserAccLabel=@"";yUserAccLabel=@"";zUserAccLabel=@"";
    
    xMagLabel=@"";yMagLabel=@"";zMagLabel=@"";
    
    ttt=@"";

    //Timer start
    self.timer = [NSTimer
                  scheduledTimerWithTimeInterval: 0.01
                  target:self
                  selector:@selector(recording:)
                  userInfo:nil
                  repeats:YES];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



// design Type to Activity
- (IBAction)test:(id)sender {
    UIActionSheet *popup = [[UIActionSheet alloc] initWithTitle:@"Select Type of Activity:" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:
                            @"Sitting",
                            @"Running",
                            @"Standing",
                            @"Walking",
                            @"Sleeping",
                            @"Driving",
                            nil];
    popup.tag = 1;
    [popup showInView:[UIApplication sharedApplication].keyWindow];
}

//design Time Interval
- (IBAction)test1:(id)sender {
    UIActionSheet *popup = [[UIActionSheet alloc] initWithTitle:@"Select Time Interval:" delegate:self cancelButtonTitle:@"Cancel" destructiveButtonTitle:nil otherButtonTitles:
                            @"100 times a second",
                            @"50 times a second",
                            @"25 times a second",
                            @"10 times a second",
                            @"5 times a second",
                            @"1 times a second",
                            nil];
    popup.tag = 2;
    [popup showInView:[UIApplication sharedApplication].keyWindow];
}

- (IBAction)changedDevice:(id)sender {
    if (self.swichDevice.on==true) {
        self.deviceLabel.text=@"iWatch";
        [self stopMotionUpdates];
    }
    else{
        self.deviceLabel.text=@"iPhone";
        [self startMotionUpdates];
    }
}

//case 1:When Type of Activity cell selected ,button name change, and send Activity Type message to iWatch.
//case 2:When Time Interval cell selected, button name change and send Time Interval message to iWatch.
- (void)actionSheet:(UIActionSheet *)popup clickedButtonAtIndex:(NSInteger)buttonIndex {
    
    switch (popup.tag) {
        case 1: {
            switch (buttonIndex) {
                case 0:
                    [self.activityTypeButton setTitle:@"Sitting" forState:UIControlStateNormal];
                    [self.activityTypeButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
                    self.activityString=@"Sitting";
                    [self sendActivity];
                    break;
                case 1:
                    [self.activityTypeButton setTitle:@"Runing" forState:UIControlStateNormal];
                    [self.activityTypeButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
                    self.activityString=@"Running";
                    [self sendActivity];
                    break;
                case 2:
                    [self.activityTypeButton setTitle:@"Standing" forState:UIControlStateNormal];
                    [self.activityTypeButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
                    self.activityString=@"Standing";
                    [self sendActivity];
                    break;
                case 3:
                    [self.activityTypeButton setTitle:@"Walking" forState:UIControlStateNormal];
                    [self.activityTypeButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
                    self.activityString=@"Walking";
                    [self sendActivity];
                    break;
                case 4:
                    [self.activityTypeButton setTitle:@"Sleeping" forState:UIControlStateNormal];
                    [self.activityTypeButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
                    self.activityString=@"Sleeping";
                    [self sendActivity];
                    break;
                case 5:
                    [self.activityTypeButton setTitle:@"Driving" forState:UIControlStateNormal];
                    [self.activityTypeButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
                    self.activityString=@"Driving";
                    [self sendActivity];
                    break;

                default:
                    [self.activityTypeButton setTitle:@"Type of Activity" forState:UIControlStateNormal];
                    [self.activityTypeButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
                    self.activityString=@"";
                    [self sendActivity];
                    break;
            }
            break;
        }
        case 2: {
            switch (buttonIndex) {
                case 0:
                    [self.timeIntevalButton setTitle:@"100 times/second" forState:UIControlStateNormal];
                    [self.timeIntevalButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
                    self.timeInterval=1.0/100.0;
                    self.intervalString=@"100 times/second";
                    [self sendInterval];
                    break;
                case 1:
                    [self.timeIntevalButton setTitle:@"50 times/second" forState:UIControlStateNormal];
                    [self.timeIntevalButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
                    self.timeInterval=1.0/50.0;
                    self.intervalString=@"50 times/second";
                    [self sendInterval];
                    break;
                case 2:
                    [self.timeIntevalButton setTitle:@"25 times/second" forState:UIControlStateNormal];
                    [self.timeIntevalButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
                    self.timeInterval=1.0/25.0;
                    self.intervalString=@"25 times/second";
                    [self sendInterval];
                    break;
                case 3:
                    [self.timeIntevalButton setTitle:@"10 times/second" forState:UIControlStateNormal];
                    [self.timeIntevalButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
                    self.timeInterval=1.0/10.0;
                    self.intervalString=@"10 times/second";
                    [self sendInterval];
                    break;
                case 4:
                    [self.timeIntevalButton setTitle:@"5 times/second" forState:UIControlStateNormal];
                    [self.timeIntevalButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
                    self.timeInterval=1.0/5.0;
                    self.intervalString=@"5 times/second";
                    [self sendInterval];
                    break;
                case 5:
                    [self.timeIntevalButton setTitle:@"1 times/second" forState:UIControlStateNormal];
                    [self.timeIntevalButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
                    self.timeInterval=1.0/1.0;
                    self.intervalString=@"1 times/second";
                    [self sendInterval];
                    break;
                default:
                    [self.timeIntevalButton setTitle:@"Time Interval" forState:UIControlStateNormal];
                    [self.timeIntevalButton setTitleColor:[UIColor blueColor] forState:UIControlStateNormal];
                    self.timeInterval=1.0/1.0;
                    self.intervalString=@"Time Interval";
                    [self sendInterval];
                    break;
            }
            break;
        }

        default:
            break;
    }
}

//This function is the one that send Activity Type message to iWatch.
-(void)sendActivity{
    if (self.swichDevice.on==FALSE) {
        return;
    }
    
    NSLog(@"sendActivity");
    
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

//This function is the one that send Time Interval message to iWatch.
-(void)sendInterval{
    if (self.swichDevice.on==FALSE) {
        return;
    }
    
    NSLog(@"sendInterval");
    
    NSString *messageString;
    
    if (self.timeInterval<1.0/5.0) {
        messageString = [NSString stringWithFormat:@"%f", 1.0/5.0];
    }else{
        messageString = [NSString stringWithFormat:@"%f", self.timeInterval];
    }
    
    
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

//When start/stop button toggled, the statue of the button change and send start/stop message

- (IBAction)toggleUpdates:(id)sender {
    
    if(![self.startButton isSelected])
    {
        if (self.swichDevice.on==true){ //iwatch is selected.
            [self startUpdates];
            
        }else{                          //ihpone is selected.
            
            [self newDelegate];
            
            //[self startMotionUpdates];
            
            operationBool=TRUE;
            recodingBool=TRUE;
        }
        
        
    }
    else
    {
        if (self.swichDevice.on==true){
            [self stopUpdates];
        }else{
            //[self stopMotionUpdates];
            
            operationBool=FALSE;
        }
    }
}


//create new delegate entity among core data database and save among core data database.
-(void)newDelegate{
    //start new Recording
    NSDate * timestamp = [NSDate dateWithTimeIntervalSince1970:[[NSDate date] timeIntervalSince1970]];
    
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"YY/MM/dd HH:mm a"];
    
    NSString *newDateString = [dateFormatter stringFromDate:timestamp];
    
    NSEntityDescription *delegationEntityDescription =
    [NSEntityDescription entityForName:@"Delegations"
                inManagedObjectContext:self.managedObjectContext];
    
    Delegations *newDelegation = (Delegations *)[[NSManagedObject alloc]
                                                 initWithEntity:delegationEntityDescription
                                                 insertIntoManagedObjectContext:self.managedObjectContext];
    
    newDelegation.name=[NSString stringWithFormat:@"%@  %@",newDateString,self.activityString];
    
    NSError *error;
    if (![self.managedObjectContext save:&error])
    {
        NSLog(@"Error saving context: %@", error);
    }
    
    self.selDelegation=newDelegation;

}

//create new member entity relationshiped delegation and save among the delegation.
- (void)newRecord{
    //a new Record
    NSError *error;
    
    NSDate * timestamp1 = [NSDate dateWithTimeIntervalSince1970:[[NSDate date] timeIntervalSince1970]];
    
    NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc] init];
    [dateFormatter1 setDateFormat:@"YY/MM/dd HH:mm:ss.SSS a"];
    
    NSString *newDateString1 = [dateFormatter1 stringFromDate:timestamp1];
    
    timeLabel=newDateString1;
    
    NSEntityDescription *memberEntityDescription =
    [NSEntityDescription entityForName:@"Members"
                inManagedObjectContext:self.selDelegation.managedObjectContext];
    
    Members *newMember = (Members *)[[NSManagedObject alloc]
                                     initWithEntity:memberEntityDescription
                                     insertIntoManagedObjectContext:self.selDelegation.managedObjectContext];
    newMember.name=newDateString1;
    
    newMember.accelerx=xAccLabel;
    newMember.accelery=yAccLabel;
    newMember.accelerz=zAccLabel;
    
    newMember.gyrox=xGyroLabel;
    newMember.gyroy=yGyroLabel;
    newMember.gyroz=zGyroLabel;
    
    newMember.roll=rollLabel;
    newMember.pitch=pitchLabel;
    newMember.yaw=yawLabel;
    
    newMember.rotx=xRotLabel;
    newMember.roty=yRotLabel;
    newMember.rotz=zRotLabel;
    
    newMember.gravx=xGravLabel;
    newMember.gravy=yGravLabel;
    newMember.gravz=zGravLabel;
    
    newMember.useraccelerx=xUserAccLabel;
    newMember.useraccelery=yUserAccLabel;
    newMember.useraccelerz=zUserAccLabel;
    
    newMember.magx=xMagLabel;
    newMember.magy=yMagLabel;
    newMember.magz=zMagLabel;
    
    
    [self.selDelegation addMembersObject:newMember];
    
    if (![self.selDelegation.managedObjectContext save:&error])
    {
        NSLog(@"Error saving context: %@", error);
    }

}

//every interval of NSTimer run.
// when type of activity change, the statue of "Type of Activity" button change
//When time interval change, the statue of "Time Interval" button change.
//in iWatch mode.
//if the recording message come in from iWatch,create and save new record.
//in iPhone mode.
//create and save new record every time interval.


- (void)recording:(NSTimer *)timer{
    NSDate * timestamp1 = [NSDate dateWithTimeIntervalSince1970:[[NSDate date] timeIntervalSince1970]];
    
    NSDateFormatter *dateFormatter1 = [[NSDateFormatter alloc] init];
    [dateFormatter1 setDateFormat:@"YY/MM/dd HH:mm:ss.SSS a"];
    
    NSString *newDateString1 = [dateFormatter1 stringFromDate:timestamp1];
    
    self.timeLabel.text=newDateString1;
    
    if(operationBool==FALSE){
        [self.startButton setSelected:NO];
    }else{
        [self.startButton setSelected:YES];
    }
    
    if (activityBool==TRUE) {
        [self.activityTypeButton setTitle:self.activityString forState:UIControlStateNormal];
        [self.activityTypeButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        activityBool=FALSE;
    }
    
    if (intervalBool==TRUE) {
        [self.timeIntevalButton setTitle:ttt forState:UIControlStateNormal];
        [self.timeIntevalButton setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
        intervalBool=FALSE;
    }
    
    self.xAccLabel.text=xAccLabel;
    self.yAccLabel.text=yAccLabel;
    self.zAccLabel.text=zAccLabel;
    
    self.xGyroLabel.text=xGyroLabel;
    self.yGyroLabel.text=yGyroLabel;
    self.zGyroLabel.text=zGyroLabel;
    
    
    count+=dt;
    if (count>=self.timeInterval) {
        count=0.0;
        
        if (self.swichDevice.on==FALSE) {
            recodingBool=TRUE;
        }
    }
    
    if (operationBool==TRUE && recodingBool==TRUE) {
        [self newRecord];
        recodingBool=FALSE;
    }
    
}


//this function send start message to iWatch
- (void)startUpdates
{
    NSLog(@"startRecoding");
    
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
}

//this function send stop message to iWatch.
-(void)stopUpdates
{
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
}

//this function recieve the messages from iWatch, or start , stop, activity type, time interval, time intrval string messages
- (void)session:(nonnull WCSession *)session didReceiveMessage:(nonnull NSDictionary<NSString *,id> *)message replyHandler:(nonnull void (^)(NSDictionary<NSString *,id> * __nonnull))replyHandler {
   
    if (self.swichDevice.on==FALSE) {
        return;
    }
    
    NSString *operation = [message objectForKey:@"Operation"];
    if ([operation isEqualToString:@"Start"]) {
        //add new  Recording
        [self newDelegate];
        operationBool=TRUE;
        return;
    }else if ([operation isEqualToString:@"Stop"]) {
        operationBool=FALSE;
        return;
    }

    
    
    NSString *activity = [message objectForKey:@"Activity"];
    if (activity!=nil) {
        self.activityString=activity;
        activityBool=TRUE;
        
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
        ttt=intervalString;
        intervalBool=true;
        
        return;
    }

    
    
}

//this fuction recieve recording background transfer datas.
- (void)session:(WCSession *)session
didReceiveApplicationContext:(NSDictionary<NSString *,
                              id> *)applicationContext{
    
    if (self.swichDevice.on==FALSE) {
        return;
    }
    
    NSString *recording = [applicationContext objectForKey:@"Recording"];
    if ([recording isEqualToString:@"Recording"]) {
        recodingBool=TRUE;
        
        xAccLabel=@"";yAccLabel=@"";zAccLabel=@"";
        
        xGyroLabel=@"";yGyroLabel=@"";zGyroLabel=@"";
        
        rollLabel=@"";pitchLabel=@"";yawLabel=@"";
        
        xRotLabel=@"";yRotLabel=@"";zRotLabel=@"";
        
        xGravLabel=@"";yGravLabel=@"";zGravLabel=@"";
        
        xUserAccLabel=@"";yUserAccLabel=@"";zUserAccLabel=@"";
        
        xMagLabel=@"";yMagLabel=@"";zMagLabel=@"";
        
        xAccLabel=[applicationContext objectForKey:@"xAccLabel"];
        yAccLabel=[applicationContext objectForKey:@"yAccLabel"];
        zAccLabel=[applicationContext objectForKey:@"zAccLabel"];
        
        xGyroLabel=[applicationContext objectForKey:@"xGyroLabel"];
        yGyroLabel=[applicationContext objectForKey:@"yGyroLabel"];
        zGyroLabel=[applicationContext objectForKey:@"zGyroLabel"];
        
        rollLabel=[applicationContext objectForKey:@"rollLabel"];
        pitchLabel=[applicationContext objectForKey:@"pitchLabel"];
        yawLabel=[applicationContext objectForKey:@"yawLabel"];
        
        xRotLabel=[applicationContext objectForKey:@"xRotLabel"];
        yRotLabel=[applicationContext objectForKey:@"yRotLabel"];
        zRotLabel=[applicationContext objectForKey:@"zRotLabel"];
        
        xGravLabel=[applicationContext objectForKey:@"xGravLabel"];
        yGravLabel=[applicationContext objectForKey:@"yGravLabel"];
        zGravLabel=[applicationContext objectForKey:@"zGravLabel"];
        
        xUserAccLabel=[applicationContext objectForKey:@"xUserAccLabel"];
        yUserAccLabel=[applicationContext objectForKey:@"yUserAccLabel"];
        zUserAccLabel=[applicationContext objectForKey:@"zUserAccLabel"];
        
        xMagLabel=[applicationContext objectForKey:@"xMagLabel"];
        yMagLabel=[applicationContext objectForKey:@"yMagLabel"];
        zMagLabel=[applicationContext objectForKey:@"zMagLabel"];
    }
    
}

//this section is senser datas getting

- (CMMotionManager *)motionManager
{
    CMMotionManager *motionManager = nil;
    
    id appDelegate = [UIApplication sharedApplication].delegate;
    
    if ([appDelegate respondsToSelector:@selector(motionManager)]) {
        motionManager = [appDelegate motionManager];
    }
    
    return motionManager;
}

- (void)startMotionUpdates
{
    // Start accelerometer if available
    if ([self.motionManager isAccelerometerAvailable])
    {
        [self.motionManager setAccelerometerUpdateInterval:0.01];
        [self.motionManager startAccelerometerUpdatesToQueue:
         [[NSOperationQueue alloc] init]
                                                 withHandler:
         ^(CMAccelerometerData *data, NSError *error)
         {
             dispatch_async(dispatch_get_main_queue(), ^{
                 xAccLabel = [NSString stringWithFormat:@"%f",
                                        data.acceleration.x];
                 yAccLabel = [NSString stringWithFormat:@"%f",
                                        data.acceleration.y];
                 zAccLabel = [NSString stringWithFormat:@"%f",
                                        data.acceleration.z];
                 
                 
                 NSString *logstring=[NSString stringWithFormat:@"CMAccelerometerData=%@,%@,%@",xAccLabel,yAccLabel,zAccLabel];
                 
                 NSLog(logstring);
             });
             
         }];
        
    }
    
    // Start gyroscope if available
    if ([self.motionManager isGyroAvailable])
    {
        [self.motionManager setGyroUpdateInterval:0.01];
        [self.motionManager startGyroUpdatesToQueue:
         [[NSOperationQueue alloc] init]
                                        withHandler:
         ^(CMGyroData *data, NSError *error)
         {
             
             dispatch_async(dispatch_get_main_queue(), ^{
                 xGyroLabel = [NSString stringWithFormat:@"%f",
                                         data.rotationRate.x];
                 yGyroLabel = [NSString stringWithFormat:@"%f",
                                         data.rotationRate.y];
                 zGyroLabel = [NSString stringWithFormat:@"%f",
                                         data.rotationRate.z];
                 
                 
                 NSString *logstring=[NSString stringWithFormat:@"CMGyroData=%@,%@,%@",xGyroLabel,yGyroLabel,zGyroLabel];
                 
                 NSLog(logstring);
                 
             });
         }];
    }
    
    // Start device motion updates
    if ([self.motionManager isDeviceMotionAvailable])
    {
        //Update twice per second
        [self.motionManager setDeviceMotionUpdateInterval:0.01];
        [self.motionManager startDeviceMotionUpdatesUsingReferenceFrame:
         CMAttitudeReferenceFrameXMagneticNorthZVertical
                                                                toQueue:[[NSOperationQueue alloc] init]
                                                            withHandler:
         ^(CMDeviceMotion *deviceMotion, NSError *error)
         
         {
             dispatch_async(dispatch_get_main_queue(), ^{
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
             });
             
         }];
        
        NSString *logstring=[NSString stringWithFormat:@"CMDeviceMotion=%@,%@,%@",rollLabel,pitchLabel,yawLabel];
        
        NSLog(logstring);
    }
    
    
}

-(void)stopMotionUpdates
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


@end
