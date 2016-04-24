//
//  DelegationViewController.m
//  Popuptest
//
//  Created by ship8-2 on 12/18/15.
//  Copyright © 2015 ship8-2. All rights reserved.
//

#import "DelegationViewController.h"

@interface DelegationViewController ()

@end

@implementation DelegationViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    AppDelegate* appDelegate=(AppDelegate*)[[UIApplication sharedApplication] delegate];
    
    self.managedObjectContext=appDelegate.managedObjectContext;
    
    self.title = NSLocalizedString(@"LIST OF RECODING", @"LIST OF RECODING");
    
    //initialize indexPath Array.
    self.indexPathArray=[[NSMutableArray alloc]init];
 }

- (void)viewWillAppear:(BOOL)animated
{
    [self fetchDelegation];
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)fetchDelegation
{
    NSFetchRequest *fetchRequest =
    [NSFetchRequest fetchRequestWithEntityName:@"Delegations"];
    
    NSString *cacheName = [@"Delegations" stringByAppendingString:@"Cache"];
    
    NSSortDescriptor *sortDescriptor =
    [NSSortDescriptor sortDescriptorWithKey:@"name" ascending:YES];
    
    
    [fetchRequest setSortDescriptors:@[sortDescriptor]];
    
    self.fetchedResultsController = [[NSFetchedResultsController alloc]
                                     initWithFetchRequest:fetchRequest managedObjectContext:self.managedObjectContext
                                     sectionNameKeyPath:nil cacheName:cacheName];
    NSError *error;
    if (![self.fetchedResultsController performFetch:&error])
    {
        NSLog(@"Fetch failed: %@", error);
    }
}


#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.fetchedResultsController.fetchedObjects.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    [self.indexPathArray addObject:indexPath];
    
    NSInteger ccc=self.indexPathArray.count;
    
    static NSString *CellIdentifier = @"Cell";
    
    UITableViewCell *cell = [tableView
                             dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[UITableViewCell alloc]
                initWithStyle:UITableViewCellStyleValue1
                reuseIdentifier:CellIdentifier] ;
        cell.accessoryType=UITableViewCellAccessoryDetailButton;
        
    }
    
    // Configure the cell.
    // Get the Product object
    Delegations *delegation = (Delegations *)[self.fetchedResultsController
                                              objectAtIndexPath:indexPath];
    NSUInteger* count=delegation.members.count;
    NSString * points=[NSString stringWithFormat:@"%u",count];
    
    cell.textLabel.text=[NSString stringWithFormat:@"%ld  %@ %@",(long)indexPath.row+1,delegation.name,points];
    
    
    
    //delegation.number=[[NSDecimalNumber alloc] initWithUnsignedInteger:count];
    
    // add friend button
    UIButton *addSendButton = [UIButton buttonWithType:UIButtonTypeRoundedRect];
    addSendButton.frame = CGRectMake(230.0f, 2.0f, 75.0f, 30.0f);
    [addSendButton setTitle:@"Send" forState:UIControlStateNormal];
    addSendButton.tag = indexPath.row;
    
    [addSendButton addTarget:self
                      action:@selector(sendButtonClicked:)
            forControlEvents:UIControlEventTouchUpInside];
    
    [cell addSubview:addSendButton];
    return cell;
}

-(NSArray *)sortedmembers {
    NSSortDescriptor *sortNameDescriptor = [[NSSortDescriptor alloc] initWithKey:@"name" ascending:YES];
    NSArray *sortDescriptors = [[NSArray alloc] initWithObjects:sortNameDescriptor, nil];
    
    return [self.selDelegation.members.allObjects sortedArrayUsingDescriptors:sortDescriptors];
}

//this fuction send a message  with csv file when "send" button is pressed
-(void)sendButtonClicked:(UIButton*)sender
{
    if (sender.tag == 0)
    {
        // Your code here
    }
    
    NSIndexPath *indexPath=[self.indexPathArray objectAtIndex:sender.tag];
    
    self.selDelegation = (Delegations *)[self.fetchedResultsController
                                         objectAtIndexPath:indexPath];
    
    NSUInteger* count=self.selDelegation.members.count;
    
    NSMutableString *csvString = [[NSMutableString alloc] init];
    [csvString appendString:@"Timestamp,AccelerX,AccelerY,AccelerZ,GyroX, GyroY,GyroZ"];
    
    for (int i = 0; i < count; i++){
        //Members *member = [self.selDelegation.members.allObjects objectAtIndex:indexPath.row];
        Members *member =[[self sortedmembers] objectAtIndex:i];

        [csvString appendString: [NSString stringWithFormat:@"\n%@,%@,%@,%@,%@,%@,%@",
                                  member.name,
                                  member.accelerx,
                                  member.accelery,
                                  member.accelerz,
                                  member.gyrox,
                                  member.gyroy,
                                  member.gyroz
                                  ]];
        
    }
    
    NSLog(@"%@",csvString);
    
    if ([MFMailComposeViewController canSendMail])
    {
        MFMailComposeViewController *mailVC =[[MFMailComposeViewController alloc] init];
        mailVC.mailComposeDelegate = self;
        
        [mailVC setSubject:@"Send iWatch/iPhone PositionData Out"];
        [mailVC setToRecipients:@[@"shashikots@gmail.com"]];
        
        [mailVC setMessageBody:@"Format-CSV file" isHTML:NO];
        
        NSData *myData =[csvString dataUsingEncoding:NSUTF8StringEncoding];
        
        //NSLog(@"%@",myData);
        
        [mailVC addAttachmentData:myData mimeType:@"text/csv" fileName:@"iWatch/iPhonePositionData"];
        
        [self presentViewController:mailVC animated:YES completion:nil];
        
    } else {
        NSLog(@"E-mailing Unavailable");
    }
    
}

-(void)mailComposeController:(MFMailComposeViewController *)controller
         didFinishWithResult:(MFMailComposeResult)result error:(NSError *)error
{
    if (result == MFMailComposeResultSent)
        NSLog(@"Mail sent.");
    else if (result == MFMailComposeResultCancelled)
        NSLog(@"Mail Cancelled");
    else if (result == MFMailComposeResultFailed)
        NSLog(@"Error, Mail Send Failed");
    else if (result == MFMailComposeResultSaved)
        NSLog(@"Mail Saved");
    [self dismissViewControllerAnimated:YES completion:nil];
}


#pragma mark - Table View Delegate Methods

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    self.selDelegation = (Delegations *)[self.fetchedResultsController
                                         objectAtIndexPath:indexPath];
    
}

-(void)MemberViewControllerDidLoadFinish:(MemberViewController*)sender
{
    sender.selDelegation=self.selDelegation;
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
        Delegations *delegation = (Delegations *)[self.fetchedResultsController
                                                  objectAtIndexPath:indexPath];
        [self.managedObjectContext deleteObject:delegation];
        
        NSError *error;
        if (![self.managedObjectContext save:&error])
        {
            NSLog(@"Error saving context: %@", error);
        }

        [self fetchDelegation];
        [self.tableView reloadData];
    } else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }
}


/*
 // Override to support rearranging the table view.
 - (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath {
 }
 */

/*
 // Override to support conditional rearranging of the table view.
 - (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath {
 // Return NO if you do not want the item to be re-orderable.
 return YES;
 }
 */


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    MemberViewController* memberViewController=segue.destinationViewController;
    memberViewController.delegate=self;
}


@end
