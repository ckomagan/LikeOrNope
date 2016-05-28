//
//  HomePageController
//  KidsIQ3
//
//  Created by Chan Komagan on 7/28/12.
//  Copyright (c) 2012 KidsIQ. All rights reserved.
//

#import "HomePageController.h"
#import "SettingsController.h"
#import "BucketPageController.h"

@implementation HomePageController
@synthesize fbId;
@synthesize nsURL;
@synthesize responseData;
NSDictionary *res;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
    }
    return self;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    self.nameLabel.text = self.userName;
    self.ageLabel.text = self.userAge;
    
    NSString *post = [NSString stringWithFormat:@"&fbId=%@&emailId=%@&location=%@&zip=%@&age=%@&gender=%@&mainphoto=%@&authtoken=%@", self.fbId, self.emailId, self.userLocation, self.userZip, self.userAge, self.userGender, NULL, NULL ];

    NSData *postData = [post dataUsingEncoding:NSUTF8StringEncoding allowLossyConversion:YES];
    NSString *postLength = [NSString stringWithFormat:@"%d",[postData length]];
    NSMutableURLRequest *request = [[NSMutableURLRequest alloc] init];
    
    self.nsURL = @"http://www.komagan.com/TinderTraveler/index.php?format=json&operation=match";

    NSLog(@"URL=%@",self.nsURL);
    
    self.responseData = [NSMutableData data];
    
    NSURLRequest *aRequest = [NSURLRequest requestWithURL:[NSURL URLWithString: self.nsURL]];
   
    [[NSURLConnection alloc] initWithRequest:aRequest delegate:self];
    
}

- (void)viewDidUnload
{
    [super viewDidUnload];
    // Release any retained subviews of the main view.
    // e.g. self.myOutlet = nil;
}

-(void)viewWillAppear:(BOOL)animated
{

}

- (void)connection:(NSURLConnection *)connection didReceiveResponse:(NSURLResponse *)response {
    [self.responseData setLength:0];
}

- (void)connection:(NSURLConnection *)connection didReceiveData:(NSData *)data {
    [self.responseData appendData:data];
}

- (void)connection:(NSURLConnection *)connection didFailWithError:(NSError *)error {
    self.responseData = nil;
}

- (void)connectionDidFinishLoading:(NSURLConnection *)connection
{
    NSError *myError = nil;
    res = [NSJSONSerialization JSONObjectWithData:self.responseData options:NSJSONReadingMutableLeaves error:&myError];
    NSMutableArray *answers = [[NSMutableArray alloc] init];
    
    for(NSDictionary *res1 in res) {
        NSString *id = [res1 objectForKey:@"id"];
        NSLog(@"%@", id);
    }
}

-(IBAction)matchBtn:(id)sender {
    [self performSegueWithIdentifier:@"MatchPage" sender:self];
}

-(IBAction)appSettingsBtn:(id)sender {
    [self performSegueWithIdentifier:@"SettingsPage" sender:self];
}

-(IBAction)bucketListBtn:(id)sender {
    [self performSegueWithIdentifier:@"CreateBucketListPage" sender:self];
}

-(void) prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    if ([[segue identifier] isEqualToString:@"MatchPage"]) {
        
        HomePageController *homePageView = segue.destinationViewController;
    }
    if ([[segue identifier] isEqualToString:@"SettingsPage"]) {
        
       SettingsController *settingsPageView = segue.destinationViewController;
    }
    if ([[segue identifier] isEqualToString:@"CreateBucketListPage"]) {
        
        BucketPageController *bucketListPageView = segue.destinationViewController;
    }
}

@end
