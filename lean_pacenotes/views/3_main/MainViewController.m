//
//  MainViewController.m
//  lean_pacenotes
//
//  Created by Gene Han on 5/2/15.
//  Copyright (c) 2015 ipg. All rights reserved.
//

#import "MainViewController.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.navigationController.navigationBar setBackgroundImage:[UIImage new] forBarMetrics:UIBarMetricsDefault];
    self.navigationController.navigationBar.shadowImage = [UIImage new];
    self.navigationController.navigationBar.translucent = YES;
    [self.navigationController.navigationBar setUserInteractionEnabled:NO];
    self.navigationController.navigationBar.tintColor = [UIColor whiteColor];

    
    // TOPVIEW
    _settingBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_settingBtn setFrame:CGRectMake(20, 66, 30, 30)];
    [_settingBtn setBackgroundImage:[UIImage imageNamed:@"gear"] forState:UIControlStateNormal];
    [_settingBtn addTarget:self action:@selector(onShowSettingBtn) forControlEvents:UIControlEventTouchUpInside];
    [_topView addSubview: _settingBtn];
    
    _topGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(onHideSettingBtn)];
    _topGesture.numberOfTapsRequired = 1;
    
    
    // BOTVIEW
    _howBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_howBtn setFrame:CGRectMake(0, 100, 200, 50)];
    [_howBtn setTitle:@"HOW TO USE" forState:UIControlStateNormal];
    [_howBtn addTarget:self action:@selector(onHowToBtn) forControlEvents:UIControlEventTouchUpInside];
    [_botView addSubview:_howBtn];
    
    _setBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_setBtn setFrame:CGRectMake(0, 200, 200, 50)];
    [_setBtn setTitle:@"SETTINGS" forState:UIControlStateNormal];
    [_setBtn addTarget:self action:@selector(onSetBtn) forControlEvents:UIControlEventTouchUpInside];
    [_botView addSubview:_setBtn];
    
    _logOutBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_logOutBtn setFrame:CGRectMake(0, 300, 200, 50)];
    [_logOutBtn setTitle:@"LOG OUT" forState:UIControlStateNormal];
    [_logOutBtn addTarget:self action:@selector(onLogOutBtn) forControlEvents:UIControlEventTouchUpInside];
    [_botView addSubview:_logOutBtn];
  //  [_botView setUserInteractionEnabled:NO];

    // Data
    _dataObj = [DataObject sharedObject];
    if( _dataObj.mainVC == nil ){
        _dataObj.mainVC = self;
    }
    [self.view addSubview: _botView];
    [self.view addSubview: _topView];
    [_topView addGestureRecognizer:_topGesture];
}


- (void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self becomeFirstResponder];
    [_settingBtn removeTarget:self action:@selector(onShowSettingBtn) forControlEvents:UIControlEventTouchUpInside ];
    [_settingBtn addTarget:self action:@selector(onShowSettingBtn) forControlEvents:UIControlEventTouchUpInside];
}


// TOP

- (void) onShowSettingBtn{

    CGRect hideRect = CGRectMake(200, 0, _topView.bounds.size.width, _topView.bounds.size.height);
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(onTopHidden)];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];

    
    [_topView setFrame:hideRect];
    
    [UIView commitAnimations];

}

- (void) onTopHidden{
  //  [_topView addGestureRecognizer:_topGesture];
  //  [_botView setUserInteractionEnabled:YES];
    NSLog(@"[TOPVIEW] interacting YES");
}

-(void) onTopShown{
  //  [_botView setUserInteractionEnabled:NO];
    NSLog(@"[TOPVIEW] interacting NOT");
}


- (void) onHideSettingBtn{
  //  [_topView removeGestureRecognizer:_topGesture];

    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDelegate:self];
    [UIView setAnimationDidStopSelector:@selector(onTopShown)];
    [UIView setAnimationDuration:0.5];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseOut];
    
    [_topView setFrame:[[UIScreen mainScreen] bounds]];
    [UIView commitAnimations];

}







// BOT

- (void) onHowToBtn{
    _onVC = (OnboardingViewController *) [_dataObj onBoardVC];
    
    
        if( _dataObj == nil){
            _dataObj = [DataObject sharedObject];
        }
        
        OnboardingContentViewController *firstPage = [OnboardingContentViewController contentWithTitle:@"Pacenotes" body:@"Driver-specific alerts for safer trips ahead of schedule." image:[UIImage imageNamed:@"layers"] buttonText:@"" action:^{
            [[[UIAlertView alloc] initWithTitle:nil message:@"Here you can prompt users for various application permissions, providing them useful information about why you'd like those permissions to enhance their experience, increasing your chances they will grant those permissions." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
        }];
        
        OnboardingContentViewController *secondPage = [OnboardingContentViewController contentWithTitle:@"Safer travels" body:@"Avoid dangerous weather conditions on the road." image:[UIImage imageNamed:@"cone"] buttonText:@"" action:^{
            [[[UIAlertView alloc] initWithTitle:nil message:@"Facebook connected." delegate:nil cancelButtonTitle:@"OK" otherButtonTitles:nil] show];
        }];
        
        OnboardingContentViewController *thirdPage = [OnboardingContentViewController contentWithTitle:@"Efficient trips" body:@"Know live traffic patterns before they throw you off." image:[UIImage imageNamed:@"coffee"] buttonText:@"" action:nil];
        
        
        _onVC = [OnboardingViewController onboardWithBackgroundImage:[UIImage imageNamed:@"street"] contents:@[firstPage, secondPage, thirdPage]];
        _onVC.shouldFadeTransitions = YES;
        _onVC.fadePageControlOnLastPage = YES;
        
        // If you want to allow skipping the onboarding process, enable skipping and set a block to be executed
        // when the user hits the skip button.
        _onVC.allowSkipping = NO;
  
        
        _dataObj.onBoardVC = _onVC;
    
    

    [self.navigationController pushViewController:_onVC animated:YES];
//    [self presentViewController:_onVC animated:YES completion:nil];
    
}

- (void) onSetBtn{
    UIStoryboard * sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    SettingViewController * svc = [sb instantiateViewControllerWithIdentifier:@"SettingVC"];
    
    [self.navigationController pushViewController:svc animated:YES];

}

- (void) onLogOutBtn{
}




// GEN





@end
