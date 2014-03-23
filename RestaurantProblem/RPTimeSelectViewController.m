//
//  RPTimeSelectViewController.m
//  RestaurantProblem
//
//  Created by Steven Jordan Kozmary on 3/22/14.
//
//

#import "RPTimeSelectViewController.h"

@interface RPTimeSelectViewController ()

@end

@implementation RPTimeSelectViewController
@synthesize tableView = _tableView;
@synthesize reservationTimes = _reservationTimes;

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
}

- (void)viewDidAppear:(BOOL)animated
{
    NSLog(@"View did appear!");
    [super viewDidAppear:animated];
    [_tableView reloadData];
    //Needed to handle the case that the user returns to this viewController from the next one.
    [delegate.currentReservation setValue:nil forKey:@"time"];
    
    _reservationTimes = [[NSMutableArray alloc] initWithCapacity:[[delegate.dailyAvailability valueForKey:@"availability"] count]];
    
    for(NSDictionary *slot in [delegate.dailyAvailability valueForKey:@"availability"])
    {
        [_reservationTimes addObject:[NSMutableDictionary dictionaryWithDictionary:slot]];
    }
    
    NSLog(@"%@",_reservationTimes);
    
    //Fetch all of the current reservations for the selected date.
    NSFetchRequest *fetchRequest = [[NSFetchRequest alloc] init];
    NSEntityDescription *reservationEntity = [NSEntityDescription entityForName:@"Reservation" inManagedObjectContext:[delegate managedObjectContext]];
    NSPredicate *datePredicate = [NSPredicate predicateWithFormat:@"date == %@",[delegate.currentReservation valueForKey:@"date"]];
    NSError *fetchError;
    
    [fetchRequest setEntity:reservationEntity];
    [fetchRequest setPredicate:datePredicate];
    NSLog(@"Date Predicate:%@",datePredicate);
    NSArray *reservationsToday = [delegate.managedObjectContext executeFetchRequest:fetchRequest error:&fetchError];
    NSLog(@"Reservations Today: %@",reservationsToday);
    //For each reservation, subtract one slot from the _reservationTimes availability field.
    for(NSManagedObject *object in reservationsToday)
    {
        //NSLog(@"Reservation for today:\n%@\n%@",[object valueForKey:@"time"],[object valueForKey:@"guests"]);
        //Make sure that this isn't the blank reservation slot for the current reservation.
        if([object valueForKey:@"time"])
        {
            NSLog(@"Decrementing Value for timeslot: %@",[object valueForKey:@"time"]);
            [self decrementSlotsForTime:[RPTimeSelectViewController convertTimeString:[object valueForKey:@"time"]]];
            //NSLog(@"Dict new Value: %@",_reservationTimes);
        }
    }
    [_tableView reloadData];
}

//This is a small helper method for converting the human-readable time string back to the format that is used in the sampleData.JSON file.
+(NSInteger)convertTimeString:(NSString *)time
{
    NSMutableString *answerString = [NSMutableString stringWithString:time];
    
    [answerString deleteCharactersInRange:NSMakeRange([answerString length]-3, 3)];
    //NSLog(@"%@",answerString);
    [answerString deleteCharactersInRange:NSMakeRange([answerString length]-3, 1)];
    //NSLog(@"%@",answerString);
    
    return [answerString integerValue];
}

//This is a helper method that will decrement the number of slots for a give time in the reservationTimes array
- (void)decrementSlotsForTime:(NSInteger) time
{
    for(NSDictionary *dict in _reservationTimes)
    {
        //NSLog(@"dict: %@",dict);
        if([[dict valueForKey:@"time"] integerValue] == time)
        {
            int slotsValue = [[dict valueForKey:@"slots"] integerValue];
            NSString *decrementedString = [NSString stringWithFormat:@"%d",slotsValue-1];
            NSLog(@"Decrementing %d",time);
            [dict setValue:decrementedString forKey:@"slots"];
        }
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
    
    _reservationTimes = nil;
}


//*********************************
//  Table View Required Methods
//*********************************
#pragma mark - Table View

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [_reservationTimes count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"TimeCell" forIndexPath:indexPath];
    [self configureCell:cell atIndexPath:indexPath];
    
    return cell;
}

- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath
{
    // Return NO if you do not want the specified item to be editable.
    return NO;
}

- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        
    }
}

- (BOOL)tableView:(UITableView *)tableView canMoveRowAtIndexPath:(NSIndexPath *)indexPath
{
    // The table view should not be re-orderable.
    return NO;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    //Make sure that there are slots remaining for the given time.
    if([[tableView cellForRowAtIndexPath:indexPath].detailTextLabel.text isEqualToString:@"0"])
    {
        UIAlertView *fullSlotsAlert = [[UIAlertView alloc] initWithTitle:@"No Slots Left!" message:@"Sorry, but there are no more available reservations for this time slot. Please select another time." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles: nil];
        [fullSlotsAlert show];
        [tableView deselectRowAtIndexPath:indexPath animated:YES];
        
        return;
    }
    
    NSString *reservationTime = [tableView cellForRowAtIndexPath:indexPath].textLabel.text;
    NSLog(@"%@",reservationTime);
    
    [delegate.currentReservation setValue:reservationTime forKey:@"time"];
    NSLog(@"%@",[delegate.currentReservation valueForKey:@"time"]);
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    RPGuestNumberViewController *guestNumber = [storyboard instantiateViewControllerWithIdentifier:@"GuestNumber"];
    [self.navigationController pushViewController:guestNumber animated:YES];
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    //Convert the time from the 4-digit string in the JSON to a human-readable time.
    NSMutableString *timeString;
    [timeString insertString:@":" atIndex:[timeString length] - 2];
    if([[[_reservationTimes objectAtIndex:indexPath.row] valueForKey:@"time"] integerValue] < 1200)
    {
        timeString = [NSMutableString stringWithFormat:@"%@",[[_reservationTimes objectAtIndex:indexPath.row] valueForKey:@"time"]];
        [timeString insertString:@" AM" atIndex:[timeString length]];
    }
    else if([[[_reservationTimes objectAtIndex:indexPath.row] valueForKey:@"time"] integerValue] < 1300)
    {
        timeString = [NSMutableString stringWithFormat:@"%d",[[[_reservationTimes objectAtIndex:indexPath.row] valueForKey:@"time"] integerValue]];
        [timeString insertString:@" PM" atIndex:[timeString length]];
    }
    else
    {
        timeString = [NSMutableString stringWithFormat:@"%d",[[[_reservationTimes objectAtIndex:indexPath.row] valueForKey:@"time"] integerValue] - 1200];
        [timeString insertString:@" PM" atIndex:[timeString length]];
    }
    [timeString insertString:@":" atIndex:[timeString length] - 5];
    
    //Check how many slots are available for the given time.
    NSString *slotString = [NSString stringWithFormat:@"%@",[[_reservationTimes objectAtIndex:indexPath.row] valueForKey:@"slots"]];
    
    cell.textLabel.text = timeString;
    cell.detailTextLabel.text = slotString;
}


@end
