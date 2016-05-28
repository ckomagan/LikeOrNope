
#import "SignInController.h"
#import "ChoosePersonViewController.h"
#import "MatchPageController.h"
#import "SCSettings.h"

#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>

@implementation SignInController
@synthesize nsURL = _nsURL;
BOOL _viewDidAppear;
BOOL _viewIsVisible;

#pragma mark - Object lifecycle`

- (instancetype)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if ((self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])) {
        // We wire up the FBSDKLoginButton using the interface builder
        // but we could have also explicitly wired its delegate here.
    }
    return self;
}

- (void)dealloc {
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

#pragma mark - View Management

- (void)viewDidLoad
{
    [super viewDidLoad];
    
    if ([FBSDKAccessToken currentAccessToken]) {
        [self clearUserSession];
        [self retrieveUserFBData];
    }
    else{
        UIButton *myLoginButton=[UIButton buttonWithType:UIButtonTypeCustom];
        myLoginButton.backgroundColor=[UIColor darkGrayColor];
        myLoginButton.frame=CGRectMake(0,0,180,40);
        myLoginButton.center = self.view.center;
        [myLoginButton setTitle: @"Create your profile" forState: UIControlStateNormal];
        // Handle clicks on the button
        [myLoginButton
         addTarget:self
         action:@selector(loginButtonClicked) forControlEvents:UIControlEventTouchUpInside];
        // Add the button to the view
        [self.view addSubview:myLoginButton];
        }
}

-(void)retrieveUserFBData
{
    NSLog(@"Token is available: %@",[[FBSDKAccessToken currentAccessToken]tokenString]);
    if ([FBSDKAccessToken currentAccessToken]) {
        [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:@{@"fields": @"id,first_name,email,birthday,gender,picture.type(large),location"}]
         startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
             if (!error) {
                 self.fbId = result[@"id"]; // facebookID
                 self.name = result[@"first_name"]; //facebookName
                 self.emailId = result[@"email"]; //facebookEmail
                 self.age = [self calculateAge:result[@"birthday"]]; //user birthday
                 self.gender = [[result[@"gender"] substringToIndex:1] uppercaseString]; //user gender
                 self.photoURL = [NSString stringWithFormat:@"https://graph.facebook.com/%@/picture?type=large&return_ssl_resources=1", self.fbId]; //profilePicture
                 self.city = result[@"location"][@"name"]; //user location
                 
                 [[NSUserDefaults standardUserDefaults] setObject:self.fbId forKey:@"fbId"];
                 [[NSUserDefaults standardUserDefaults] setObject:self.name forKey:@"name"];
                 [[NSUserDefaults standardUserDefaults] setObject:self.city forKey:@"location"];
                 [[NSUserDefaults standardUserDefaults] setObject:self.photoURL forKey:@"photo"];
                 [[NSUserDefaults standardUserDefaults] synchronize];
                 
                 NSLog(@"User location : %@",self.city);
                 NSLog(@"User age: %d",self.age);
                 [self addNewProfile];
                 [self showMatchPage];
             }
         }];
    }

}

-(void)showMatchPage
{
    MatchPageController *matchPage = [[MatchPageController alloc] initWithNibName:nil bundle:nil];
    matchPage.fbId = self.fbId;
    matchPage.name = self.name;
    matchPage.location = self.city;
    matchPage.photoURL = self.photoURL;
    
    self.window = [[UIWindow alloc] init];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    self.window.rootViewController = matchPage;
}

// Once the button is clicked, show the login dialog
-(void)loginButtonClicked
{
    FBSDKLoginManager *login = [[FBSDKLoginManager alloc] init];
    [login
     logInWithReadPermissions: @[@"public_profile",@"email",@"user_likes",@"user_location",@"email",@"user_birthday"]
     fromViewController:self
     handler:^(FBSDKLoginManagerLoginResult *result, NSError *error) {
         if (error) {
             NSLog(@"Process error");
         } else if (result.isCancelled) {
             NSLog(@"Cancelled");
         } else {
             NSLog(@"Token is initiated : %@",[[FBSDKAccessToken currentAccessToken]tokenString]);
             [self retrieveUserFBData];
         }
     }];
}

-(void)addNewProfile
{
    _nsURL = @"http://www.komagan.com/TinderTraveler/index.php?format=json&operation=addProfile";
    
    self.responseData = [NSMutableData data];
    
    if(self.fbId)
    {
    NSString *myRequestString = [NSString stringWithFormat:@"fbId=%@&name=%@&emailId=%@&photoURL=%@&location=%@&age=%d&gender=%@", self.fbId, self.name, self.emailId, self.photoURL, self.city, self.age, self.gender];
    
    NSLog(@"%@",myRequestString);

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
    //if (response is success)
    //{
    }
    //}
}

- (int) calculateAge:(NSString*)birthDate
{
    NSDate *todayDate = [NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"MM/dd/yyyy"];
    int time = [todayDate timeIntervalSinceDate:[dateFormatter dateFromString:birthDate]];
    int allDays = (((time/60)/60)/24);
    int days = allDays%365;
    int years = (allDays-days)/365;
    NSLog(@"User age : %d",years);
    
    return years;
}
    
-(void) clearUserSession
{
    //[FBSDKAccessToken setCurrentAccessToken:nil];  // use this code if you want to reset facebook login session
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation {
    return [[FBSDKApplicationDelegate sharedInstance] application:application
                                                          openURL:url
                                                sourceApplication:sourceApplication
                                                       annotation:annotation];
}

@end
