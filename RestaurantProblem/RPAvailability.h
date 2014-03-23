//
//  RPAvailability.h
//  RestaurantProblem
//
//  Created by Steven Jordan Kozmary on 3/22/14.
//
//

#import <Foundation/Foundation.h>

@interface RPAvailability : NSObject

//This function will return a dictionary initialized with the contents of the URL in the problem description.
+(NSDictionary*) availabilityAPIRequest;

@end
