//
//  RPAvailability.m
//  RestaurantProblem
//
//  Created by Steven Jordan Kozmary on 3/22/14.
//
//

#import "RPAvailability.h"

@implementation RPAvailability

+(NSDictionary*)availabilityAPIRequest
{
    NSURL *dataURL = [NSURL URLWithString:@"http://run.plnkr.co/8WEkl25m58Gjd4o4/timeSlots.json"];
    
    NSLog(@"MAKING AVAILABILTY API REQUEST\n URL: %@",dataURL);
    
    NSURLRequest *availabiltyRequest = [[NSURLRequest alloc] initWithURL:dataURL];
    NSURLResponse *availabilityHTTPResponse = [[NSURLResponse alloc] init];
    NSError *error;
    NSData *availabilityResponse = [NSURLConnection sendSynchronousRequest:availabiltyRequest returningResponse:&availabilityHTTPResponse error:&error];
    
    //NSLog(@"availabilityResponse: %@",availabilityResponse);
    //NSLog(@"availabilityHTTPResponse: %@",availabilityHTTPResponse);
    
    if(error)
    {
        //NSLog(@"Error retrieving data from availability API: %@",error);
        return nil;
    }
    else if(availabilityResponse)
    {
        NSDictionary *answerDictionary = [NSJSONSerialization JSONObjectWithData:availabilityResponse options:NSJSONReadingMutableContainers error:&error];
        if(error)
        {
            //NSLog(@"Error Serializing availability JSON: %@",error);
            //BEGIN OVERRIDE
            //return nil;
            
            //Normally, I would just return nil to let the program know there has been a problem, but since I cannot get good data from the link provided in the problem description, I have written a JSON data file containing what I think a reasonable output would be. This file is included with this project, and is named "sampleData.JSON". It is in the Supporting Files directory if this project is opened in XCode. It is located in the main project directory if this is being viewed in Finder/Explorer.
            NSString *path = [[NSBundle mainBundle] bundlePath];
            NSString *JSONPath = [path stringByAppendingPathComponent:@"sampleData.JSON"];
            
            //NSString *JSONString = [NSString stringWithContentsOfFile:JSONPath encoding:NSUTF8StringEncoding error:&error];
            //NSLog(@"String: \n%@",JSONString);
            
            NSError *fileIOError;
            NSDictionary *dict = [NSJSONSerialization JSONObjectWithData:[NSData dataWithContentsOfFile:JSONPath] options:NSJSONReadingMutableContainers error:&fileIOError];
            //NSLog(@"Dictionary: \n%@",dict);
            if(fileIOError)
            {
                NSLog(@"Error importing categories: %@",fileIOError);
            }
                
            return dict;
        }
        else
        {
            return answerDictionary;
        }
    }
    else
    {
        NSLog(@"Error: Availability Response was nil");
        return nil;
    }
}

@end
