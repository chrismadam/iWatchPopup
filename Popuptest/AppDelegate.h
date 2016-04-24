//
//  AppDelegate.h
//  Popuptest
//
//  Created by ship8-2 on 12/17/15.
//  Copyright © 2015 ship8-2. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import <CoreMotion/CoreMotion.h>


@interface AppDelegate : UIResponder <UIApplicationDelegate>{
    CMMotionManager *motionManager;
}

@property (strong, nonatomic) UIWindow *window;

@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@property (readonly) CMMotionManager *motionManager;//only one in a project.

@end

