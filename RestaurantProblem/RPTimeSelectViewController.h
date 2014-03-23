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
@property (strong, nonatomic) NSMutableArray *reservationTimes;

//+(NSInteger)convertTimeString:(NSString *)time;

@end
