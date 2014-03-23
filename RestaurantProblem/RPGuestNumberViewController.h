//
//  RPGuestNumberViewController.h
//  RestaurantProblem
//
//  Created by Steven Jordan Kozmary on 3/22/14.
//
//

#import <UIKit/UIKit.h>
#import "RPAppDelegate.h"

@interface RPGuestNumberViewController : UIViewController <UITableViewDataSource, UITableViewDelegate, UIAlertViewDelegate>
{
    RPAppDelegate *delegate;
}
@property (weak, nonatomic) IBOutlet UITableView *tableView;
@property (weak, nonatomic) IBOutlet UILabel *dateLabel;
@property (weak, nonatomic) IBOutlet UILabel *timeLabel;
@property (weak, nonatomic) IBOutlet UILabel *guestsLabel;
@property (nonatomic) NSInteger maxGuests;

- (IBAction)makeReservation:(id)sender;

@end
