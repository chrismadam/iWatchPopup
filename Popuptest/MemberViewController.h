//
//  MemberViewController.h
//  Popuptest
//
//  Created by ship8-2 on 12/18/15.
//  Copyright © 2015 ship8-2. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Delegations.h"
#import "Members.h"
#import "EditMemberViewController.h"


@class MemberViewController;

@protocol MemberViewControllerDelegate<NSObject>

-(void)MemberViewControllerDidLoadFinish:(MemberViewController*)sender;

@end

@interface MemberViewController : UIViewController

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property (strong, nonatomic) Delegations *selDelegation;

@property (strong, nonatomic) id<MemberViewControllerDelegate> delegate;

@end
