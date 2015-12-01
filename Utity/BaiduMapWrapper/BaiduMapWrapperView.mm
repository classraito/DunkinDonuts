//
//  BaiduMapWrapper.m
//  DunkinDonuts
//
//  Created by Ryan Gong on 15/11/12.
//  Copyright © 2015年 Ryan Gong. All rights reserved.
//

#import "BaiduMapWrapperView.h"
#import "Global.h"
#import "CustomOverlay.h"
#import "CustomOverlayView.h"
#import "Custom/MyCustomAnnotationView.h"
#import "Custom/MyCustomAnnotation.h"
#import "FGLocationsCustomPaoPaoView.h"
@interface RouteAnnotation : BMKPointAnnotation
{
    int _type; ///<0:起点 1：终点 2：公交 3：地铁 4:驾乘 5:途经点
    int _degree;
}

@property (nonatomic) int type;
@property (nonatomic) int degree;
@end

@implementation RouteAnnotation

@synthesize type = _type;
@synthesize degree = _degree;
@end

#pragma mark - BaiduMapWrapperView内部定义
@interface BaiduMapWrapperView()
{
    BMKLocationService* locService;
    MyCustomAnnotationView *currentSelectedAnnotationView;
}
@end

#pragma mark - BaiduMapWrapperView(Private) 内部方法
@implementation BaiduMapWrapperView(Private)
- (void)dealloc {
    if (self.routesearch != nil) {
        self.routesearch = nil;
    }
}

-(void)internalInitalLocalService
{
    locService = [[BMKLocationService alloc]init];
}

-(void)internalInitalRouteSearch
{
    self.routesearch = [[BMKRouteSearch alloc]init];
}
@end

#pragma mark - BaiduMapWrapperView(BaseMap)
@implementation BaiduMapWrapperView(BaseMap)


@end

#pragma mark - BaiduMapWrapperView(Location)
@implementation BaiduMapWrapperView(Location)
//普通态
-(void)startLocation
{
    NSLog(@"进入普通定位态");
    [locService startUserLocationService];
    self.showsUserLocation = NO;//先关闭显示的定位图层
    self.userTrackingMode = BMKUserTrackingModeNone;//设置定位的状态
    self.showsUserLocation = YES;//显示定位图层
}
//罗盘态
-(void)startFollowHeading
{
    NSLog(@"进入罗盘态");
    [locService startUserLocationService];
    self.showsUserLocation = NO;
    self.userTrackingMode = BMKUserTrackingModeFollowWithHeading;
    self.showsUserLocation = YES;
    
}
//跟随态
-(void)startFollowing
{
    NSLog(@"进入跟随态");
    [locService startUserLocationService];
    self.showsUserLocation = NO;
    self.userTrackingMode = BMKUserTrackingModeFollow;
    self.showsUserLocation = YES;
    
}
//停止定位
-(void)stopLocation
{
    [locService stopUserLocationService];
    self.showsUserLocation = YES;
}

#pragma mark - BMKLocationServiceDelegate
/**
 *在地图View将要启动定位时，会调用此函数
 *@param mapView 地图View
 */
- (void)willStartLocatingUser
{
    NSLog(@"start locate");
}

/**
 *用户方向更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
{
    [self updateLocationData:userLocation];
    [self stopLocation];
}

/**
 *用户位置更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    self.currentLatitude = userLocation.location.coordinate.latitude;
    self.currentLontitude = userLocation.location.coordinate.longitude;
    [self updateLocationData:userLocation];
}

/**
 *在地图View停止定位后，会调用此函数
 *@param mapView 地图View
 */
- (void)didStopLocatingUser
{
    NSLog(@"stop locate");
}

/**
 *定位失败后，会调用此函数
 *@param mapView 地图View
 *@param error 错误号，参考CLError.h中定义的错误号
 */
- (void)didFailToLocateUserWithError:(NSError *)error
{
    NSLog(@"location error");
}

@end

#pragma mark - BaiduMapWrapper(Annotation)
@implementation BaiduMapWrapperView(Annotation)
//添加标注
- (void)addPointAnnotationByLat:(CLLocationDegrees)_lat lng:(CLLocationDegrees)_lng info:(NSMutableDictionary *)_dic_info
{
    MyCustomAnnotation *myPointAnnotation = [[MyCustomAnnotation alloc]init];
    CLLocationCoordinate2D coor;
    coor.latitude = _lat;
    coor.longitude = _lng;
    myPointAnnotation.coordinate = coor;
    myPointAnnotation.dic_annotationInfo = _dic_info;
    [self addAnnotation:myPointAnnotation];
}


#pragma mark -
#pragma mark implement BMKMapViewDelegate(overlay)

//根据overlay生成对应的View
- (BMKOverlayView *)mapView:(BMKMapView *)mapView viewForOverlay:(id <BMKOverlay>)overlay
{
    
    return nil;
}


// 根据anntation生成对应的View
- (BMKAnnotationView *)mapView:(BMKMapView *)mapView viewForAnnotation:(id <BMKAnnotation>)annotation
{
    //普通annotation
    if ([annotation isKindOfClass:[BMKPointAnnotation class]]) {
        NSString *AnnotationViewID = @"renameMark";
        MyCustomAnnotationView *annotationView = (MyCustomAnnotationView *)[mapView dequeueReusableAnnotationViewWithIdentifier:AnnotationViewID];
        if (annotationView == nil) {
            
            //========================MyCustomAnnotationView===================
            annotationView = [[MyCustomAnnotationView alloc] initWithAnnotation:annotation reuseIdentifier:AnnotationViewID];
            [annotationView setAnnotaionViewByImage:[UIImage imageNamed:@"dd.png"] highlightedImg:[UIImage imageNamed:@"dd-1.png"]];
            
            //========================FGLocationsCustomPaoPaoView===================
            FGLocationsCustomPaoPaoView *view_paopao = (FGLocationsCustomPaoPaoView *)[[[NSBundle mainBundle] loadNibNamed:@"FGLocationsCustomPaoPaoView" owner:nil options:nil] objectAtIndex:0];
            
            //========================bind data to paopaoView=======================
            MyCustomAnnotation *myAnnotation = (MyCustomAnnotation *)annotation;
            if(myAnnotation.dic_annotationInfo && [myAnnotation.dic_annotationInfo count]>0)
            {
                NSString *_str_address = [myAnnotation.dic_annotationInfo objectForKey:@"Address"];
                NSString *_str_phone = [myAnnotation.dic_annotationInfo objectForKey:@"Phone"];
                NSString *_str_name = [myAnnotation.dic_annotationInfo objectForKey:@"Name"];
                NSString *_str_openTime = [myAnnotation.dic_annotationInfo objectForKey:@"StoreHours"];
                int distance = [[myAnnotation.dic_annotationInfo objectForKey:@"Distance"] intValue];
                
                view_paopao.lb_storeName.text = _str_name;
                view_paopao.lb_storeAddress.text = _str_address;
                view_paopao.lb_storeOpenTime.text = _str_openTime;
                view_paopao.lb_storePhone.text = _str_phone;
                view_paopao.lb_distance.text = [commond meterToKMIfNeeded:distance];
                
                view_paopao.btn_close.hidden = YES;
                view_paopao.iv_close.hidden = YES;

                [view_paopao.cb_getDirection.button addTarget:self action:@selector(buttonAction_getDirection:) forControlEvents:UIControlEventTouchUpInside];
                
//                [view_paopao.btn_close addTarget:self action:@selector(buttonAction_closePaoPao:) forControlEvents:UIControlEventTouchUpInside];
            }
            annotationView.paopaoView = [[BMKActionPaopaoView alloc]initWithCustomView:view_paopao];
        }
        return annotationView;
    }
    return nil;
}

/**
 *当取消选中一个annotation views时，调用此接口
 *@param mapView 地图View
 *@param views 取消选中的annotation views
 */
- (void)mapView:(BMKMapView *)mapView didSelectAnnotationView:(BMKAnnotationView *)view;
{
    if([view isKindOfClass:[MyCustomAnnotationView class]])
    {
        MyCustomAnnotationView *myAnnotationView = (MyCustomAnnotationView *)view;
        myAnnotationView.annotationImageView.highlighted = YES;
        currentSelectedAnnotationView = myAnnotationView;
    }
}


- (void)mapView:(BMKMapView *)mapView didDeselectAnnotationView:(BMKAnnotationView *)view;
{
    if([view isKindOfClass:[MyCustomAnnotationView class]])
    {
        MyCustomAnnotationView *myAnnotationView = (MyCustomAnnotationView *)view;
        myAnnotationView.annotationImageView.highlighted = NO;
        currentSelectedAnnotationView = nil;
    }
}

// 当点击annotation view弹出的泡泡时，调用此接口
- (void)mapView:(BMKMapView *)mapView annotationViewForBubble:(BMKAnnotationView *)view;
{
    if([view isKindOfClass:[MyCustomAnnotationView class]])
    {
        [self buttonAction_getDirection:nil];
    }
}



-(void)buttonAction_getDirection:(id)_sender
{
    if(!currentSelectedAnnotationView)
        return;
    MyCustomAnnotation *myAnnotation = (MyCustomAnnotation *)currentSelectedAnnotationView.annotation;
    NSMutableDictionary *dic_singleData = myAnnotation.dic_annotationInfo;
    if(self.delegate_custom && [self.delegate_custom respondsToSelector:@selector(didGotoRouteSearchMode:info:)] )
    {
        [self.delegate_custom didGotoRouteSearchMode:self info:dic_singleData];
    }
    
}

-(void)buttonAction_closePaoPao:(id)_sender
{
    if(!currentSelectedAnnotationView)
        return;
}
@end

#pragma mark - BaiduMapWrapper(RouteSearch)
@implementation BaiduMapWrapperView(RouteSearch)
-(void)busRouteSearch:(NSString *)_str_fromAddress toAddress:(NSString *)_str_toAddress inCity:(NSString *)_str_inCity
{
    BMKPlanNode* start = [[BMKPlanNode alloc]init];
    start.name = _str_fromAddress;
    BMKPlanNode* end = [[BMKPlanNode alloc]init];
    end.name = _str_toAddress;
    
    BMKTransitRoutePlanOption *transitRouteSearchOption = [[BMKTransitRoutePlanOption alloc]init];
    if(_str_inCity)
        transitRouteSearchOption.city= _str_inCity;
    transitRouteSearchOption.from = start;
    transitRouteSearchOption.to = end;
    [self.routesearch transitSearch:transitRouteSearchOption];
}

-(void)driveSearch:(NSString *)_str_fromAddress toAddress:(NSString *)_str_toAddress fromCity:(NSString *)_str_fromCity toCity:(NSString *)_str_toCity
{
    BMKPlanNode* start = [[BMKPlanNode alloc]init];
    start.name = _str_fromAddress;
    if(_str_fromCity)
        start.cityName = _str_fromCity;
    BMKPlanNode* end = [[BMKPlanNode alloc]init];
    end.name = _str_toAddress;
    if(_str_toCity)
        end.cityName = _str_toCity;
    
    BMKDrivingRoutePlanOption *drivingRouteSearchOption = [[BMKDrivingRoutePlanOption alloc]init];
    drivingRouteSearchOption.from = start;
    drivingRouteSearchOption.to = end;
    [self.routesearch drivingSearch:drivingRouteSearchOption];
}

-(void)walkSearch:(NSString *)_str_fromAddress toAddress:(NSString *)_str_toAddress fromCity:(NSString *)_str_fromCity toCity:(NSString *)_str_toCity
{
    
    BMKPlanNode* start = [[BMKPlanNode alloc]init];
    start.name = _str_fromAddress;
    start.cityName = _str_fromCity;
    BMKPlanNode* end = [[BMKPlanNode alloc]init];
    end.name = _str_toAddress;
    end.cityName = _str_toCity;
    
    BMKWalkingRoutePlanOption *walkingRouteSearchOption = [[BMKWalkingRoutePlanOption alloc]init];
    walkingRouteSearchOption.from = start;
    walkingRouteSearchOption.to = end;
    [self.routesearch walkingSearch:walkingRouteSearchOption];
}

#pragma mark - BMKRouteSearchDelegate
/**
 *返回公交搜索结果
 *@param searcher 搜索对象
 *@param result 搜索结果，类型为BMKTransitRouteResult
 *@param error 错误号，@see BMKSearchErrorCode
 */
- (void)onGetTransitRouteResult:(BMKRouteSearch*)searcher result:(BMKTransitRouteResult*)result errorCode:(BMKSearchErrorCode)error;
{
    NSArray* array = [NSArray arrayWithArray:self.annotations];
    [self removeAnnotations:array];
    array = [NSArray arrayWithArray:self.overlays];
    [self removeOverlays:array];
    if (error == BMK_SEARCH_NO_ERROR) {
        BMKTransitRouteLine* plan = (BMKTransitRouteLine*)[result.routes objectAtIndex:0];
        // 计算路线方案中的路段数目
        NSInteger size = [plan.steps count];
        int planPointCounts = 0;
        for (int i = 0; i < size; i++) {
            BMKTransitStep* transitStep = [plan.steps objectAtIndex:i];
            if(i==0){
                RouteAnnotation* item = [[RouteAnnotation alloc]init];
                item.coordinate = plan.starting.location;
                item.title = @"起点";
                item.type = 0;
                [self addAnnotation:item]; // 添加起点标注
            }else if(i==size-1){
                RouteAnnotation* item = [[RouteAnnotation alloc]init];
                item.coordinate = plan.terminal.location;
                item.title = @"终点";
                item.type = 1;
                [self addAnnotation:item]; // 添加起点标注
            }
            //轨迹点总数累计
            planPointCounts += transitStep.pointsCount;
        }
        
        //轨迹点
        BMKMapPoint * temppoints = new BMKMapPoint[planPointCounts];
        int i = 0;
        for (int j = 0; j < size; j++) {
            BMKTransitStep* transitStep = [plan.steps objectAtIndex:j];
            int k=0;
            for(k=0;k<transitStep.pointsCount;k++) {
                temppoints[i].x = transitStep.points[k].x;
                temppoints[i].y = transitStep.points[k].y;
                i++;
            }
        }
        CustomOverlay* polyLine = [[CustomOverlay alloc] initWithPoints:temppoints count:planPointCounts];
        [self addOverlay:polyLine]; //添加路线overlay
        delete []temppoints;
        [self mapViewFitPolyLine:polyLine];
    }
}

/**
 *返回驾乘搜索结果
 *@param searcher 搜索对象
 *@param result 搜索结果，类型为BMKDrivingRouteResult
 *@param error 错误号，@see BMKSearchErrorCode
 */
- (void)onGetDrivingRouteResult:(BMKRouteSearch*)searcher result:(BMKDrivingRouteResult*)result errorCode:(BMKSearchErrorCode)error;
{
    NSArray* array = [NSArray arrayWithArray:self.annotations];
    [self removeAnnotations:array];
    array = [NSArray arrayWithArray:self.overlays];
    [self removeOverlays:array];
    if (error == BMK_SEARCH_NO_ERROR) {
        BMKDrivingRouteLine* plan = (BMKDrivingRouteLine*)[result.routes objectAtIndex:0];
        // 计算路线方案中的路段数目
        NSInteger size = [plan.steps count];
        int planPointCounts = 0;
        for (int i = 0; i < size; i++) {
            BMKDrivingStep* transitStep = [plan.steps objectAtIndex:i];
            if(i==0){
                RouteAnnotation* item = [[RouteAnnotation alloc]init];
                item.coordinate = plan.starting.location;
                item.title = @"起点";
                item.type = 0;
                [self addAnnotation:item]; // 添加起点标注
                
            }else if(i==size-1){
                RouteAnnotation* item = [[RouteAnnotation alloc]init];
                item.coordinate = plan.terminal.location;
                item.title = @"终点";
                item.type = 1;
                [self addAnnotation:item]; // 添加起点标注
            }
            //轨迹点总数累计
            planPointCounts += transitStep.pointsCount;
        }
        
        //轨迹点
        BMKMapPoint * temppoints = new BMKMapPoint[planPointCounts];
        int i = 0;
        for (int j = 0; j < size; j++) {
            BMKDrivingStep* transitStep = [plan.steps objectAtIndex:j];
            int k=0;
            for(k=0;k<transitStep.pointsCount;k++) {
                temppoints[i].x = transitStep.points[k].x;
                temppoints[i].y = transitStep.points[k].y;
                i++;
            }
            
        }
        CustomOverlay* polyLine = [[CustomOverlay alloc] initWithPoints:temppoints count:planPointCounts];
        [self addOverlay:polyLine]; //添加路线overlay
        delete []temppoints;
        [self mapViewFitPolyLine:polyLine];
    }
}

/**
 *返回步行搜索结果
 *@param searcher 搜索对象
 *@param result 搜索结果，类型为BMKWalkingRouteResult
 *@param error 错误号，@see BMKSearchErrorCode
 */
- (void)onGetWalkingRouteResult:(BMKRouteSearch*)searcher result:(BMKWalkingRouteResult*)result errorCode:(BMKSearchErrorCode)error;
{
    NSArray* array = [NSArray arrayWithArray:self.annotations];
    [self removeAnnotations:array];
    array = [NSArray arrayWithArray:self.overlays];
    [self removeOverlays:array];
    if (error == BMK_SEARCH_NO_ERROR) {
        BMKWalkingRouteLine* plan = (BMKWalkingRouteLine*)[result.routes objectAtIndex:0];
        NSInteger size = [plan.steps count];
        int planPointCounts = 0;
        for (int i = 0; i < size; i++) {
            BMKWalkingStep* transitStep = [plan.steps objectAtIndex:i];
            if(i==0){
                RouteAnnotation* item = [[RouteAnnotation alloc]init];
                item.coordinate = plan.starting.location;
                item.title = @"起点";
                item.type = 0;
                [self addAnnotation:item]; // 添加起点标注
                
            }else if(i==size-1){
                RouteAnnotation* item = [[RouteAnnotation alloc]init];
                item.coordinate = plan.terminal.location;
                item.title = @"终点";
                item.type = 1;
                [self addAnnotation:item]; // 添加起点标注
            }
            //轨迹点总数累计
            planPointCounts += transitStep.pointsCount;
        }
        
        //轨迹点
        BMKMapPoint * temppoints = new BMKMapPoint[planPointCounts];
        int i = 0;
        for (int j = 0; j < size; j++) {
            BMKWalkingStep* transitStep = [plan.steps objectAtIndex:j];
            int k=0;
            for(k=0;k<transitStep.pointsCount;k++) {
                temppoints[i].x = transitStep.points[k].x;
                temppoints[i].y = transitStep.points[k].y;
                i++;
            }
            
        }
        // 通过points构建BMKPolyline
        CustomOverlay* polyLine = [[CustomOverlay alloc] initWithPoints:temppoints count:planPointCounts];
        [self addOverlay:polyLine]; //添加路线overlay
        delete []temppoints;
        [self mapViewFitPolyLine:polyLine];
    }
}

//根据polyline设置地图范围
- (void)mapViewFitPolyLine:(CustomOverlay *) polyLine {
    CGFloat ltX, ltY, rbX, rbY;
    if (polyLine.pointCount < 1) {
        return;
    }
    BMKMapPoint pt = polyLine.points[0];
    ltX = pt.x, ltY = pt.y;
    rbX = pt.x, rbY = pt.y;
    for (int i = 1; i < polyLine.pointCount; i++) {
        BMKMapPoint pt = polyLine.points[i];
        if (pt.x < ltX) {
            ltX = pt.x;
        }
        if (pt.x > rbX) {
            rbX = pt.x;
        }
        if (pt.y > ltY) {
            ltY = pt.y;
        }
        if (pt.y < rbY) {
            rbY = pt.y;
        }
    }
    BMKMapRect rect;
    rect.origin = BMKMapPointMake(ltX , ltY);
    rect.size = BMKMapSizeMake(rbX - ltX, rbY - ltY);
    [self setVisibleMapRect:rect];
    self.zoomLevel = self.zoomLevel - 0.3;
}

@end


#pragma mark - BaiduMapWrapper 基本功能
@implementation BaiduMapWrapperView
@synthesize routesearch;
@synthesize currentLatitude;
@synthesize currentLontitude;
@synthesize delegate_custom;
-(id)initWithFrame:(CGRect)frame mapType:(BMKMapType)_mapType
{
    if(self = [super initWithFrame:frame])
    {
        [self internalInitalLocalService];
        [self internalInitalRouteSearch];
        self.mapType = _mapType;
        self.zoomLevel = 11;
    }
    return self;
}

-(void)registerDelegate
{
    [self viewWillAppear];
    self.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
    routesearch.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
    locService.delegate = self;
    
}

-(void)clearDelegate
{
    [self viewWillDisappear];
    self.delegate = nil; // 不用时，置nil
    routesearch.delegate = nil; // 不用时，置nil
    locService.delegate = nil;
    delegate_custom  = nil;
}



@end
