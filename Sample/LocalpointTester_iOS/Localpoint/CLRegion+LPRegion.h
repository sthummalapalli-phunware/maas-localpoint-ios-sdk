//
//  CLRegion+LPRegion.h
//  Localpoint
//
//  Created by Jason Schmitt on 9/11/13.
//
//

#import <CoreLocation/CoreLocation.h>

@interface CLRegion (LPRegion)

/** Shortcut access to latitude
  */
- (CLLocationDegrees) latitude;

/** Shortcut access to longitude
 */
- (CLLocationDegrees) longitude;

/** Printable string showing details of a region.
  * This method can be used in place of the description method so that
  * we have some control over how/what is printed.
  */
- (NSString *) details;

@end
