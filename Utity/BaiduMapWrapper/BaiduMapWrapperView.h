//
//  BaiduMapWrapper.h
//  DunkinDonuts
//
//  Created by Ryan Gong on 15/11/12.
//  Copyright © 2015年 Ryan Gong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <BaiduMapAPI_Base/BMKBaseComponent.h>//引入base相关所有的头文件
#import <BaiduMapAPI_Map/BMKMapComponent.h>//引入地图功能所有的头文件
#import <BaiduMapAPI_Search/BMKSearchComponent.h>//引入检索功能所有的头文件
#import <BaiduMapAPI_Location/BMKLocationComponent.h>//引入定位功能所有的头文件
#import <BaiduMapAPI_Utils/BMKUtilsComponent.h>//引入计算工具所有的头文件
#import <BaiduMapAPI_Map/BMKMapView.h>//只引入所需的单个头文件
@class BaiduMapWrapperView;

@protocol BaiduMapWrapperViewDelegate <NSObject>
-(void)didGotoRouteSearchMode:(BaiduMapWrapperView *)_baiduWrapperView info:(NSMutableDictionary *)_dic_info;
@end


typedef enum{
    RouteSearchType_walk,
    RouteSearchType_bus,
    RouteSearchType_driving
}RouteSearch_Type;

@interface BaiduMapWrapperView : BMKMapView<BMKMapViewDelegate>
{
    
}
@property CLLocationDegrees currentLatitude;
@property CLLocationDegrees currentLontitude;
@property(nonatomic,strong)BMKRouteSearch* routesearch;
@property(nonatomic,assign)id<BaiduMapWrapperViewDelegate>delegate_custom;
-(void)registerDelegate;
-(void)clearDelegate;
-(id)initWithFrame:(CGRect)frame mapType:(BMKMapType)_mapType;

@end

@interface BaiduMapWrapperView(Location)<BMKLocationServiceDelegate>
//普通态
-(void)startLocation;
//罗盘态
-(void)startFollowHeading;
//跟随态
-(void)startFollowing;
//停止定位
-(void)stopLocation;
@end

@interface BaiduMapWrapperView(BaseMap)

@end


@interface BaiduMapWrapperView(Annotation)
- (void)addPointAnnotationByLat:(CLLocationDegrees)_lat lng:(CLLocationDegrees)_lng info:(NSMutableDictionary *)_dic_info;
@end

@interface BaiduMapWrapperView(RouteSearch)<BMKRouteSearchDelegate>

-(void)busRouteSearch:(NSString *)_str_fromAddress toAddress:(NSString *)_str_toAddress inCity:(NSString *)_str_inCity;
-(void)driveSearch:(NSString *)_str_fromAddress toAddress:(NSString *)_str_toAddress fromCity:(NSString *)_str_fromCity toCity:(NSString *)_str_toCity;
-(void)walkSearch:(NSString *)_str_fromAddress toAddress:(NSString *)_str_toAddress fromCity:(NSString *)_str_fromCity toCity:(NSString *)_str_toCity;
@end
