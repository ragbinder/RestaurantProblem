//
//  RPViewController.m
//  RestaurantProblem
//
//  Created by Steven Jordan Kozmary on 3/22/14.
//
//

#import "RPViewController.h"

@interface RPViewController ()

@end

@implementation RPViewController
@synthesize availableDates = _availableDates;
@synthesize daysInAdvance = _daysInAdvance;
@synthesize tableView = _tableView;

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    delegate = (RPAppDelegate *)[[UIApplication sharedApplication] delegate];
    _daysInAdvance = 14;
    
    //Create a new NSManagedObject for the FIRST reservation.
    delegate.currentReservation = [NSEntityDescription insertNewObjectForEntityForName:@"Reservation" inManagedObjectContext:[delegate managedObjectContext]];
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    
    _availableDates = [[NSMutableArray alloc] initWithCapacity:_daysInAdvance];
    //Assuming that allowing Reservations 1 day in advance would allow reservations to be made for today or tomorrow, and not up to 24 hours in advance
    
    NSLocale *locale = [NSLocale currentLocale];
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    NSString *dateFormat = [NSDateFormatter dateFormatFromTemplate:@"E MMM d" options:0 locale:locale];
    [format setDateFormat:dateFormat];
    [format setLocale:locale];
    
    for (int i = 0; i <= _daysInAdvance; i++)
    {
        [_availableDates addObject:[format stringFromDate:[NSDate dateWithTimeIntervalSinceNow:i * 60 * 60 * 24]]];
    }
    //NSLog(@"%@",_availableDates);
    
    [_tableView reloadData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    return _daysInAdvance+1;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"Cell" forIndexPath:indexPath];
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
    NSDate *reservationDate = [_availableDates objectAtIndex:indexPath.row];
    //NSLog(@"%@",reservationDate);
    
    [delegate.currentReservation setValue:reservationDate forKey:@"date"];
    
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    RPTimeSelectViewController *timeSelect = [storyboard instantiateViewControllerWithIdentifier:@"TimeSelect"];
    //timeSelect.title = [reservationDate description];
    [self.navigationController pushViewController:timeSelect animated:YES];
}

- (void)configureCell:(UITableViewCell *)cell atIndexPath:(NSIndexPath *)indexPath
{
    /*
    NSLocale *locale = [NSLocale currentLocale];
    NSDateFormatter *format = [[NSDateFormatter alloc] init];
    NSString *dateFormat = [NSDateFormatter dateFormatFromTemplate:@"E MMM d" options:0 locale:locale];
    [format setDateFormat:dateFormat];
    [format setLocale:locale];
    */
    cell.textLabel.text = [_availableDates objectAtIndex:indexPath.row];
}

@end
