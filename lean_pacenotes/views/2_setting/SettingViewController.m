
//
//  SettingViewController.m
//  lean_pacenotes
//
//  Created by Gene Han on 4/27/15.
//  Copyright (c) 2015 ipg. All rights reserved.
//

#import "SettingViewController.h"

@interface SettingViewController ()

@end

@implementation SettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // DEMO only, defaults to false;
    _monOn = false;
    _tueOn = false;
    _wedOn = false;
    _thuOn = false;
    _friOn = false;
    _satOn = false;
    _sunOn = false;
    
    // local data
    _dataObj = [DataObject sharedObject];
    
    // tab
    UITapGestureRecognizer *tapGesture = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(handleSingleTap:)];
    tapGesture.numberOfTapsRequired = 1;
    [self.view addGestureRecognizer:tapGesture];
    
    _blockView = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [_blockView setBackgroundColor:[UIColor colorWithRed:0 green:0 blue:0 alpha:0.8]];

    
    
    // MAP
    CGRect rect = [[UIScreen mainScreen] bounds];
    _mapView = [[MKMapView alloc] initWithFrame:CGRectMake(0, 64, rect.size.width, rect.size.height - 64)];
    
    // CLOSE BTN
    _closeMapBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    [_closeMapBtn setTitle:@"Done" forState:UIControlStateNormal];
    [_closeMapBtn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [_closeMapBtn setFrame:CGRectMake(rect.size.width- 70, 20, 70, 44)];
    [_closeMapBtn addTarget:self action:@selector(closeMap) forControlEvents:UIControlEventTouchUpInside];
    
}

- (void) viewDidAppear:(BOOL)animated{
    [super viewDidAppear:animated];
    [self loadDataFromOBJ];
}

- (void) handleSingleTap:(id) obj{
    [_fromSearchBar resignFirstResponder];
    [_toSearchBar resignFirstResponder];
}

- (void) showBlock{
    [self.view setUserInteractionEnabled:NO];
    [self.view addSubview:_blockView];
}

- (void) hideBlock{
    [self.view setUserInteractionEnabled:YES];
    [_blockView removeFromSuperview];
}




-(IBAction) onDayClicked:(id)sender{
    UIButton * btn = (UIButton * ) sender;
    switch ( btn.tag) {
        case 1:
            _monOn = !_monOn;
            [self updateBtnAt:1];
            break;
        case 2:
            _tueOn = !_tueOn;
            [self updateBtnAt:2];
            break;
        case 3:
            _wedOn = !_wedOn;
            [self updateBtnAt:3];
            break;
        case 4:
            _thuOn = !_thuOn;
            [self updateBtnAt:4];
            break;
        case 5:
            _friOn = !_friOn;
            [self updateBtnAt:5];
            break;
        case 6:
            _satOn = !_satOn;
            [self updateBtnAt:6];
            break;
        case 7:
            _sunOn = !_sunOn;
            [self updateBtnAt:7];
            break;
            
        default:
            break;
    }
    
}

- (void) updateBtnAt:(NSInteger) at{
    switch (at) {
        case 1:
            if( _monOn){
                [_monBtn setBackgroundColor:[UIColor grayColor]];
            }else{
                [_monBtn setBackgroundColor:[UIColor darkGrayColor]];
            }
            break;
        case 2:
            if( _tueOn){
                [_tueBtn setBackgroundColor:[UIColor grayColor]];
            }else{
                [_tueBtn setBackgroundColor:[UIColor darkGrayColor]];
            }
            break;
        case 3:
            if( _wedOn){
                [_wedBtn setBackgroundColor:[UIColor grayColor]];
            }else{
                [_wedBtn setBackgroundColor:[UIColor darkGrayColor]];
            }
            break;
        case 4:
            if( _thuOn){
                [_thuBtn setBackgroundColor:[UIColor grayColor]];
            }else{
                [_thuBtn setBackgroundColor:[UIColor darkGrayColor]];
            }
            break;
        case 5:
            if( _friOn){
                [_friBtn setBackgroundColor:[UIColor grayColor]];
            }else{
                [_friBtn setBackgroundColor:[UIColor darkGrayColor]];
            }
            break;
        case 6:
            if( _satOn){
                [_satBtn setBackgroundColor:[UIColor grayColor]];
            }else{
                [_satBtn setBackgroundColor:[UIColor darkGrayColor]];
            }
            break;
        case 7:
            if( _sunOn){
                [_sunBtn setBackgroundColor:[UIColor grayColor]];
            }else{
                [_sunBtn setBackgroundColor:[UIColor darkGrayColor]];
            }
            break;
            
        default:
            break;
    }

}



- (IBAction)onSaveClicked:(id)sender{
    
    
    
    // AlertTime
    _date = _datePick.date;
    NSLog(@"[SETTING] DATE: %@", _date );
    [[PFUser currentUser] setObject:_date forKey:@"AlertTime"];
    
    // AlertDay
    _days = [self getDates];
    
    [[PFUser currentUser] setObject:_days forKey:@"AlertDay"];
    
    // from & to
    if( _fromLocation && _toLocation){
        PFGeoPoint * fromPoint = [PFGeoPoint geoPointWithLocation:_fromLocation];
        PFGeoPoint * toPoint = [PFGeoPoint geoPointWithLocation:_toLocation];
    
        [[PFUser currentUser] setObject:fromPoint forKey:@"GeoFrom"];
        [[PFUser currentUser] setObject:toPoint forKey:@"GeoTo"];
    }
    
    
    // Device ID
    
    NSData * deviceToken = [[NSUserDefaults standardUserDefaults] objectForKey:@"DeviceToken"];
    if( deviceToken ){
        [[PFUser currentUser] setObject:deviceToken forKey:@"iOS_device_id"];
    }
    
    [self showBlock];
    [[PFUser currentUser] saveInBackgroundWithBlock:^(BOOL succeeded, NSError *error){
        NSLog(@"[SETTING] update AlertDay Complete");
//        [self hideBlock];
        [self hideBlock];
        UIStoryboard * sb = [UIStoryboard storyboardWithName:@"Main" bundle:nil];
    
        
        UINavigationController * mvc = (UINavigationController*)[sb instantiateViewControllerWithIdentifier:@"MainVC"];
        [self presentViewController:mvc animated:YES completion:nil];
        
    }];
    [self saveDataToOBJ];

    NSLog(@"[SETTING] update AlertDay");
}


- (NSString *) getDates{
    NSString * dates = @"";
    if( _monOn ){
        dates = [dates stringByAppendingString:@"1"];
    }else{
        dates = [dates stringByAppendingString:@"0"];
    }
    
    if( _tueOn ){
        dates = [dates stringByAppendingString:@"1"];
    }else{
        dates = [dates stringByAppendingString:@"0"];
    }
    
    if( _wedOn ){
        dates = [dates stringByAppendingString:@"1"];
    }else{
        dates = [dates stringByAppendingString:@"0"];
    }
    
    if( _thuOn ){
        dates = [dates stringByAppendingString:@"1"];
    }else{
        dates = [dates stringByAppendingString:@"0"];
    }
    
    if( _friOn ){
        dates = [dates stringByAppendingString:@"1"];
    }else{
        dates = [dates stringByAppendingString:@"0"];
    }
    
    if( _satOn ){
        dates = [dates stringByAppendingString:@"1"];
    }else{
        dates = [dates stringByAppendingString:@"0"];
    }
    
    if( _sunOn ){
        dates = [dates stringByAppendingString:@"1"];
    }else{
        dates = [dates stringByAppendingString:@"0"];
    }
    
    return dates;
    

}

-(void)setView:(UIView*)view {
    if(view != nil) {
        [super setView:view];
    }
}


/*
-(void)searchBarSearchButtonClicked:(UISearchBar *)theSearchBar
{
 
    [theSearchBar resignFirstResponder];
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    [geocoder geocodeAddressString:theSearchBar.text completionHandler:^(NSArray *placemarks, NSError *error) {
        //Error checking
        
        CLPlacemark *placemark = [placemarks objectAtIndex:0];
        MKCoordinateRegion region;
        region.center.latitude = placemark.region.center.latitude;
        region.center.longitude = placemark.region.center.longitude;
        MKCoordinateSpan span;
        double radius = placemark.region.radius / 1000; // convert to km
        
        NSLog(@"[searchBarSearchButtonClicked] Radius is %f", radius);
        span.latitudeDelta = radius / 112.0;
        
        region.span = span;
        
        [theMapView setRegion:region animated:YES];
    }];
 
}

*/

#pragma mark - UISearchBarDelegat
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    [searchBar resignFirstResponder];
    
    if( _geocoder == nil){
        _geocoder = [[CLGeocoder alloc]init];
    }
    
    
    // FROM
    if( searchBar.tag == 1){
        NSString * address = [searchBar text];
        [_geocoder geocodeAddressString:address completionHandler:^(NSArray* placemarks, NSError * error){
            if( placemarks.count >0 ){
                CLPlacemark * placemark = [placemarks objectAtIndex:0];
                NSLog(@"[GeoCode - FROM] la:%f, lo:%f", placemark.location.coordinate.latitude, placemark.location.coordinate.longitude );
                _fromLocation = placemark.location;
                _fromAddr = [searchBar text];

            }else{
                NSLog(@"[GeoCode - FROM] not found");
                _fromLocation = nil;
                _fromAddr = nil;
            }
        }];
        
    }else if( searchBar.tag == 2){
        NSString * address = [searchBar text];
        [_geocoder geocodeAddressString:address completionHandler:^(NSArray* placemarks, NSError * error){
            if( placemarks.count >0 ){
                CLPlacemark * placemark = [placemarks objectAtIndex:0];
                NSLog(@"[GeoCode - TO] la:%f, lo:%f", placemark.location.coordinate.latitude, placemark.location.coordinate.longitude );
                _toLocation = placemark.location;
                _toAddr = [searchBar text];
            }else{
                NSLog(@"[GeoCode - TO] not found");
                _toLocation = nil;
                _toAddr = nil;
            }
        }];
    
    }
}


- (IBAction) showFromMapBtn:(id)sender{
    if( _fromLocation == nil){
        return;
    }
    
    
    MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
    [annotation setCoordinate:_fromLocation.coordinate];
    [annotation setTitle:@"FROM"]; //You can set the subtitle too
    
    MKCoordinateRegion region =  MKCoordinateRegionMakeWithDistance(annotation.coordinate, 1000, 1000);

    
    [_mapView addAnnotation:annotation];
    [_mapView setRegion:region animated:YES];
    [self.view addSubview:_mapView];
    [self.view addSubview:_closeMapBtn];
}

- (IBAction) showToMapBtn:(id)sender{
    if( _toLocation == nil){
        return;
    }
    MKPointAnnotation *annotation = [[MKPointAnnotation alloc] init];
    [annotation setCoordinate:_toLocation.coordinate];
    [annotation setTitle:@"TO"]; //You can set the subtitle too
    
    MKCoordinateRegion region =  MKCoordinateRegionMakeWithDistance(annotation.coordinate, 1000, 1000);

    [_mapView addAnnotation:annotation];
    [_mapView setRegion:region animated:YES];
    [self.view addSubview:_mapView];
    [self.view addSubview:_closeMapBtn];

}



- (void) closeMap{
    [_mapView removeFromSuperview];
    [_closeMapBtn removeFromSuperview];
    [_mapView removeAnnotations:[_mapView annotations]];
}


- (void) saveDataToOBJ{
    if( _dataObj == nil ){
        _dataObj = [DataObject sharedObject];
    }
    
    _dataObj.fromAddr = [_fromAddr copy];
    _dataObj.fromLocation = [_fromLocation copy];
    
    _dataObj.toAddr = [_toAddr copy];
    _dataObj.toLocation = [_toLocation copy];
    
    _dataObj.date = [_date copy];
    _dataObj.days = [_days copy];
    
}

- (void) loadDataFromOBJ{
    if( _dataObj == nil){
        _dataObj = [DataObject sharedObject];
    }
    
    _fromAddr = _dataObj.fromAddr;
    [_fromSearchBar setText:_fromAddr];
    _fromLocation = _dataObj.fromLocation;
    
    _toAddr = _dataObj.toAddr;
    [_toSearchBar setText:_toAddr];
    _toLocation = _dataObj.toLocation;
    
    _date = _dataObj.date;
    if( _date)
        [_datePick setDate:_date];
    
    _days = _dataObj.days;
    [self drawDays];
    
}

- (void) drawDays{
    if( _days  == nil)
        return;
    
    if( [_days characterAtIndex:0] == '1'){
        _monOn = true;
    }else{
        _monOn = false;
    }
    [self updateBtnAt:1];
    
    if( [_days characterAtIndex:1] == '1'){
        _tueOn = true;
    }else{
        _tueOn = false;
    }
    [self updateBtnAt:2];
    
    if( [_days characterAtIndex:2] == '1'){
        _wedOn = true;
    }else{
        _wedOn = false;
    }
    [self updateBtnAt:3];
    
    if( [_days characterAtIndex:3] == '1'){
        _thuOn = true;
    }else{
        _thuOn = false;
    }
    [self updateBtnAt:4];
    
    if( [_days characterAtIndex:4] == '1'){
        _friOn = true;
    }else{
        _friOn = false;
    }
    [self updateBtnAt:5];
    
    if( [_days characterAtIndex:5] == '1'){
        _satOn = true;
    }else{
        _satOn = false;
    }
    [self updateBtnAt:6];
    
    if( [_days characterAtIndex:6] == '1'){
        _sunOn = true;
    }else{
        _sunOn = false;
    }
    [self updateBtnAt:7];

}




@end
