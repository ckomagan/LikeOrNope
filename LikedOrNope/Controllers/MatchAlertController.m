//
//  MatchAlertController.m
//  TinderTraveler
//
//  Created by Chan Komagan on 10/31/14.
//  Copyright (c) 2014 Chan Komagan. All rights reserved.
//

#include <stdio.h>


#import "MatchAlertController.h"
#import "MatchPageController.h"
#import "SettingsController.h"

@implementation MatchAlertController
@synthesize matchName;
@synthesize matchGoalLocation;
@synthesize matchGoalFromDate;
@synthesize matchGoalToDate;
@synthesize matchfbId;
@synthesize matchProfileImage;

NSDictionary *res;

- (void) viewDidLoad {
    
    self.matchAlertLabel.text = [@"You matched with " stringByAppendingString:matchName];
    NSString *matchNameText = @"Like you, ";
    matchNameText = [matchName stringByAppendingString:@" is also traveling to "];
    matchNameText = [matchNameText stringByAppendingString:matchGoalLocation];
    NSString *photoURL = [[NSUserDefaults standardUserDefaults] valueForKey:@"photo"];

    self.shareMessageLabel.text = [matchNameText stringByAppendingString:@"."];
    //self.goalMessageLabel.text = [@"She is traveling to " stringByAppendingString:matchGoalLocation];

    [self.profilePictureView2 setImage:matchProfileImage];
    self.profilePictureView2.layer.cornerRadius = self.profilePictureView.frame.size.height / 2;
    self.profilePictureView2.layer.masksToBounds = YES;
    self.profilePictureView2.layer.borderWidth = 0;
    
    NSData *data = [NSData dataWithContentsOfURL:[NSURL URLWithString:photoURL]];
    UIImage *image = [UIImage imageWithData:data];

    [self.profilePictureView setImage:image];
    self.profilePictureView.layer.cornerRadius = self.profilePictureView2.frame.size.height / 2;
    self.profilePictureView.layer.masksToBounds = YES;
    self.profilePictureView.layer.borderWidth = 0;
    
    self.messageBtn.layer.masksToBounds = YES;
    self.messageBtn.layer.cornerRadius = 20.0f;
    self.laterBtn.layer.masksToBounds = YES;
    self.laterBtn.layer.cornerRadius = 20.0f;
    /*
    UIButton *testBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    testBtn.frame = CGRectMake(32, 100, 77, 32);
    
    [testBtn setTitle:@"Testingg.." forState:UIControlStateNormal];
    [testBtn setTitleColor:[UIColor redColor] forState:UIControlStateNormal];
    [testBtn addTarget:self action:@selector(showTest:) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:testBtn];
    */
    [super viewDidLoad];
    }

- (void)loginViewFetchedUserInfo
{
    if ([FBSDKAccessToken currentAccessToken])
    {
        NSLog(@"Token is available : %@",[[FBSDKAccessToken currentAccessToken]tokenString]);
        
        [[[FBSDKGraphRequest alloc] initWithGraphPath:@"me" parameters:@{@"fields": @"id, name, link, first_name, last_name, picture.type(large), email, birthday, bio ,location ,friends ,hometown , friendlists"}]
         startWithCompletionHandler:^(FBSDKGraphRequestConnection *connection, id result, NSError *error) {
             if (!error)
             {
                 NSLog(@"resultis:%@",result);
             }
             else
             {
                 NSLog(@"Error %@",error);
             }
         }];
        
    }
}

-(IBAction) showMatchPage {
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    self.window.backgroundColor = [UIColor whiteColor];
    [self.window makeKeyAndVisible];
    self.window.rootViewController = [MatchPageController new];
}

-(IBAction) showSettingsPage {
    SettingsController *settingsView = [[SettingsController alloc] initWithNibName:@"MatchAlert" bundle:nil];
    settingsView.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:settingsView animated:YES completion:nil];
}

-(IBAction) showChatPage {
    SettingsController *settingsView = [[SettingsController alloc] initWithNibName:@"MatchAlert" bundle:nil];
    settingsView.modalTransitionStyle = UIModalTransitionStyleFlipHorizontal;
    [self presentViewController:settingsView animated:YES completion:nil];
}

-(void)showTest:(UIButton *)button
{
    UIStoryboard *storyboard = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    SettingsController *myVC = (SettingsController *)[storyboard instantiateViewControllerWithIdentifier:@"SettingsPage"];
    /*
     self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
     self.window.backgroundColor = [UIColor whiteColor];
     [self.window makeKeyAndVisible];
     self.window.rootViewController = [SettingsController new];*/
}

@end