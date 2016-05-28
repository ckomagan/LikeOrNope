//
//  HomePage
//  <App name>
//
//  Created by Chan Komagan on 10/15/14.
//  Copyright (c) 2015 TinderTraveler. All rights reserved.
//

#import <UIKit/UIKit.h>
//#import <FacebookSDK/FacebookSDK.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
@interface HomePageController : UIViewController
{
    NSMutableData *responseData;
}

     @property (strong, nonatomic) IBOutlet UILabel *nameLabel;
     @property (strong, nonatomic) IBOutlet UILabel *ageLabel;
     @property (nonatomic) NSString *fbId;
     @property (nonatomic) NSString *emailId;
     @property (nonatomic) NSString *userName;
     @property (nonatomic) NSString *userLocation;
     @property (nonatomic) NSString *userAge;
     @property (nonatomic) NSString *userGender;
     @property (nonatomic) NSString *userZip;
     @property (strong, nonatomic) IBOutlet UIButton *matchsBtn;
     @property (strong, nonatomic) IBOutlet UIButton *appSettingsBtn;
     @property (strong, nonatomic) IBOutlet UIButton *chatBtn;
     @property (strong, nonatomic) IBOutlet UIButton *bucketListBtn;
     @property (nonatomic, strong) NSString *nsURL;
     @property (nonatomic, retain) NSMutableData *responseData;

@end