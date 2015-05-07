  //
//  MainViewController.h
//  lean_pacenotes
//
//  Created by Gene Han on 5/2/15.
//  Copyright (c) 2015 ipg. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DataObject.h"
#import "OnboardingViewController.h"
#import "SettingViewController.h"
#import "OnboardingContentViewController.h"
#import <MapKit/MapKit.h>

@interface MainViewController : UIViewController

// BOTTOM
@property (strong, nonatomic) IBOutlet UIView * botView;
@property (strong, nonatomic) UIButton * howBtn;
@property (strong, nonatomic) UIButton * setBtn;
@property (strong, nonatomic) UIButton * logOutBtn;

// TOP
@property (strong, nonatomic) IBOutlet UIView * topView;
@property (strong, nonatomic) UIButton * settingBtn;
@property (strong, nonatomic) UITapGestureRecognizer * topGesture;

// DataObj
@property (strong, nonatomic) DataObject * dataObj;
@property (strong, nonatomic) OnboardingViewController * onVC;


//
@property (strong, nonatomic) MKMapView * mapView;
@end
