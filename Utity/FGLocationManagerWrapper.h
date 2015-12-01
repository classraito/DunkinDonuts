//
//  FGLocationManagerWrapper.h
//  DunkinDonuts
//
//  Created by Ryan Gong on 15/11/26.
//  Copyright © 2015年 Ryan Gong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <CoreLocation/CoreLocation.h>
#define DEFAULT_LATITUDE 0
#define DEFAULT_LONTITUDE 0
@protocol FGLocationManagerWrapperDelegate<NSObject>
-(void)wrapperDidUpdateToLocationLat:(CLLocationDegrees)currentLatitude Lng:(CLLocationDegrees)currentLontitude city:(NSString *)_str_city;
@end
@interface FGLocationManagerWrapper : NSObject<CLLocationManagerDelegate>
{
     CLLocationManager *locationManager;
    CLLocationDegrees currentLatitude;
    CLLocationDegrees currentLontitude;
    NSString *str_currentCity;
    void (^callBackBlock)(CLLocationDegrees lat, CLLocationDegrees lng);
}
@property(nonatomic,strong)CLLocationManager *locationManager;
@property CLLocationDegrees currentLatitude;
@property CLLocationDegrees currentLontitude;
@property(nonatomic,strong) NSString *str_currentCity;
@property(nonatomic,assign)id<FGLocationManagerWrapperDelegate>delegate;
+ (instancetype)sharedManager;
-(BOOL )startUpdatingLocation:(void (^)(CLLocationDegrees lat, CLLocationDegrees lng))_myCallBackBlock;
@end
