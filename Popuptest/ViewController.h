//
//  ViewController.h
//  Popuptest
//
//  Created by ship8-2 on 12/17/15.
//  Copyright © 2015 ship8-2. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <WatchConnectivity/WatchConnectivity.h>

#import "Members.h"
#import "Delegations.h"
#import "AppDelegate.h"


@interface ViewController : UIViewController<UIActionSheetDelegate,WCSessionDelegate>

@property (weak, nonatomic) IBOutlet UIButton *activityTypeButton;
@property (weak, nonatomic) IBOutlet UIButton *timeIntevalButton;
@property (weak, nonatomic) IBOutlet UIButton *startButton;
@property (weak, nonatomic) IBOutlet UISwitch *swichDevice;

@property (weak, nonatomic) IBOutlet UILabel *deviceLabel;

@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (weak, nonatomic) IBOutlet UILabel *xAccLabel;
@property (weak, nonatomic) IBOutlet UILabel *yAccLabel;
@property (weak, nonatomic) IBOutlet UILabel *zAccLabel;

@property (weak, nonatomic) IBOutlet UILabel *xGyroLabel;
@property (weak, nonatomic) IBOutlet UILabel *yGyroLabel;
@property (weak, nonatomic) IBOutlet UILabel *zGyroLabel;






@property (strong,nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;

@property (weak, nonatomic) NSString *activityString;//
@property (nonatomic) NSTimeInterval timeInterval;//
@property (weak, nonatomic) NSString *intervalString;//

@property (nonatomic, retain) NSTimer *timer;//

@property (strong, nonatomic) Delegations* selDelegation;

- (IBAction)test:(id)sender;
- (IBAction)test1:(id)sender;
- (IBAction)changedDevice:(id)sender;


@end

