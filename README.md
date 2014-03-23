RestaurantProblem README =================

This is my (Steven Jordan Kozmary) solution for the Restaurant Problem

Assumptions: This application is to be designed for an iPhone (either
3.5 or 4 inch screen) and not an iPad.

This application is designed to be used by the restaurant host, and not
individual guests. If I were writing the application to be used by
guests, I would include code in the confirmation screen to fetch the
current list of reservations and confirm that the guest's reservation
was in fact present on the restaurant's server. Ideally, the server
would be able to resolve conflicts arising from multiple customers
making reservations at the exact same time.

If this app were written for use by guests, it would also make sense to
add reservations to the guest's iPhone calendar and use push
notifications to remind them of their reservations. I could also provide
driving directions from the user's current location to the restaurant.

I am assuming that each of the restaurant's reservation slots will be
able to accomodate up to 14 (can be altered in
RPGuestNumberViewController.m - viewDidLoad) guests, and that each party
will use exactly 1 slot. This easily be expanded to allow for parties of
6 or more to take up 2+ slots (pushing 2+ tables together). I could also
expand the functionality to take into account any differently sized
tables available (we have 10 2-person tables, and 15 4-person tables),
but I am writing this app for a more general use case.

The application will be restarted whenever there is a change in
availability, and that I do not have to deal with the case that
availability decreases below the current number of reservations for a
given time. If I was not asked to download the availability data every
time the application starts, I would prefer to download it every time
the user begins to make a new reservation. If API consumption is
restricted, I would store the previous data with a timestamp (probably
using CoreData), and use the previous data if it is recent enough.

I am assuming that reservations for this restaurant can only be made 14
days in advance. This can be changed by editing the daysInAdvance
Property of the RPViewController in its viewDidLoad method.



The first things I would do with more time: 
I would skin the app based
on the preferences of the restaurant. 
I would improve the date picking
portion by implementing a calendar view library. I looked at the
TimesSquare Library before starting this project, but I had some issues
implementing the library in iOS 7, so I decided to continue without it.
I would support customer names in reservations, which is rather simple
to do, but was not included in the project description.
