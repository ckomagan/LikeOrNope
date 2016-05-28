//
//  SignInController.h
//  TinderTraveler
//
//  Created by Chan Komagan on 10/18/14.
//  Copyright (c) 2014 Chan Komagan. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
@interface SignInController : UIViewController <FBSDKLoginButtonDelegate>

@property (nonatomic, strong) IBOutlet UIButton *logoutButton;
@property (strong, nonatomic) IBOutlet FBSDKProfilePictureView *profilePictureView;
@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *statusLabel;
@property (strong, nonatomic) NSString *objectID;

@property (nonatomic, retain) NSString *fbId;
@property (nonatomic) NSString *name;
@property (nonatomic) NSString *emailId;
@property (nonatomic) NSString *birthDay;
@property (nonatomic, strong) NSString *photoURL;
@property (nonatomic) NSString *gender;
@property (retain, nonatomic) NSString *city;
@property (retain, nonatomic) NSString *zip;
@property (nonatomic) bool *paidFlag;
@property (nonatomic, strong) NSString *nsURL;
@property (nonatomic, retain) NSMutableData *responseData;
@property (strong, nonatomic) UIWindow *window;
@property (nonatomic) int age;

-(void)clearUserSession;
-(void)retrieveUserFBData;
-(void)addNewProfile;
-(int)calculateAge:(NSString*)birthDay;

@end
