//
//  AttributeViewController.m
//  LocalpointTester_iOS
//
//  Created by Jason Schmitt on 9/4/13.
//  Copyright (c) 2013 Jason Schmitt. All rights reserved.
//

#import "AttributeViewController.h"
#import "LPLoggingManager.h"
#import "MyLPConfiguration.h"

static NSString *COLON = @" : ";

@interface AttributeViewController () {
@private
    NSMutableDictionary *attributes;
    NSArray *sortedAttrNames;
    
    NSArray *attributeTypes;
}

@end

@implementation AttributeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (id) initWithCoder:(NSCoder *)aDecoder {
    self = [super initWithCoder:aDecoder];
    if (self) {
        attributes = [[NSMutableDictionary alloc] init];
        if ([MyLPConfiguration useMyConfig]) {
            [attributes setObject:@"GOLD" forKey:@"loyalty_status"];
            [attributes setObject:[NSNumber numberWithLongLong:9999] forKey:@"reward_points"];
            [attributes setObject:[NSNumber numberWithLongLong:10000] forKey:@"frequent_flier_miles"];
        }
        [self sortAttributeNames];
        
        attributeTypes = [NSArray arrayWithObjects: @"s", @"q", @"c", nil];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
	// Do any additional setup after loading the view.
}

- (void)didReceiveMemoryWarning  {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)onClickAddUpdateButton:(id)sender {
    NSString *name = [tfAttrName text];
    if (!name || [name length] == 0)
        return;

    NSString *value = [tfAttrValue text];
    if (!value || [value length] == 0)
        return;
    
    //is the value a number?
    NSInteger sel = [scAttrType selectedSegmentIndex];
    NSNumber *nValue = nil;
    switch (sel) {
        case 1:
            nValue = [NSNumber numberWithLongLong:[value intValue]];
            break;
        case 2:
            nValue = [NSNumber numberWithBool:[value boolValue]];
            break;
        default:
            break;
    }
    
    if (nValue)
        [attributes setObject:nValue forKey:name];
    else
        [attributes setObject:value forKey:name];
    [self refreshAttributeList];
}

- (IBAction)onClickDeleteButton:(id)sender {
    NSString *name = [tfAttrName text];
    if (!name || [name length] == 0)
        return;
    
    [attributes removeObjectForKey:name];
    [self refreshAttributeList];
}

- (IBAction)onClickSendButton:(id)sender {
    id<ILPAttributeManager> attrMgr = [MyLPConfiguration getAttributeManager:tvResult];
    [attrMgr updateProfileAttributes:attributes];
}

- (IBAction)onClickGetButton:(id)sender {
    TmpAttributeManager2 *attrMgr2 = [MyLPConfiguration getTmpAttributeManager2:tvResult];
    [attrMgr2 addRetrievalListener:self];
    [attrMgr2 getProfileAttributes];
}

- (BOOL) textFieldShouldReturn:( UITextField *) textField {
    [textField resignFirstResponder];
    return YES;
}

- (void)viewDidUnload {
    tfAttrName = nil;
    tfAttrValue = nil;
    tvResult = nil;
    tblvAttributes = nil;
    scAttrType = nil;
    [super viewDidUnload];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return [attributes count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if(cell == nil) {
        cell = [[UITableViewCell alloc]
                initWithStyle:UITableViewCellStyleValue1
                reuseIdentifier:@"cell"];
    }
    
    NSString *name = [sortedAttrNames objectAtIndex:[indexPath row]];
    id value = [attributes objectForKey:name];
    NSString *sVal = [value description];
    NSString *sTyp = [self typeOf:value];
    
    if ([attributeTypes indexOfObject:sTyp] == 2) {
        //boolean
        BOOL bVal = [sVal boolValue];
        if (bVal)
            sVal = @"true";
        else
            sVal = @"false";
    }
    
    cell.textLabel.text = name;
    cell.detailTextLabel.text = [NSString stringWithFormat:@"%@ %@ %@", sVal, COLON, sTyp];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    NSString *name = [sortedAttrNames objectAtIndex:[indexPath row]];
    id value = [attributes objectForKey:name];
    tfAttrName.text = name;
    tfAttrValue.text = [value description];
    
    NSString *type = [self typeOf:value];
    NSInteger idx = [attributeTypes indexOfObject:type];
    if (idx != NSNotFound)
        [scAttrType setSelectedSegmentIndex:idx];
}

- (void) refreshAttributeList {
    [self sortAttributeNames];
    [tblvAttributes reloadData];
}

- (void) reloadAttributesFrom:(NSString *)httpResult {
    NSData *data = [httpResult dataUsingEncoding:NSUTF8StringEncoding];
    NSError *error = nil;
    NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:data options:0 error:&error];
    if (error) {
        NSLog(@"Error: %d. %@", [error code], [error description]);
        return;
    }
    
    if (!dict)
        return;
    
    NSDictionary *fas = [dict objectForKey:@"profileAttributes"];
    //NSLog(@"******\n%@", [fas description]);
    if (fas) {
        attributes = nil;
        attributes = [NSMutableDictionary dictionaryWithDictionary:fas];
        //resfresh UI
        [self refreshAttributeList];
    }
}

- (void) sortAttributeNames {
    NSArray *keys = [attributes allKeys];
    sortedAttrNames = [keys sortedArrayUsingComparator: ^(id obj1, id obj2) {
        return [obj1 compare:obj2];
    }];
}

- (NSString *) typeOf:(id)var {
    if ([var isKindOfClass:[NSNumber class]]) {
        return [NSString stringWithFormat:@"%s", [var objCType]];
    }

    //default to String
    return @"s";
}

- (void)onGetSuccess:(NSString *)result {
    NSString *infoMsg = [NSString stringWithFormat:@"Got attributes successfully: %@", result];
    [tvResult performSelectorOnMainThread:@selector(setText:) withObject:infoMsg waitUntilDone:NO];
    [self performSelectorOnMainThread:@selector(reloadAttributesFrom:) withObject:result waitUntilDone:NO];
    [LPLoggingManager logExternal:infoMsg];
}

- (void)onGetFailure:(NSError *)error {
    NSString *errMsg = [NSString stringWithFormat:@"Failed to get attributes. Error: %d. %@",
                        [error code], [error description]];
    [tvResult performSelectorOnMainThread:@selector(setText:) withObject:errMsg waitUntilDone:NO];
    [LPLoggingManager logExternal:errMsg];
}

@end
