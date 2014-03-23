//
//  RPGuestNumberViewController.m
//  RestaurantProblem
//
//  Created by Steven Jordan Kozmary on 3/22/14.
//
//

#import "RPGuestNumberViewController.h"

@interface RPGuestNumberViewController ()

@end

@implementation RPGuestNumberViewController
@synthesize tableView = _tableView;
@synthesize dateLabel = _dateLabel;
@synthesize timeLabel = _timeLabel;
@synthesize guestsLabel = _guestsLabel;
@synthesize maxGuests = _maxGuests;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    delegate = (RPAppDelegate *)[[UIApplication sharedApplication] delegate];
    
    _maxGuests = 14;
    
    _tableView.delegate = self;
    _tableView.dataSource = self;
    _tableView.allowsMultipleSelection = NO;
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    _dateLabel.text = [delegate.currentReservation valueForKey:@"date"];
    _timeLabel.text = [delegate.currentReservation valueForKey:@"time"];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

- (IBAction)makeReservation:(id)sender {
    NSString *messageString = [NSString stringWithFormat:@"%@\nAt %@\nOn %@",
                               [delegate.currentReservation valueForKey:@"guests"],
                               [delegate.currentReservation valueForKey:@"time"],
                               [delegate.currentReservation valueForKey:@"date"]];
    
    UIAlertView *confirmationAlert = [[UIAlertView alloc] initWithTitle:@"Confirm Reservation" message:messageString delegate:self cancelButtonTitle:@"Cancel" otherButtonTitles:@"Confirm", nil];
    
    [confirmationAlert show];
}

//***************************************************************************
//  UITableViewDataSource and UITableViewDelegate Protocol Methods
//***************************************************************************
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _maxGuests;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"GuestCell" forIndexPath:indexPath];
    [self configureCell:cell atIndexPath:indexPath];
    
    return cell;
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    cell.textLabel.text = [NSString stringWithFormat:@"%d",indexPath.row+1];
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    [delegate.currentReservation setValue:[[self tableView:tableView cellForRowAtIndexPath:indexPath].textLabel text] forKey:@"guests"];
    
    //[_tableView deselectRowAtIndexPath:indexPath animated:YES];
    //NSLog(@"%@",[delegate.currentReservation valueForKey:@"guests"]);
    //NSLog(@"%@",[tableView indexPathForSelectedRow]);
    
    _guestsLabel.text = [NSString stringWithFormat:@"Number of Guests: %@",[delegate.currentReservation valueForKey:@"guests"]];
    [delegate.currentReservation setValue:_guestsLabel.text forKey:@"guests"];
}

//*********************************
//  UIAlertViewDelegate Method
//*********************************
- (void)alertView:(UIAlertView *)alertView didDismissWithButtonIndex:(NSInteger)buttonIndex
{
    NSLog(@"Button Index %d Pressed",buttonIndex);
    if (buttonIndex == 1) {
        NSError *error;
        if([delegate.managedObjectContext save:&error])
        {
            UIAlertView *confirmSuccess = [[UIAlertView alloc] initWithTitle:@"Reservation Confirmed!" message:nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
            [confirmSuccess show];
            
            //Create a new NSManagedObject for the new reservation.
            delegate.currentReservation = [NSEntityDescription insertNewObjectForEntityForName:@"Reservation" inManagedObjectContext:[delegate managedObjectContext]];
            
            [self.navigationController popToRootViewControllerAnimated:YES];
        }
        else
        {
            NSLog(@"ERROR confirming reservation: %@",error);
        }
    }
}

@end
