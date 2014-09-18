//
//  LPLogsTableViewController.m
//  LocalpointTester_iOS
//
//  Created by Jason Schmitt on 2/13/14.
//  Copyright (c) 2014 Jason Schmitt. All rights reserved.
//

#import <Localpoint/Localpoint.h>
#import "LPLogsTableViewController.h"
#import "LPLoggingManager.h"
#import "LogsTableCell.h"
#import "LPConfiguration.h"

@interface LPLogsTableViewController ()

@end

@implementation LPLogsTableViewController
{
    NSArray *logFileLines;
}

- (BOOL)shouldAutorotate
{
    return YES;
}

- (NSUInteger)supportedInterfaceOrientations
{
    return (UIInterfaceOrientationLandscapeLeft | UIInterfaceOrientationLandscapeRight | UIInterfaceOrientationPortrait);
}

- (UIInterfaceOrientation)preferredInterfaceOrientationForPresentation
{
    return UIInterfaceOrientationLandscapeRight;
}

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
    
    // Add the compose button to the "more" navigation controller if it's there
    UIBarButtonItem *btnSendLogs = [[UIBarButtonItem alloc]initWithBarButtonSystemItem:UIBarButtonSystemItemCompose target:self action:@selector(btnSendLogsPressed:)];
    if (self.tabBarController.moreNavigationController)
    {
        [LPLoggingManager logExternal:@"We have a 'more' navigation controller"];
        self.tabBarController.moreNavigationController.topViewController.navigationItem.rightBarButtonItem = btnSendLogs;
    }
}

- (void)viewWillAppear:(BOOL)animated
{
    //get file path to log file
    NSString *filePath = [LPLoggingManager logFilePath];
    
    NSString *fileContents = [NSString stringWithContentsOfFile:filePath encoding:NSUTF8StringEncoding error:nil];
    logFileLines = [fileContents componentsSeparatedByCharactersInSet:[NSCharacterSet newlineCharacterSet]];
    
    [self.tableView reloadData];
    
    [self scrollToBottom];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)scrollToBottom
{
    NSIndexPath* ipath = [NSIndexPath indexPathForRow: [self.tableView numberOfRowsInSection:0]-1 inSection: 0];
    [self.tableView scrollToRowAtIndexPath: ipath atScrollPosition: UITableViewScrollPositionTop animated: YES];
}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    // Return the number of sections.
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if (section == 0) {
        return [logFileLines count];
    } else {
        return 0;
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"LogsTableCell";
    LogsTableCell *cell = [tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[LogsTableCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    cell.logLine.font = [UIFont fontWithName:@"Helvetica" size:10.0];
    // These lines only seem to cut off the text that doesn't fit rather than wrapping the text as expected. Leaving here as a reminder to try this again at some point.
//    cell.logLine.lineBreakMode = NSLineBreakByWordWrapping;
//    cell.logLine.numberOfLines = 0;
    cell.logLine.autoresizingMask = UIViewAutoresizingFlexibleWidth;
    cell.logLine.text = [logFileLines objectAtIndex:indexPath.row];
    
    return cell;
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

/*
#pragma mark - Navigation

// In a story board-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}

 */

#pragma Mark Sending Logs helper methods

// React to compose button pressed
- (IBAction)btnSendLogsPressed:(UIButton *)sender
{
    if ([MFMailComposeViewController canSendMail]) {
        MFMailComposeViewController *composeViewController = [[MFMailComposeViewController alloc] initWithNibName:nil bundle:nil];
        [composeViewController setMailComposeDelegate:self];
        [composeViewController setSubject:@"iOS Tester app log files for review"];
        LPConfiguration *config = [LPConfiguration instance];
        [composeViewController setMessageBody:[self logFileEmailHTMLWith:config] isHTML:YES];
        [self addFileAttachmentsToMailComposeViewController:composeViewController withConfig:config];
        [self presentViewController:composeViewController animated:YES completion:nil];
    } else {
        [LPLoggingManager logExternal:@"Unable to send email."];
    }
}

- (NSString *) logFileEmailHTMLWith:(LPConfiguration *) config {
    LPLocalpointService *lpService = [LPLocalpointService instance];
    NSMutableString *body = [[NSMutableString alloc] init];
    [body appendFormat:@"<p>Please review the attached log files.</p>"];
    [body appendFormat:@"<h3>Tester app details:</h3>"];
    [body appendFormat:@"<p>Brand: <b>%@</b><br>", [config brand]];
    [body appendFormat:@"Server environment: <b>%@</b><br>", [config server]];
    [body appendFormat:@"App version: <b>%@</b><br>", [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString*)kCFBundleVersionKey]];
    [body appendFormat:@"SDK version: <b>%@</b><br>", [[lpService getSDKVersion] description]];
    [body appendFormat:@"Device ID: <b>%@</b><br>", [[[lpService getDevice] getID] getValue]];
    [body appendFormat:@"iOS Version: <b>%@</b></p>", [UIDevice currentDevice].systemVersion];
    return [NSString stringWithString:body];
}

// Attach all log files to the given MFMailComposeViewController
- (void) addFileAttachmentsToMailComposeViewController: (MFMailComposeViewController *)mc withConfig: (LPConfiguration *) config
{
    NSString *baseFilePath = [LPLoggingManager logFilePath];
    [mc addAttachmentData:[NSData dataWithContentsOfFile:baseFilePath] mimeType:@"text/plain" fileName:[NSString stringWithFormat:@"localpoint_%@.log", [config brand]]];
    NSString *rolledFilePath = [baseFilePath stringByReplacingOccurrencesOfString:@".log" withString:@"1.log"];
    if ([[NSFileManager defaultManager] fileExistsAtPath:rolledFilePath]) {
        [mc addAttachmentData:[NSData dataWithContentsOfFile:rolledFilePath] mimeType:@"text/plain" fileName:[NSString stringWithFormat:@"localpoint_%@1.log", [config brand]]];
    }
}

// Process a finished compose window
- (void)mailComposeController:(MFMailComposeViewController *)controller didFinishWithResult:(MFMailComposeResult)result error:(NSError*)error
{
    switch (result)
    {
        case MFMailComposeResultCancelled:
            [LPLoggingManager logExternal:@"Mail cancelled"];
            break;
        case MFMailComposeResultSaved:
            [LPLoggingManager logExternal:@"Mail saved"];
            break;
        case MFMailComposeResultSent:
            [LPLoggingManager logExternal:@"Mail sent"];
            break;
        case MFMailComposeResultFailed:
            [LPLoggingManager logExternal:@"Mail sent failure: %@", [error localizedDescription]];
            break;
        default:
            break;
    }
    
    //Add an alert in case of failure
    [self dismissViewControllerAnimated:YES completion:nil];
}

@end
