//
//  GoalController.m
//  LikedOrNope
//
//  Created by Chan Komagan on 5/26/16.
//  Copyright © 2016 modocache. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "GoalController.h"
#import "BucketPageController.h"

#define REGEX_DATE @"[1-31]{2}\\-[1-12]{2}\\-[2016-2020]{4}"

@implementation GoalController
@synthesize nsURL = _nsURL;

- (void) viewDidLoad {
    self.goalText.text = self.goal;
    self.cityText.text = self.city;
    self.countryText.text = self.country;
    self.fromDateText.text = self.fromDate;
    self.toDateText.text = self.toDate;
}

-(IBAction)addGoal {
    if([self checkValidation] == 1)
    {
    _nsURL = @"http://www.komagan.com/TinderTraveler/index.php?format=json&operation=addGoal";
    self.fbId = [[NSUserDefaults standardUserDefaults] valueForKey:@"fbId"];
    self.responseData = [NSMutableData data];
    
    if(self.fbId)
    {
        NSString *myRequestString = [NSString stringWithFormat:@"fbId=%@&goal=%@&city=%@&country=%@&fromDate=%@&toDate=%@", self.fbId, self.goalText.text, self.cityText.text, self.countryText.text, self.fromDateText.text, self.toDateText.text];
        
        //NSLog(@"%@",myRequestString);
        
        // Create Data from request
        NSData *myRequestData = [NSData dataWithBytes: [myRequestString UTF8String] length: [myRequestString length]];
        NSMutableURLRequest *request = [[NSMutableURLRequest alloc] initWithURL: [NSURL URLWithString: _nsURL]];
        // set Request Type
        [request setHTTPMethod: @"POST"];
        // Set content-type
        [request setValue:@"application/x-www-form-urlencoded" forHTTPHeaderField:@"content-type"];
        // Set Request Body
        [request setHTTPBody: myRequestData];
        // Now send a request and get Response
        NSData *returnData = [NSURLConnection sendSynchronousRequest: request returningResponse: nil error: nil];
        // Log Response
        NSString *response = [[NSString alloc] initWithBytes:[returnData bytes] length:[returnData length] encoding:NSUTF8StringEncoding];
        NSLog(@"%@",response);
    }
    [self showBucketList];
    }
    else{
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:@"Please Enter All Values" message: nil delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil, nil];
        [alertView show];
    }
}

-(int)checkValidation
{
    NSLog(@" size is %lu", self.cityText.text.length);
    if(self.goalText.text.length !=0 && self.goalText.text != nil && self.cityText.text.length !=0 && self.cityText.text != nil && self.countryText.text.length !=0 && self.countryText.text != nil && self.fromDateText.text.length !=0 && self.fromDateText.text != nil && self.toDateText.text.length !=0 && self.toDateText.text != nil)
    {
        return 1;
    }
    else{
        return 0;
    }
}

-(IBAction)cancelGoal {
    [self showBucketList];
}

- (void)showBucketList
{
    BucketPageController *bucketListPage = [[BucketPageController alloc] initWithNibName:nil bundle:nil];
    self.window = [[UIWindow alloc] init];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    self.window.rootViewController = bucketListPage;
}

- (void)applicationDidFinishLaunching:(UIApplication *)application {
}
    
- (void)viewDidUnload
{
    [super viewDidLoad];
}

@end