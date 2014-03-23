//
//  RPViewController.h
//  RestaurantProblem
//
//  Created by Steven Jordan Kozmary on 3/22/14.
//
//

#import <UIKit/UIKit.h>
#import "RPAvailability.h"
#import "RPTimeSelectViewController.h"
#import "RPAppDelegate.h"

@interface RPViewController : UITableViewController <UITableViewDelegate>
{
    RPAppDelegate *delegate;
}
//This will contain an array of NSDate objects for days that reservations can be made upon.
@property (nonatomic, strong) NSMutableArray *availableDates;
//This property represents how many days in advance reservations can be made. A value of 1 will mean that reservations can be made for either today or tomorrow.
@property (nonatomic) NSInteger daysInAdvance;
@property (strong, nonatomic) IBOutlet UITableView *tableView;

@end
