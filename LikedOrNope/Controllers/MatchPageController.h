//
//  BucketList Page
//  <App name>
//
//  Created by Chan Komagan on 10/15/14.
//  Copyright (c) 2015 TinderTraveler. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>
#import "ChoosePersonView.h"

@interface MatchPageController : UIViewController <FBSDKLoginButtonDelegate, UITableViewDelegate, UITableViewDataSource>
{
    NSMutableData *responseData;
}

     @property (strong, nonatomic) IBOutlet UIImageView *profilePictureView;
     @property (nonatomic, strong) Person *currentPerson;
     @property (nonatomic, strong) ChoosePersonView *frontCardView;
     @property (nonatomic, strong) ChoosePersonView *backCardView;
     @property (nonatomic, retain) NSString *fbId;
     @property (strong, nonatomic) IBOutlet UIButton *settingsBtn;
     @property (strong, nonatomic) IBOutlet UIButton *chatBtn;
     @property (nonatomic, retain) NSString *emailId;
     @property (nonatomic, strong) NSString *photoURL;
     @property (nonatomic) NSString *name;
     @property (nonatomic) NSString *location;
     @property (nonatomic) NSString *goal;
     @property (nonatomic) NSString *travelCity;
     @property (nonatomic) NSString *fromDate;
     @property (nonatomic) NSString *toDate;

     @property (nonatomic) int userAge;
     @property (nonatomic) NSString *userGender;
     @property (nonatomic) NSString *userZip;
     @property (nonatomic, strong) NSString *urlPrefix;
     @property (nonatomic, strong) UIImage *myProfileImage;
     @property (nonatomic, retain) NSMutableData *responseData;


-(void)addToLikeList;
-(void)addtoNopeList;

-(IBAction)showSettingsPage;
-(IBAction)showChatPage;

@end
