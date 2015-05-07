//
//  LoginViewController.m
//  lean_pacenotes
//
//  Created by Gene Han on 4/20/15.
//  Copyright (c) 2015 ipg. All rights reserved.
//

#import "LoginViewController.h"

@interface LoginViewController ()

@end

@implementation LoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    _bgView = [[UIImageView alloc] initWithFrame:self.view.bounds];
    _bgView.contentMode = UIViewContentModeScaleAspectFill;
    [_bgView setImage:[UIImage imageNamed:@"street"]];
    [self.view addSubview:_bgView];
    
    
}

- (void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    if( [PFUser currentUser]){
        NSLog(@"User logged in through Facebook!");
        UIStoryboard * sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
        SettingViewController * svc = [sb instantiateViewControllerWithIdentifier:@"MainVC"];
        if( _dataObj == nil){
            _dataObj = [DataObject sharedObject];
        }
        _dataObj.settingVC = svc;
        
        [self presentViewController:svc animated:YES completion:nil];
    }else{
        [self presentViewController:[self generateFirstDemoVC] animated:NO completion:nil];
    }
}



- (OnboardingViewController *)generateFirstDemoVC {
    OnboardingContentViewController *firstPage = [OnboardingContentViewController contentWithTitle:@"Pacenotes" body:@"Driver-specific alerts for safer trips ahead of schedule." image:[UIImage imageNamed:@"layers"] buttonText:@"" action:^{
        [[[UIAlertView alloc] initWithTitle:nil message:@"Here you can prompt users for various application permissions, providing them useful information about why you'd like those permissions to enhance their experience, increasing your chances they will grant those permissions." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
    }];
    
    OnboardingContentViewController *secondPage = [OnboardingContentViewController contentWithTitle:@"Safer travels" body:@"Avoid dangerous weather conditions on the road." image:[UIImage imageNamed:@"cone"] buttonText:@"" action:^{
        [[[UIAlertView alloc] initWithTitle:nil message:@"Facebook connected." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
    }];
    
    OnboardingContentViewController *thirdPage = [OnboardingContentViewController contentWithTitle:@"Efficient trips" body:@"Know live traffic patterns before they throw you off." image:[UIImage imageNamed:@"coffee"] buttonText:@"Login with Facebook" action:^{
        [self onLoginBtn];
    }];

    
    _onVC = [OnboardingViewController onboardWithBackgroundImage:[UIImage imageNamed:@"street"] contents:@[firstPage, secondPage, thirdPage]];
    _onVC.shouldFadeTransitions = YES;
    _onVC.fadePageControlOnLastPage = YES;
    
    // If you want to allow skipping the onboarding process, enable skipping and set a block to be executed
    // when the user hits the skip button.
    _onVC.allowSkipping = NO;
    _onVC.skipHandler = ^{
        [self onLoginBtn];
    };
    if( _dataObj == nil){
        _dataObj = [DataObject sharedObject];
    }
    _dataObj.onBoardVC = _onVC;
    
    return _onVC;
}


















- (void) onLoginBtn{
    // Login PFUser using Facebook no fb permission asked.
    [PFFacebookUtils logInInBackgroundWithPublishPermissions:nil block:^(PFUser *user, NSError *error){
        if (!user) {
            NSLog(@"Uh oh. The user cancelled the Facebook login.");
        } else if (user.isNew) {
            [_dataObj setUser:user];
            NSLog(@"User signed up and logged in through Facebook!");
        } else {
            [_dataObj setUser:user];
            NSLog(@"User logged in through Facebook!");
            UIStoryboard * sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
            SettingViewController * svc = [sb instantiateViewControllerWithIdentifier:@"SettingVC"];
            if( _dataObj == nil){
                _dataObj = [DataObject sharedObject];
                _dataObj.settingVC = svc;
            }
            [_onVC presentViewController:svc animated:YES completion:nil];
            if( _dataObj == nil){
                _dataObj = [DataObject sharedObject];
                _dataObj.settingVC = svc;
            }
        }
    }];
    
}



- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender{
    if( [[segue identifier] isEqualToString:@"SettingSegue" ]){

    }else{
    
    }
}


@end

