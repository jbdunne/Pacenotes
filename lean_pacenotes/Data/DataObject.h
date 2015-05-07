//
//  DataObject.h
//  lean_pacenotes
//
//  Created by Gene Han on 4/27/15.
//  Copyright (c) 2015 ipg. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <Parse/Parse.h>
#import "OnboardingViewController.h"
#import "SettingViewController.h"
#import <CoreLocation/CoreLocation.h>



@interface DataObject : NSObject


+ (id) sharedObject;

@property (strong) PFUser * user;

@property (strong, nonatomic) OnboardingViewController * onBoardVC;
@property (strong, nonatomic) UIViewController * settingVC;
@property (strong, nonatomic) UIViewController * mainVC;


// Settings Data
@property (strong) CLLocation * fromLocation;
@property (strong) CLLocation * toLocation;

@property (strong) NSString * fromAddr;
@property (strong) NSString * toAddr;

@property (strong) NSString * days;
@property (strong) NSDate * date;


@end
