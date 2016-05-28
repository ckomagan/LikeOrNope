//
//  SettingsController.m
//  TinderTraveler
//
//  Created by Chan Komagan on 10/18/14.
//  Copyright (c) 2014 Chan Komagan. All rights reserved.
//

#import "SettingsController.h"
#import "SignInController.h"
#import "BucketPageController.h"
#import "MatchPageController.h"

@implementation SettingsController
{
    NSArray *tableData1, *tableData2;
}

NSDictionary *res;

- (void) viewDidLoad {
    self.backgroundImage.image = [UIImage imageNamed:@"worldmap.jpg"];
    self.profileImage.layer.cornerRadius = 30.0;
    self.profileImage.clipsToBounds=YES;
    self.profileImage.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.profileImage.layer.borderWidth = 1.0;
    
    self.nameLabel.text = [[NSUserDefaults standardUserDefaults] valueForKey:@"name"];
    self.locationLabel.text = [[NSUserDefaults standardUserDefaults] valueForKey:@"location"];
    tableData1 = [NSArray arrayWithObjects:@"My Bucket List", @"App Settings", @"Help & Support", nil];
    tableData2 = [NSArray arrayWithObjects:@"Create and update your bucket list", @"Notifications, account and more!", @"Contact info, FAQ", nil];
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return [tableData1 count];
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    static NSString *simpleTableIdentifier = @"SimpleTableItem";
    
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:simpleTableIdentifier];
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:simpleTableIdentifier];
    }
    
    cell.textLabel.text = [tableData1 objectAtIndex:indexPath.row];
    cell.detailTextLabel.text = [tableData2 objectAtIndex:indexPath.row];
    return cell;
}

- (void)loginViewShowingLoggedInUser:(FBSDKLoginButton *)loginView{
    NSLog(@"User logged in");
 
}

- (void)loginViewShowingLoggedOutUser:(FBSDKLoginButton *)loginView {
    NSLog(@"User logged out");
    [self performSegueWithIdentifier:@"SignInPage" sender:nil];
}


- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{

}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.row == 0)
    {
        [self showBucketList];
    }
    else if(indexPath.row == 1)
    {
        [self showAppSettings];
    }
}

- (void)showBucketList
{
    BucketPageController *bucketListPage = [[BucketPageController alloc] initWithNibName:nil bundle:nil];
    self.window = [[UIWindow alloc] init];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    self.window.rootViewController = bucketListPage;
}

- (void)showAppSettings
{
    
}

- (IBAction)fbDidLogout:(id)sender
{
    FBSDKAccessToken.currentAccessToken = nil;
    
    NSHTTPCookie *cookie;
    NSHTTPCookieStorage *storage = [NSHTTPCookieStorage sharedHTTPCookieStorage];
    for (cookie in [storage cookies])
    {
        NSString *domainName = [cookie domain];
        NSRange domainRange = [domainName rangeOfString:@"facebook"];
        if(domainRange.length > 0)
        {
            [storage deleteCookie:cookie];
        }
    }
    
    /*UIStoryboard *stryBoard=[UIStoryboard storyboardWithName:@"Main" bundle:nil];
    SignInController *signInView = [stryBoard instantiateViewControllerWithIdentifier:@"SignInPage"];
    signInView.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:signInView animated:YES completion:nil];*/
    
    SignInController *signInPage = [[SignInController alloc] initWithNibName:nil bundle:nil];
    self.window = [[UIWindow alloc] init];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    self.window.rootViewController = signInPage;
}

-(IBAction)showMatchPage {
    MatchPageController *matchPage = [[MatchPageController alloc] initWithNibName:nil bundle:nil];
    self.window = [[UIWindow alloc] init];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    self.window.rootViewController = matchPage;
}

@end