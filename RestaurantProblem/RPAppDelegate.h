//
//  RPAppDelegate.h
//  RestaurantProblem
//
//  Created by Steven Jordan Kozmary on 3/22/14.
//
//

/*
This app has three screens that are all there to manage the data in a NSManagedObject held in the appDelegate. 
 The first screen selects the date. 
 The second screen selects a time and displays how many slots are available for each time slot. If there are no vacancies, then the second screen will not allow the user to proceed, and prompts them to select a different slot.
 The third screen selects the number of guests, and then allows the user to attempt to confirm the reservation.
 From here, the app will display a UIAlertView asking the user if they wish to confirm their currently selected reservation. If the user confirms, it will save the CoreData managed object context (held by the delegate) and return them to the first screen to make another reservation.
*/

#import <UIKit/UIKit.h>
#import <CoreData/CoreData.h>
#import "RPAvailability.h"

@interface RPAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;
//This stores the availability data from the JSON file after it has been retreived.
@property (strong, nonatomic) NSDictionary *dailyAvailability;
@property (readonly, strong, nonatomic) NSManagedObjectContext *managedObjectContext;
@property (readonly, strong, nonatomic) NSManagedObjectModel *managedObjectModel;
@property (readonly, strong, nonatomic) NSPersistentStoreCoordinator *persistentStoreCoordinator;
//This stores the reservation currently being made.
@property (strong, nonatomic) NSManagedObject *currentReservation;

- (void)saveContext;
- (NSURL *)applicationDocumentsDirectory;

@end
