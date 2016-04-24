//
//  EditMemberViewController.h
//  DelegationMember
//
//  Created by kgh-pc on 11/16/15.
//  Copyright (c) 2015 kgh-pc. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Members.h"

@class EditMemberViewController;

typedef void (^EditMemberViewControllerCompletionHandler)(EditMemberViewController *sender, BOOL canceled);

@interface EditMemberViewController : UIViewController<UINavigationControllerDelegate,
UIPopoverControllerDelegate>
{
@private
    EditMemberViewControllerCompletionHandler _completionHandler;
    Members *_Member;
}


@property (weak, nonatomic) IBOutlet UILabel *timeLabel;

@property (weak, nonatomic) IBOutlet UILabel *xAccLabel;
@property (weak, nonatomic) IBOutlet UILabel *yAccLabel;
@property (weak, nonatomic) IBOutlet UILabel *zAccLabel;

@property (weak, nonatomic) IBOutlet UILabel *xGyroLabel;
@property (weak, nonatomic) IBOutlet UILabel *yGyroLabel;
@property (weak, nonatomic) IBOutlet UILabel *zGyroLabel;



- (id)initWithMember:(Members *)Member
              completion:(EditMemberViewControllerCompletionHandler)completionHandler;

+ (void)editMember:(Members *)Member
inNavigationController:(UINavigationController *)navigationController
            completion:(EditMemberViewControllerCompletionHandler)completionHandler;
@end
