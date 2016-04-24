//
//  MemberViewController.m
//  Popuptest
//
//  Created by ship8-2 on 12/18/15.
//  Copyright © 2015 ship8-2. All rights reserved.
//

#import "MemberViewController.h"

@interface MemberViewController ()

@end

@implementation MemberViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.delegate MemberViewControllerDidLoadFinish:self];
    
    self.title = self.selDelegation.name;

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.selDelegation.members.count;
}

-(NSArray *)sortedmembers {
    NSSortDescriptor *sortNameDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortNameDescriptor, nil];
    
    return [self.selDelegation.members.allObjects sortedArrayUsingDescriptors:sortDescriptors];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
    static NSString *CellIdentifier = @"Cell1";
    
    UITableViewCell *cell =
    [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil)
    {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle
                                      reuseIdentifier:CellIdentifier];
        cell.accessoryType = UITableViewCellAccessoryDisclosureIndicator;
    }
    
    //Members *member = [self.selDelegation.members.allObjects objectAtIndex:indexPath.row];
    Members *member =[[self sortedmembers] objectAtIndex:indexPath.row];
    
    cell.textLabel.text = [NSString stringWithFormat:@"%@[%@,%@,%@][%@,%@,%@]",
                           member.name,
                           member.accelerx,
                           member.accelery,
                           member.accelerz,
                           member.gyrox,
                           member.gyroy,
                           member.gyroz
                           ];
    
    
    return cell;
}

#pragma mark - Table View Delegate Methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //Members *member = [self.selDelegation.members.allObjects objectAtIndex:indexPath.row];
    Members *member =[[self sortedmembers] objectAtIndex:indexPath.row];
    
    
    [EditMemberViewController editMember:member
                  inNavigationController:self.navigationController completion:
     ^(EditMemberViewController *sender, BOOL canceled)
     {
         NSError *error;
         if (![self.selDelegation.managedObjectContext save:&error])
         {
             NSLog(@"Error saving context: %@", error);
         }
         
         [self.tableView reloadData];
         [self.navigationController popViewControllerAnimated:YES];
     }];
}


/*
 // Override to support conditional editing of the table view.
 - (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the specified item to be editable.
 return YES;
 }
 */


// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath {
    if (editingStyle == UITableViewCellEditingStyleDelete)
    {
        //Members *member = [self.selDelegation.members.allObjects objectAtIndex:indexPath.row];
        Members *member =[[self sortedmembers] objectAtIndex:indexPath.row];
        
        [self.selDelegation.managedObjectContext deleteObject:member];
        NSError *error;
        BOOL success = [self.selDelegation.managedObjectContext save:&error];
        if (!success)
        {
            NSLog(@"Error saving context: %@", error);
        }
        [self.tableView deleteRowsAtIndexPaths:@[indexPath]
                              withRowAnimation:UITableViewRowAnimationRight];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
}

@end
