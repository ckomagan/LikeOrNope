//
//  GoalController.h
//  LikedOrNope
//
//  Created by Chan Komagan on 5/26/16.
//  Copyright © 2016 modocache. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <FBSDKCoreKit/FBSDKCoreKit.h>
#import <FBSDKLoginKit/FBSDKLoginKit.h>

@interface GoalController : UIViewController
{
    NSMutableData *responseData;
}

@property (strong, nonatomic) IBOutlet UITextField *goalText;
@property (strong, nonatomic) IBOutlet UITextField *cityText;
@property (strong, nonatomic) IBOutlet UITextField *countryText;
@property (strong, nonatomic) IBOutlet UITextField *fromDateText;
@property (strong, nonatomic) IBOutlet UITextField *toDateText;

@property (nonatomic) NSString *goalId;
@property (nonatomic) NSString *goal;
@property (nonatomic) NSString *city;
@property (nonatomic) NSString *country;
@property (nonatomic) NSString *fromDate;
@property (nonatomic) NSString *toDate;

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, retain) NSString *fbId;
@property (nonatomic, strong) NSString *nsURL;

@property (nonatomic, retain) NSMutableData *responseData;

-(IBAction)addGoal;
-(IBAction)cancelGoal;

-(int)checkValidation;

@end
