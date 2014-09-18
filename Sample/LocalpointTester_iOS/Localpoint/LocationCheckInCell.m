//
//  LocationCheckInCell.m
//  LocalpointTester_iOS
//
//  Created by Jason Schmitt on 2/28/13.
//  Copyright (c) 2013 Jason Schmitt. All rights reserved.
//

#import "LocationCheckInCell.h"

@implementation LocationCheckInCell
@synthesize locationName;
//@synthesize locationDescription;

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

@end
