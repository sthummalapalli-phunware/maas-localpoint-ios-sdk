//
//  CheckInViewController.m
//  LocalpointTester_iOS
//
//  Created by Jason Schmitt on 2/19/13.
//  Copyright (c) 2013 Jason Schmitt. All rights reserved.
//


#import <Localpoint/Localpoint.h>
#import "CheckInViewController.h"
#import "LocationViewController.h"
#import "LocationCell.h"
#import "iToast.h"
#import "LocationFilterAggregator.h"

@interface CheckInViewController ()

@end

@implementation CheckInViewController {
    @private
    LocationFilterAggregator *locationFilter;
}
@synthesize locations;
@synthesize filteredLocations;
@synthesize locationSearchBar;

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
    
    //locations = [[[LPLocalpointService instance] getLocationProvider] getLocations];
    //self.filteredLocations = [NSMutableArray arrayWithCapacity:[locations count]];
    
    //[locationSearchBar setShowsScopeBar:NO];
    //[locationSearchBar sizeToFit];
    
    // Hide the search bar until user scrolls up
    /*
    CGRect newBounds = self.tableView.bounds;
    newBounds.origin.y = newBounds.origin.y + locationSearchBar.bounds.size.height;
    self.tableView.bounds = newBounds;
     */
    
    //[self.tableView reloadData];
}

- (void)searchDisplayController:(UISearchDisplayController *)controller didLoadSearchResultsTableView:(UITableView *)tableView {
    tableView.rowHeight = 57.5f; // or some other height
}

#pragma mark - Refresh the list each time we navigate to the view
- (void)viewWillAppear:(BOOL)animated {
    [self refreshLocationFilter];
    LPLocalpointService *lpService = [LPLocalpointService instance];
    id<ILPOrdering> proximityOrder = [[[lpService getLocationProvider] getOrderingFactory] getAscendingDistanceOrdering];
    locations = [[lpService getLocationProvider] getLocations:locationFilter withOrdering:proximityOrder];
    
    [self.tableView reloadData];
}

- (void)refreshLocationFilter {
    locationFilter = [[LocationFilterAggregator alloc] init];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - Table view data source
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    // Return the number of rows in the section.
    if (filteredLocations) {
        return [filteredLocations count];
    } else {
        return [locations count];
    }
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *CellIdentifier = @"LocationCheckInCell";
    LocationCell *cell = [self.tableView dequeueReusableCellWithIdentifier:CellIdentifier];
    if (cell == nil) {
        cell = [[LocationCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:CellIdentifier];
    }
    id<ILPLocation> location = nil;
    if (filteredLocations) {
        location = [filteredLocations objectAtIndex:[indexPath row]];
    } else {
        location = [locations objectAtIndex:[indexPath row]];
    }
    cell.locationName.text = [location getName];
    
    return cell;
}

#pragma mark - UI interaction

- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    if([segue.identifier isEqualToString:@"showLocationSegue"]){
        LocationViewController *locationController = (LocationViewController *)segue.destinationViewController;
        NSIndexPath *ip = [self.tableView indexPathForSelectedRow];
        id<ILPLocation> location = nil;
        if (filteredLocations) {
            location = [filteredLocations objectAtIndex:ip.row];
        } else {
            location = [locations objectAtIndex:ip.row];
        }
        locationController.title = [location getName];
        locationController.location = location;
    }
}

#pragma mark Content Filtering
-(void)filterContentForSearchText:(NSString*)searchText scope:(NSString*)scope {
    // Update the filtered array based on the search text and scope.
    // Remove all objects from the filtered search array
    [self.filteredLocations removeAllObjects];
    // Filter the array using NSPredicate
    if ([scope isEqualToString:@"Name"]) {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF.name contains[c] %@",searchText];
        filteredLocations = [NSMutableArray arrayWithArray:[locations filteredArrayUsingPredicate:predicate]];
    } else if ([scope isEqualToString:@"Distance"]) {
        LPLocalpointService *lpService = [LPLocalpointService instance];
        id<ILPFilter> distFilter = [[[lpService getLocationProvider] getFilterFactory] getWithinDistanceFilter:searchText.doubleValue];
        [locationFilter reset];
        [locationFilter addFilter:distFilter];
        id<ILPOrdering> proximityOrder = [[[lpService getLocationProvider] getOrderingFactory] getAscendingDistanceOrdering];
        filteredLocations = [NSMutableArray arrayWithArray:[[lpService getLocationProvider] getLocations:locationFilter withOrdering:proximityOrder]];
    }
}

#pragma mark - UISearchDisplayController Delegate Methods
-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchString:(NSString *)searchString {
    NSInteger searchOption = [self.searchDisplayController.searchBar selectedScopeButtonIndex];
    return [self searchDisplayController:controller shouldReloadTableForSearchScope:searchOption];
}

-(BOOL)searchDisplayController:(UISearchDisplayController *)controller shouldReloadTableForSearchScope:(NSInteger)searchOption {
    // Tells the table data source to reload when scope bar selection changes
    NSString *title = [[self.searchDisplayController.searchBar scopeButtonTitles] objectAtIndex:searchOption];
    [self filterContentForSearchText:self.searchDisplayController.searchBar.text scope:title];
    // Return YES to cause the search result table view to be reloaded.
    return YES;
}

-(void)searchBar:(UISearchBar *)searchBar selectedScopeButtonIndexDidChange:(NSInteger)selectedScope {
    switch (selectedScope) {
        case 1:
            searchBar.text = @"";
            searchBar.keyboardType = UIKeyboardTypeNumberPad;
            break;
        default:
            searchBar.keyboardType = UIKeyboardTypeDefault;
            break;
    }
    // Hack: force ui to reflect changed keyboard type
    [searchBar resignFirstResponder];
    [searchBar becomeFirstResponder];
}

- (void)searchBarCancelButtonClicked:(UISearchBar *)searchBar {
    filteredLocations = Nil;
    [self.tableView reloadData];
    [searchBar resignFirstResponder];
}

- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar {
    [searchBar resignFirstResponder];
}

@end
