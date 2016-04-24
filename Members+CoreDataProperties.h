//
//  Members+CoreDataProperties.h
//  Popuptest
//
//  Created by ship8-2 on 12/23/15.
//  Copyright © 2015 ship8-2. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Members.h"

NS_ASSUME_NONNULL_BEGIN

@interface Members (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *accelerx;
@property (nullable, nonatomic, retain) NSString *accelery;
@property (nullable, nonatomic, retain) NSString *accelerz;
@property (nullable, nonatomic, retain) NSString *gyrox;
@property (nullable, nonatomic, retain) NSString *gyroy;
@property (nullable, nonatomic, retain) NSString *gyroz;
@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSString *pitch;
@property (nullable, nonatomic, retain) NSString *roll;
@property (nullable, nonatomic, retain) NSString *yaw;
@property (nullable, nonatomic, retain) NSString *rotx;
@property (nullable, nonatomic, retain) NSString *roty;
@property (nullable, nonatomic, retain) NSString *rotz;
@property (nullable, nonatomic, retain) NSString *gravx;
@property (nullable, nonatomic, retain) NSString *gravy;
@property (nullable, nonatomic, retain) NSString *gravz;
@property (nullable, nonatomic, retain) NSString *useraccelerx;
@property (nullable, nonatomic, retain) NSString *useraccelery;
@property (nullable, nonatomic, retain) NSString *useraccelerz;
@property (nullable, nonatomic, retain) NSString *magx;
@property (nullable, nonatomic, retain) NSString *magy;
@property (nullable, nonatomic, retain) NSString *magz;
@property (nullable, nonatomic, retain) NSManagedObject *delegation;

@end

NS_ASSUME_NONNULL_END
