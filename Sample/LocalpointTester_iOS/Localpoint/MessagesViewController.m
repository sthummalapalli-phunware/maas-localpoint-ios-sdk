//
//  MessagesViewController.m
//  LocalpointTester_iOS
//
//  Created by Jason Schmitt on 2/19/13.
//  Copyright (c) 2013 Jason Schmitt. All rights reserved.
//

#import <Localpoint/Localpoint.h>
#import "MessagesViewController.h"
#import "MessageCell.h"
#import "PromotionViewController.h"

@interface MessagesViewController ()

@end

@implementation MessagesViewController
@synthesize messages;
@synthesize validMessages;
@synthesize expiredMessages;
@synthesize promoViewer;

- (id)initWithStyle:(UITableViewStyle)style
{
    self = [super initWithStyle:style];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    promoViewer = [[PromotionViewController alloc] init];

    // Uncomment the following line to preserve selection between presentations.
    // self.clearsSelectionOnViewWillAppear = NO;
 
    // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
    // self.navigationItem.rightBarButtonItem = self.editButtonItem;
}

- (void)viewWillAppear:(BOOL)animated {
    self.navigationController.navigationBar.hidden = YES;
    
    id<ILPMessageProvider> mp = [[LPLocalpointService instance] getMessageProvider];
    messages = [mp getMessages];
    id<ILPFilter> validFilter = [[mp getFilterFactory] getValidFilter];
    validMessages = [mp getMessages:validFilter withOrdering:nil];
    id<ILPFilter> expiredFilter = [[mp getFilterFactory] getExpiredFilter];
    expiredMessages = [mp getMessages:expiredFilter withOrdering:nil];
        
    [self.tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 2;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if (section == 0) {
        return [validMessages count];
    } else if (section == 1) {
        return [expiredMessages count];
    }
    return [messages count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"MessageCell";
    id<ILPMessage> msg = nil;
    if (indexPath.section == 0) {
        msg = [validMessages objectAtIndex:indexPath.row];
    } else if(indexPath.section == 1) {
        msg = [expiredMessages objectAtIndex:indexPath.row];
    } else {
        msg = [messages objectAtIndex:indexPath.row];
    }
    MessageCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    cell.messageTitle.text = [msg getTitle];
    if ([msg isRead]) {
        cell.messageTitle.font = [UIFont systemFontOfSize:16.0f];
    } else {
        cell.messageTitle.font = [UIFont boldSystemFontOfSize:16.0f];
    }
    
    // Configure the cell...
    
    return cell;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section {
    if (section == 0) return @"Valid offers";
    if (section == 1) return @"Expired offers";
    return @"Unexpected section";
}

/*
// Override to support conditional editing of the table view.
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return YES;
}
*/

/*
// Override to support editing the table view.
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        // Delete the row from the data source
        [tableView deleteRowsAtIndexPaths:@[indexPath] withRowAnimation:UITableViewRowAnimationFade];
    }   
    else if (editingStyle == UITableViewCellEditingStyleInsert) {
        // Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
    }   
}
*/

/*
// Override to support rearranging the table view.
- (void)tableView:(UITableView *)tableView moveRowAtIndexPath:(NSIndexPath *)fromIndexPath toIndexPath:(NSIndexPath *)toIndexPath
{
}
*/

/*
// Override to support conditional rearranging of the table view.
- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the item to be re-orderable.
    return YES;
}
*/

#pragma mark - Table view delegate

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSLog(@"Selected a message");
}

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"showPromoSegue"]){
        PromotionViewController *promoController = (PromotionViewController *)segue.destinationViewController;
        NSIndexPath *ip = [self.tableView indexPathForSelectedRow];
        if (ip.section == 0) {
            promoController.message = [validMessages objectAtIndex:ip.row];
        } else if (ip.section == 1) {
            promoController.message = [expiredMessages objectAtIndex:ip.row];
        } else {
            promoController.message = [messages objectAtIndex:ip.row];
        }
        promoController.title = [promoController.message getTitle];
    }
}

- (void)resetViews {
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end
