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
//The highest number of guests a reservation can accomodate.
@property (nonatomic) NSInteger maxGuests;

//This is the method for the Make Reservation Button. It handles all parts of confirming the reservation and giving the app delegate a new NSManagedObject to keep track of.
- (IBAction)makeReservation:(id)sender;

@end
