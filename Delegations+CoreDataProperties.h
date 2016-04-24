//
//  Delegations+CoreDataProperties.h
//  Popuptest
//
//  Created by ship8-2 on 12/23/15.
//  Copyright © 2015 ship8-2. All rights reserved.
//
//  Choose "Create NSManagedObject Subclass…" from the Core Data editor menu
//  to delete and recreate this implementation file for your updated model.
//

#import "Delegations.h"

NS_ASSUME_NONNULL_BEGIN

@interface Delegations (CoreDataProperties)

@property (nullable, nonatomic, retain) NSString *name;
@property (nullable, nonatomic, retain) NSSet<Members *> *members;

@end

@interface Delegations (CoreDataGeneratedAccessors)

- (void)addMembersObject:(Members *)value;
- (void)removeMembersObject:(Members *)value;
- (void)addMembers:(NSSet<Members *> *)values;
- (void)removeMembers:(NSSet<Members *> *)values;

@end

NS_ASSUME_NONNULL_END
