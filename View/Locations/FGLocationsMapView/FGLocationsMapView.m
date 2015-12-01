//
//  FGLocationsMapView.m
//  DunkinDonuts
//
//  Created by Ryan Gong on 15/12/1.
//  Copyright © 2015年 Ryan Gong. All rights reserved.
//

#import "FGLocationsMapView.h"
#import "Global.h"

@interface FGLocationsMapView()
{
    NSMutableArray *arr_datas;
}
@end

@implementation FGLocationsMapView
@synthesize view_baiduMapWrapper;
-(void)awakeFromNib
{
    [super awakeFromNib];
    [self internalInitalMapView];
}

-(void)internalInitalMapView
{
    view_baiduMapWrapper = [[BaiduMapWrapperView alloc] initWithFrame:self.bounds mapType:BMKMapTypeStandard];
    [self addSubview:view_baiduMapWrapper];
    
}

-(void)bindDataToUI
{
    DataManager *dataManager = [DataManager sharedManager];
    NSMutableDictionary *dic_datas = [dataManager getDataByUrl:HOST(URL_GetStores)];
    arr_datas = [[dic_datas objectForKey:@"List"] mutableCopy];
    for(NSMutableDictionary *_dic_singleData in arr_datas)
    {
        CLLocationDegrees lat = [commond DeCodeCoordinate:[[_dic_singleData objectForKey:@"Lat"] longValue]] ;
        CLLocationDegrees lng = [commond DeCodeCoordinate:[[_dic_singleData objectForKey:@"Lng"] longValue]] ;
        [view_baiduMapWrapper addPointAnnotationByLat:lat lng:lng info:_dic_singleData];
    }
    
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    view_baiduMapWrapper.frame = self.bounds;
}

-(void)dealloc
{
    NSLog(@":::::>dealloc %s %d",__FUNCTION__,__LINE__);
    [view_baiduMapWrapper removeFromSuperview];
    view_baiduMapWrapper = nil;
}
@end
