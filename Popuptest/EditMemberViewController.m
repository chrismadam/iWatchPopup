//
//  EditMemberViewController.m
//  memberMember
//
//  Created by kgh-pc on 11/16/15.
//  Copyright (c) 2015 kgh-pc. All rights reserved.
//

#import "EditMemberViewController.h"

@interface EditMemberViewController ()

@end

@implementation EditMemberViewController

- (id)initWithMember:(Members *)Member
          completion:(EditMemberViewControllerCompletionHandler)completionHandler
{
    self = [super initWithNibName:nil bundle:nil];
    if (self)
    {
        _completionHandler = completionHandler;
        _Member = Member;
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.title = @"Detail";
    
    self.timeLabel.text = _Member.name;
    
    self.xAccLabel.text = _Member.accelerx;
    self.yAccLabel.text = _Member.accelery;
    self.zAccLabel.text = _Member.accelerz;
    
    self.xGyroLabel.text = _Member.gyrox;
    self.yGyroLabel.text = _Member.gyroy;
    self.zGyroLabel.text = _Member.gyroz;
    
    
    
    self.navigationItem.leftBarButtonItem =
    [[UIBarButtonItem alloc] initWithBarButtonSystemItem:UIBarButtonSystemItemCancel
                                                  target:self action:@selector(cancel)];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

+ (void)editMember:(Members *)Member
inNavigationController:(UINavigationController *)navigationController
        completion:(EditMemberViewControllerCompletionHandler)completionHandler
{
    EditMemberViewController *editViewController =
    [[EditMemberViewController alloc] initWithMember:Member completion:completionHandler];
    [navigationController pushViewController:editViewController animated:YES];
}
- (void)cancel
{
    _completionHandler(self, YES);
}

@end
