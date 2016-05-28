//
//  Home Page
//  <App name>
//
//  Created by Chan Komagan on 10/15/14.
//  Copyright (c) 2015 KidsIQ. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>

@interface BucketPageController : UIViewController <FBSDKLoginButtonDelegate, UITableViewDelegate, UITableViewDataSource>
 {
       NSMutableData *responseData;
 }

@property (strong, nonatomic) IBOutlet UIButton *addGoalBtn;
@property (strong, nonatomic) IBOutlet UITableView *tableView;
@property (nonatomic) NSString *fbId;
@property (nonatomic) NSString *goalId;
@property (nonatomic) NSString *goal;
@property (nonatomic) NSString *city;
@property (nonatomic) NSString *country;
@property (nonatomic) NSString *fromDate;
@property (nonatomic) NSString *toDate;

@property (nonatomic, strong) NSString *nsURL;
@property (strong, nonatomic) UIWindow *window;

-(IBAction)showSettingsPage;
-(IBAction)showMatchPage;

-(IBAction)addGoal;
@end
