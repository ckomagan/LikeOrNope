//
//  SettingsController.h
//  TinderTraveler
//
//  Created by Chan Komagan on 10/18/14.
//  Copyright (c) 2014 Chan Komagan. All rights reserved.
//

#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import <UIKit/UIKit.h>

@interface SettingsController : UIViewController <FBSDKLoginButtonDelegate, UITableViewDelegate, UITableViewDataSource>

@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *locationLabel;
@property (strong, nonatomic) IBOutlet UIImageView *backgroundImage;
@property (strong, nonatomic) IBOutlet FBSDKProfilePictureView *profileImage;

@property (strong, nonatomic) NSString *fbId;
@property (strong, nonatomic) NSString *name;
@property (strong, nonatomic) NSString *location;
@property (strong, nonatomic) UIWindow *window;

@end