//
//  MatchAlertController.h
//  TinderTraveler
//
//  Created by Chan Komagan on 10/31/14.
//  Copyright (c) 2014 Chan Komagan. All rights reserved.
//


#import <UIKit/UIKit.h>
//#import <FacebookSDK/FacebookSDK.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import "ChoosePersonView.h"
#import "Person.h"

@interface MatchAlertController : UIViewController
{
    NSMutableData *responseData;
}

@property (strong, nonatomic) IBOutlet UILabel *matchAlertLabel;
@property (strong, nonatomic) IBOutlet UILabel *shareMessageLabel;
@property (strong, nonatomic) IBOutlet UILabel *goalMessageLabel;
@property (strong, nonatomic) IBOutlet UIImageView *profilePictureView, *profilePictureView2;
@property (strong, nonatomic) IBOutlet UIButton *messageBtn;
@property (strong, nonatomic) IBOutlet UIButton *laterBtn;
@property (strong, nonatomic) IBOutlet UIButton *settingsBtn;
@property (strong, nonatomic) IBOutlet UIButton *chatBtn;

@property (nonatomic) NSString *matchfbId;
@property (nonatomic, strong) NSString *matchName;
@property (nonatomic, strong) NSString *matchGoalLocation;
@property (nonatomic, strong) NSString *matchGoalFromDate;
@property (nonatomic, strong) NSString *matchGoalToDate;
@property (nonatomic, strong) UIImage *matchProfileImage;
@property (nonatomic, strong) UIImage *myProfileImage;
@property (strong, nonatomic) UIWindow *window;

-(IBAction)showMatchPage;
-(IBAction)showSettingsPage;
-(IBAction)showChatPage;

@end