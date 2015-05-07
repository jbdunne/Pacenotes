//
//  SettingViewController.h
//  lean_pacenotes
//
//  Created by Gene Han on 4/27/15.
//  Copyright (c) 2015 ipg. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <Parse/Parse.h>
#import "DataObject.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>

@class DataObject;

@interface SettingViewController : UIViewController<UISearchBarDelegate>

@property (strong) DataObject * dataObj;


// Start & End location

@property (weak) IBOutlet UISearchBar * fromSearchBar;
@property (weak) IBOutlet UISearchBar * toSearchBar;

@property (strong) MKMapView * mapView;


// AlertTime & AlertDay
@property (weak) IBOutlet UIDatePicker * datePick;

@property (weak) IBOutlet UIButton * monBtn;
@property (weak) IBOutlet UIButton * tueBtn;
@property (weak) IBOutlet UIButton * wedBtn;
@property (weak) IBOutlet UIButton * thuBtn;
@property (weak) IBOutlet UIButton * friBtn;
@property (weak) IBOutlet UIButton * satBtn;
@property (weak) IBOutlet UIButton * sunBtn;

- (IBAction) onDayClicked:(id)sender;



@property (assign) BOOL monOn;
@property (assign) BOOL tueOn;
@property (assign) BOOL wedOn;
@property (assign) BOOL thuOn;
@property (assign) BOOL friOn;
@property (assign) BOOL satOn;
@property (assign) BOOL sunOn;

@property (weak) IBOutlet UIButton * saveBtn;
- (IBAction) onSaveClicked:(id)sender;


// DATA
// Location
@property (strong, nonatomic) CLGeocoder *geocoder;

@property (strong) CLLocation * fromLocation;
@property (strong) CLLocation * toLocation;

@property (strong) NSString * fromAddr;
@property (strong) NSString * toAddr;
//Time
@property (strong) NSDate * date;
//Days
@property (strong) NSString * days;
- (void) loadDataFromOBJ;


// BLOCK WHEN SAVING
@property (strong, nonatomic) UIView * blockView;



- (IBAction) showFromMapBtn:(id)sender;
- (IBAction) showToMapBtn:(id)sender;

@property (strong, nonatomic) UIButton * closeMapBtn;



@end
