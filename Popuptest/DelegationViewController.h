//
//  DelegationViewController.h
//  Popuptest
//
//  Created by ship8-2 on 12/18/15.
//  Copyright © 2015 ship8-2. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Members.h"
#import "Delegations.h"
#import "AppDelegate.h"

#import "MemberViewController.h"
#import "SendDataViewController.h"

#import <QuartzCore/QuartzCore.h>
#import <MessageUI/MessageUI.h>

@interface DelegationViewController : UIViewController<MemberViewControllerDelegate,UITableViewDelegate,MFMailComposeViewControllerDelegate>

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (nonatomic) NSMutableArray *indexPathArray;

@property (strong,nonatomic) NSManagedObjectContext *managedObjectContext;
@property (strong, nonatomic) NSFetchedResultsController *fetchedResultsController;

@property (strong, nonatomic) Delegations* selDelegation;

@end
