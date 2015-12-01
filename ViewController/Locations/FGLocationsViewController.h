//
//  FGLocationsViewController.h
//  DunkinDonuts
//
//  Created by Ryan Gong on 15/11/25.
//  Copyright © 2015年 Ryan Gong. All rights reserved.
//

#import "FGBaseViewController.h"
#import "FGCustomSegmentSelectView.h"
#import "FGLocationsMapListView.h"
#import "FGLocationsMapSearchResultListView.h"
#import "FGLocationsMapView.h"
#import "BaiduMapWrapperView.h"
#import "FGLocationsRouteSearchTypeView.h"
typedef enum{
    MapType_Map,
    MapType_List
}MapType;

@interface FGLocationsViewController : FGBaseViewController<FGCustomSegmentSelectViewDelegate,UITextFieldDelegate,FGLocationsMapSearchResultListViewDelegate,BaiduMapWrapperViewDelegate>
{
    
}
@property(nonatomic,assign)IBOutlet UIImageView *iv_topBanner;
@property(nonatomic,assign)IBOutlet UIImageView *iv_searchBg;
@property(nonatomic,assign)IBOutlet UITextField *tf;
@property(nonatomic,assign)IBOutlet FGCustomSegmentSelectView *css_viewType;
@property(nonatomic,assign)IBOutlet FGLocationsMapListView *view_mapList;
@property(nonatomic,assign)IBOutlet FGLocationsRouteSearchTypeView *view_routeSearchType;
@property(nonatomic,assign)FGLocationsMapView *view_locationMapView;
@property(nonatomic,assign)FGLocationsMapSearchResultListView *view_searchResultList;
@end
