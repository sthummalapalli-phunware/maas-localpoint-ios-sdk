//
//  CLRegion+LPRegion.m
//  Localpoint
//
//  Created by Jason Schmitt on 9/11/13.
//
//

#import "CLRegion+LPRegion.h"

@implementation CLRegion (LPRegion)

- (CLLocationDegrees) latitude {
    return self.center.latitude;
}

- (CLLocationDegrees) longitude {
    return self.center.longitude;
}

- (NSString *) details {
    return [NSString stringWithFormat:@"Region: %@, Latitude: %+.6f, Longitude: %+.6f, Radius: %+.0f", self.identifier, self.latitude, self.longitude, self.radius];
}

@end
