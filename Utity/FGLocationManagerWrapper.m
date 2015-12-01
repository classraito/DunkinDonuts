//
//  FGLocationManagerWrapper.m
//  DunkinDonuts
//
//  Created by Ryan Gong on 15/11/26.
//  Copyright © 2015年 Ryan Gong. All rights reserved.
//

#import "FGLocationManagerWrapper.h"
#import "Global.h"
#include <MapKit/MapKit.h>
@implementation FGLocationManagerWrapper
@synthesize locationManager;
@synthesize delegate;
@synthesize currentLontitude;
@synthesize currentLatitude;
@synthesize str_currentCity;
+(instancetype)sharedManager {
    static dispatch_once_t onceToken;
    static FGLocationManagerWrapper *instance;
    dispatch_once(&onceToken, ^{
        instance = [[FGLocationManagerWrapper alloc] init];
        //创建CLLocationManager对象
        
    });
    return instance;
}

-(BOOL )startUpdatingLocation:(void (^)(CLLocationDegrees lat, CLLocationDegrees lng))_myCallBackBlock
{
    BOOL isLocationUpdated = YES;
    CLAuthorizationStatus status = [CLLocationManager authorizationStatus];
    
    // If the status is denied or only granted for when in use, display an alert
    if ( status == kCLAuthorizationStatusDenied) {//用户拒绝
        isLocationUpdated = NO;
        NSString *title;
        title = multiLanguage(@"定位服务已经关闭!");
        NSString *message = @"本应用需要使用你的定位信息，否则您将无法使用地图定位等相关的功能,您可以到设置中打开它";
        UIAlertView *alertView = [[UIAlertView alloc] initWithTitle:title
                                                            message:message
                                                           delegate:self
                                                  cancelButtonTitle:@"Cancel"
                                                  otherButtonTitles:@"Settings", nil];
        [alertView show];
        _myCallBackBlock(DEFAULT_LATITUDE,DEFAULT_LONTITUDE);
    }
   
     if (status == kCLAuthorizationStatusNotDetermined) {//用户没有拒绝
        
            self.locationManager = [[CLLocationManager alloc] init];
         if ([locationManager respondsToSelector:@selector(requestWhenInUseAuthorization)]) {
            self.locationManager.delegate = self;
            [self.locationManager requestWhenInUseAuthorization];
        }
         else
             self.locationManager = nil;
         isLocationUpdated = NO;
         _myCallBackBlock(DEFAULT_LATITUDE,DEFAULT_LONTITUDE);
    }
    
    if(status == kCLAuthorizationStatusAuthorizedAlways/*使用时打开*/ || status == kCLAuthorizationStatusAuthorizedWhenInUse )//始终打开
    {
        isLocationUpdated = YES;
        self.locationManager = [[CLLocationManager alloc] init];
        self.locationManager.delegate = self;
        [self.locationManager stopUpdatingLocation];
        [self.locationManager startUpdatingLocation];
        callBackBlock = _myCallBackBlock;
    }
    
    return isLocationUpdated;
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 1) {
        // Send the user to the Settings for this app
        NSURL *settingsURL = [NSURL URLWithString:UIApplicationOpenSettingsURLString];
        [[UIApplication sharedApplication] openURL:settingsURL];
    }
}

- (void)locationManager:(CLLocationManager *)manager
     didUpdateLocations:(NSArray<CLLocation *> *)locations
{
    if(!self.locationManager)
        return;
    
    CLLocation *newLocation = (CLLocation *)[locations lastObject];
    
    //获取当前经纬度
    currentLatitude = newLocation.coordinate.latitude;
    currentLontitude = newLocation.coordinate.longitude;
    NSLog(@"获得经纬度:%@",newLocation);
    //系统会一直更新数据，直到选择停止更新，因为我们只需要获得一次经纬度即可，所以获取之后就停止更新
    
    callBackBlock(currentLatitude,currentLontitude);
    
   /* // 获取当前所在的城市名
    CLGeocoder *geocoder = [[CLGeocoder alloc] init];
    //根据经纬度反向地理编译出地址信息
    [geocoder reverseGeocodeLocation:newLocation completionHandler:^(NSArray *array, NSError *error)
     {
         if (array.count > 0)
         {
             CLPlacemark *placemark = [array objectAtIndex:0];
             //获取城市
             str_currentCity= placemark.locality;
             if (!str_currentCity) {
                 //四大直辖市的城市信息无法通过locality获得，只能通过获取省份的方法来获得（如果city为空，则可知为直辖市）
                 str_currentCity = placemark.administrativeArea;
             }
             if(delegate && [delegate respondsToSelector:@selector(wrapperDidUpdateToLocationLat:Lng:city:)])
             {
                 [delegate wrapperDidUpdateToLocationLat:currentLatitude Lng:currentLontitude city:str_currentCity];
             }
         }
         else if (error == nil && [array count] == 0)
         {
             NSLog(@"No results were returned.");
         }
         else if (error != nil)
         {
             NSLog(@"An error occurred = %@", error);
         }
     }];*/
    
    [self.locationManager stopUpdatingLocation];
    self.locationManager = nil;
}

- (void)dealloc {
    NSLog(@":::::>dealloc %s %d",__FUNCTION__,__LINE__);
    [self.locationManager stopUpdatingLocation];
    self.locationManager = nil;
    str_currentCity = nil;
}
@end
