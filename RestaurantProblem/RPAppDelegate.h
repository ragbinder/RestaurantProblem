//
//  RPAppDelegate.h
//  RestaurantProblem
//
//  Created by Steven Jordan Kozmary on 3/22/14.
//
//

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
