//
//  NameViewController.m
//  KidsIQ3
//
//  Created by Chan Komagan on 7/28/12.
//  Copyright (c) 2012 KidsIQ. All rights reserved.
//

#import "BucketPageController.h"
#import "GoalController.h"
#import "SettingsController.h"
#import "MatchPageController.h"

@implementation BucketPageController
@synthesize fbId, goalId, goal, city, country, fromDate, toDate;
@synthesize nsURL = _nsURL;
NSDictionary *res;

#define LEGAL	@"ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz"
NSMutableArray *goalData, *goalsData, *goals, *cities, *countries, *fromDates, *toDates;


- (void)viewDidLoad
{
    goalData = [[NSMutableArray alloc] init];
    goalsData = [[NSMutableArray alloc] init];
    goals = [[NSMutableArray alloc] init];
    cities = [[NSMutableArray alloc] init];
    countries = [[NSMutableArray alloc] init];
    fromDates = [[NSMutableArray alloc] init];
    toDates = [[NSMutableArray alloc] init];
    
    UITableViewController * table = [[UITableViewController alloc] init];
    [self.view addSubview:table.tableView];
    [self addChildViewController:table];

    if ([FBSDKAccessToken currentAccessToken]) {
        
        NSString *post = [[NSUserDefaults standardUserDefaults] valueForKey:@"fbId"];

        _nsURL = @"http://www.komagan.com/TinderTraveler/index.php?format=json&operation=bucketlist&fbId=";
        _nsURL = [_nsURL stringByAppendingString:post];
        
        NSLog(@"URL=%@", _nsURL);
        //tableData1 = [NSMutableArray arrayWithObjects:@"My Bucket List", @"App Settings", @"Help & Support", nil];
        [self sendHTTPGet];
    }
    else{
        NSLog(@"no Token");
    }
    [super viewDidLoad];
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [goals count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    //NSLog(@"arrrrr '%lu'", (unsigned long)goalsData.count);

    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:simpleTableIdentifier];
    }
    cell.textLabel.text = [NSString stringWithFormat:@"%@ - %@", [goals objectAtIndex:indexPath.row], [cities objectAtIndex:indexPath.row]];
    cell.textLabel.font = [UIFont systemFontOfSize:14];

    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
        GoalController *goalView = [[GoalController alloc] initWithNibName:@"GoalController" bundle:nil];
        goalView.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
        goalView.goal = [goals objectAtIndex:indexPath.row];
        goalView.city = [cities objectAtIndex:indexPath.row];
        goalView.country = [countries objectAtIndex:indexPath.row];
        goalView.fromDate = [fromDates objectAtIndex:indexPath.row];
        goalView.toDate = [toDates objectAtIndex:indexPath.row];
    
        [self presentViewController:goalView animated:YES completion:nil];
    
}

-(void) sendHTTPGet
{
    NSURLSessionConfiguration *defaultConfigObject = [NSURLSessionConfiguration defaultSessionConfiguration];
    NSURLSession *defaultSession = [NSURLSession sessionWithConfiguration: defaultConfigObject delegate: self delegateQueue: [NSOperationQueue mainQueue]];
    
    
    NSURLSessionDataTask * dataTask = [defaultSession dataTaskWithURL:[NSURL URLWithString:_nsURL]
                                                    completionHandler:^(NSData *data, NSURLResponse *response, NSError *error) {
                                                        if(error == nil)
                                                        {
                                                            NSError *myError = nil;
                                                            //NSString * text = [[NSString alloc] initWithData: data encoding: NSUTF8StringEncoding];
                                                            res = [NSJSONSerialization JSONObjectWithData:data options:NSJSONReadingMutableLeaves error:&myError];
                                                           
                                                            //NSLog(@"Data = %@",text);
                                                            for(NSDictionary *res1 in res) {
                                                                //goalId = [res1 objectForKey:@"id"];
                                                                goal = [res1 objectForKey:@"goal"];
                                                                city = [res1 objectForKey:@"city"];
                                                                country = [res1 objectForKey:@"country"];
                                                                fromDate = [res1 objectForKey:@"fromDate"];
                                                                toDate = [res1 objectForKey:@"toDate"];
                                                                //[goalData addObject:self.goalId];
                                                                [goals addObject:goal];
                                                                [cities addObject:city];
                                                                [countries addObject:country];
                                                                [fromDates addObject:fromDate];
                                                                [toDates addObject:toDate];

                                                                [goalData addObject:self.goal];
                                                                [goalData addObject:self.city];
                                                                [goalData addObject:self.country];
                                                                [goalData addObject:self.fromDate];
                                                                [goalData addObject:self.toDate];
                                                                [goalsData addObject:goalData];
                                                                [goalData removeAllObjects];
                                                            }
                                                        }
                                                        [self.tableView reloadData];
                                                        
                                                    }];
    [dataTask resume];
}

-(IBAction)addGoal:(id)sender {
    GoalController *goalView = [[GoalController alloc] initWithNibName:@"GoalController" bundle:nil];
    goalView.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:goalView animated:YES completion:nil];
}

-(IBAction)showSettingsPage {
    SettingsController *settingsView = [[SettingsController alloc] initWithNibName:@"Settings" bundle:nil];
    settingsView.name = [[NSUserDefaults standardUserDefaults] valueForKey:@"name"];
    settingsView.location = [[NSUserDefaults standardUserDefaults] valueForKey:@"city"];
    settingsView.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:settingsView animated:YES completion:nil];
}

-(IBAction)showMatchPage {
    MatchPageController *matchPage = [[MatchPageController alloc] initWithNibName:nil bundle:nil];
    self.window = [[UIWindow alloc] init];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    self.window.rootViewController = matchPage;
}

- (void)applicationDidFinishLaunching:(UIApplication *)application {
}

- (void)viewDidUnload
{
    [super viewDidLoad];
}


@end
