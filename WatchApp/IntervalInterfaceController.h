//
//  IntervalInterfaceController.h
//  Popuptest
//
//  Created by ship8-2 on 12/22/15.
//  Copyright © 2015 ship8-2. All rights reserved.
//

#import <WatchKit/WatchKit.h>
#import <Foundation/Foundation.h>

@class IntervalInterfaceController;

@protocol IntervalInterfaceControllerDelegate<NSObject>

-(void)IntervalDidSelect:(IntervalInterfaceController*)sender;

@end


@interface IntervalInterfaceController : WKInterfaceController

@property (nonatomic) NSTimeInterval timeInterval;//
@property (strong, nonatomic) NSString *timeIntervalString;

@property (strong, nonatomic) id<IntervalInterfaceControllerDelegate> delegate;

- (IBAction)times100Button;
- (IBAction)times50Button;
- (IBAction)times25Button;
- (IBAction)times10Button;
- (IBAction)times5Button;
- (IBAction)times1Button;

@end
