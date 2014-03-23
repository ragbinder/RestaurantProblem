//
//  RPTimeSelectViewController.h
//  RestaurantProblem
//
//  Created by Steven Jordan Kozmary on 3/22/14.
//
//

#import <UIKit/UIKit.h>
#import "RPAppDelegate.h"
#import "RPGuestNumberViewController.h"

@interface RPTimeSelectViewController : UITableViewController <UITableViewDelegate>
{
    RPAppDelegate *delegate;
}
@property (strong, nonatomic) IBOutlet UITableView *tableView;
//This property will hold the available reservation times for the day this view controller was instantiated from. In viewDidAppear, the app will search through CoreData for that day's reservations, and calculate how many slots are still available. If there are none left, you cannot make a reservation for that time.
@property (strong, nonatomic) NSMutableArray *reservationTimes;

@end
