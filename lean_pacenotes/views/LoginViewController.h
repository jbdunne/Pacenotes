//
//  LoginViewController.h
//  lean_pacenotes
//
//  Created by Gene Han on 4/20/15.
//  Copyright (c) 2015 ipg. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import <ParseFacebookUtilsV4/PFFacebookUtils.h>
#import "DataObject.h"
#import "OnboardingViewController.h"
#import "SettingViewController.h"

@interface LoginViewController : UIViewController

@property (strong, nonatomic) UIButton * loginBtn;

@property (strong) DataObject * dataObj;

@property (strong) OnboardingViewController * onVC;
@property (strong, nonatomic) UIImageView * bgView;




@end
