//
//  FGLocationsViewController.m
//  DunkinDonuts
//
//  Created by Ryan Gong on 15/11/25.
//  Copyright © 2015年 Ryan Gong. All rights reserved.
//

#import "FGLocationsViewController.h"
#import "Global.h"
@interface FGLocationsViewController ()
{
    CGRect originalFrame_iv_searchBg;
    CGRect originalFrame_tf;
    CGRect originalFrame_iv_topBanner;
    CGRect originalFrame_css_viewType;
    
    MapType currentMapType;
    
    UIButton *btn_cancel;
    
    BOOL isNeedShowSearchResultList;
    BOOL isNeedShowRouteSearchView;
}
@end

@implementation FGLocationsViewController
@synthesize iv_searchBg;
@synthesize tf;
@synthesize css_viewType;
@synthesize view_mapList;
@synthesize iv_topBanner;
@synthesize view_searchResultList;
@synthesize view_locationMapView;
@synthesize view_routeSearchType;
#pragma mark - life circle 生命周期
-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if(self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])
    {
        [[NetworkManager sharedManager] postRequest_getSotresBySearchWord:@" " userinfo:nil];
        currentMapType = MapType_Map;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    isViewDidLayoutSubviewsShouldBeCall = NO;//视图的位置发生变化时父类不会在-(void)viewDidLayoutSubviews中调用manullyFixSize 而是在-(void)viewWillAppear:(BOOL)animated中调用
    
    // Do any additional setup after loading the view from its nib.
    self.view_topPanel.str_title = multiLanguage(@"Locations");
    
    [self.view_contentView removeFromSuperview];
    self.view_contentView = nil;
    tf.delegate = self;
    tf.font = font(FONT_NORMAL, 14);
    [self setOriginalFrame];
    
    css_viewType.delegate = self;
    
    [css_viewType setupByTitles:@[multiLanguage(@"MAP VIEW"),multiLanguage(@"LIST VIEW")] font:font(FONT_BOLD, 12) textColor:[UIColor whiteColor] lineColor:meihongColor lineHeight:8 spaceV:5];
    
    [self internalInitalLocationsMapView];
    view_mapList.hidden = YES;
}

-(void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    if(!view_locationMapView)
        return;
    [view_locationMapView.view_baiduMapWrapper registerDelegate];
    [view_locationMapView.view_baiduMapWrapper startFollowing];
}

-(void)viewWillDisappear:(BOOL)animated {
    [super viewWillDisappear:animated];
    if(!view_locationMapView)
        return;
    [view_locationMapView.view_baiduMapWrapper clearDelegate];
}


-(void)dealloc
{
    NSLog(@":::::>dealloc %s %d",__FUNCTION__,__LINE__);
    if(view_searchResultList)
    {
        view_searchResultList.delegate = nil;
        [view_searchResultList removeFromSuperview];
        view_searchResultList = nil;
    }
}


#pragma mark - internal inital 内部初始化
-(void)internalInitalSearchResultListView
{
    if(view_searchResultList)
        return;
    if(!isNeedShowSearchResultList)
        return;
    view_searchResultList = (FGLocationsMapSearchResultListView *)[[[NSBundle mainBundle] loadNibNamed:@"FGLocationsMapSearchResultListView" owner:nil options:nil] objectAtIndex:0];
    view_searchResultList.delegate = self;
    [self.view addSubview:view_searchResultList];
    [self internalLayoutSearchResultListView];
}


-(void)internalInitalLocationsMapView
{
    view_locationMapView = (FGLocationsMapView *)[[[NSBundle mainBundle] loadNibNamed:@"FGLocationsMapView" owner:nil options:nil] objectAtIndex:0];
    view_locationMapView.view_baiduMapWrapper.delegate_custom = self;
    [self.view addSubview:view_locationMapView];
}

-(void)internalInitalRouteSearchView
{
    if(view_routeSearchType)
        return;
    
    view_routeSearchType = (FGLocationsRouteSearchTypeView *)[[[NSBundle mainBundle] loadNibNamed:@"FGLocationsRouteSearchTypeView" owner:nil options:nil] objectAtIndex:0];
    [self.view addSubview:view_routeSearchType];
}

#pragma mark - layout 布局
-(void)setOriginalFrame
{
    originalFrame_iv_searchBg = iv_searchBg.frame;
    originalFrame_tf = tf.frame;
    originalFrame_iv_topBanner = iv_topBanner.frame;
    originalFrame_css_viewType = css_viewType.frame;
}

-(void)manullyFixSize
{
    [super manullyFixSize];
    
    iv_searchBg.frame = [commond useDefaultRatioToScaleFrame:originalFrame_iv_searchBg];
    tf.frame = [commond useDefaultRatioToScaleFrame:originalFrame_tf];
    iv_topBanner.frame = [commond useDefaultRatioToScaleFrame:originalFrame_iv_topBanner];
    css_viewType.frame = [commond useDefaultRatioToScaleFrame:originalFrame_css_viewType];
    
    CGRect _frame = view_mapList.frame;
    _frame.size.width = W;
    _frame.origin.y = css_viewType.frame.origin.y + css_viewType.frame.size.height;
    _frame.size.height = H - _frame.origin.y;
    view_mapList.frame = _frame;
    
    view_locationMapView.frame = view_mapList.frame;
}

-(void)internalLayoutSearchResultListView
{
    CGRect _frame;
    _frame = view_searchResultList.frame;
    _frame.origin.y = H;
    view_searchResultList.frame = _frame;
    [UIView beginAnimations:nil context:nil];
    _frame = view_searchResultList.frame;
    _frame.origin.y = iv_topBanner.frame.size.height + iv_topBanner.frame.origin.y;
    _frame.size.width = W;
    _frame.size.height = H - _frame.origin.y;
    view_searchResultList.frame = _frame;
    [UIView commitAnimations];
}

-(void)internalLayoutRouteSearchTypeView
{
    if(!view_routeSearchType)
        return;
    CGRect _frame = view_routeSearchType.frame;
    _frame.size.width = W;
    _frame.size.height = 44;
    _frame.origin.x = 0;
    _frame.origin.y = view_locationMapView.frame.origin.y - _frame.size.height;
    view_routeSearchType.frame = _frame;
}

#pragma mark - showRouteSearchViewIfNeeded
-(void)showRouteSearchViewIfNeeded
{
    if(!isNeedShowRouteSearchView)
        return;
    CGRect _frame;
    [self internalInitalRouteSearchView];
    [self internalLayoutRouteSearchTypeView];
    
    css_viewType.hidden = YES;
    tf.hidden = YES;
    iv_searchBg.hidden = YES;
    [UIView beginAnimations:nil context:nil];
    
    _frame = view_routeSearchType.frame;
    _frame.origin.y = self.view_topPanel.frame.origin.y + self.view_topPanel.frame.size.height;
    view_routeSearchType.frame = _frame;
    
    _frame = iv_topBanner.frame;
    _frame.size.height = view_routeSearchType.frame.origin.y + view_routeSearchType.frame.size.height;
    iv_topBanner.frame = _frame;
    
    _frame = view_locationMapView.frame;
    _frame.origin.y = iv_topBanner.frame.origin.y + iv_topBanner.frame.size.height;
    _frame.size.height = H - _frame.origin.y;
    view_locationMapView.frame = _frame;
    [UIView commitAnimations];
    

}

-(void)hideRouteSearchViewIfNeeded
{
    if(isNeedShowRouteSearchView)
        return;
    if(view_routeSearchType)
    {
        [view_routeSearchType removeFromSuperview];
        view_routeSearchType = nil;
    }
    css_viewType.hidden = NO;
    tf.hidden = NO;
    iv_searchBg.hidden = NO;
    
    [UIView beginAnimations:nil context:nil];
    iv_topBanner.frame = [commond useDefaultRatioToScaleFrame:originalFrame_iv_topBanner];
    
    
    CGRect _frame = view_locationMapView.frame;
    _frame.origin.y = iv_topBanner.frame.origin.y + iv_topBanner.frame.size.height;
    _frame.size.height = H - _frame.origin.y;
    view_locationMapView.frame = _frame;
    [UIView commitAnimations];

}

#pragma mark - showSearchResultListViewIfNeeded
-(void)showSearchResultListViewIfNeeded
{
    if(!isNeedShowSearchResultList)
        return;
    
    tf.placeholder = multiLanguage(@"Search by Street or District");
    if(view_mapList)
        view_mapList.hidden = YES;
    css_viewType.hidden = YES;
    
    if(!btn_cancel)
    {
        btn_cancel = [UIButton buttonWithType:UIButtonTypeCustom];
        btn_cancel.backgroundColor = [UIColor clearColor];
        btn_cancel.titleLabel.textColor = [UIColor whiteColor];
        btn_cancel.titleLabel.font = font(FONT_BOLD, 14);
        [btn_cancel setTitle:multiLanguage(@"Cancel") forState:UIControlStateNormal];
        btn_cancel.showsTouchWhenHighlighted = YES;
        [btn_cancel addTarget:self action:@selector(buttonAction_searchCancel:) forControlEvents:UIControlEventTouchUpInside];
        [self.view addSubview:btn_cancel];
    }
    CGRect _frame ;
    _frame = btn_cancel.frame;
    _frame.origin.x = W + 100;
    btn_cancel.frame = _frame;
    
    [UIView beginAnimations:nil context:nil];
     _frame = self.view_topPanel.frame;
    _frame.origin.y = -self.view_topPanel.frame.size.height;
    self.view_topPanel.frame = _frame;
    
    CGRect newOriginalFrame_iv_topBanner = originalFrame_iv_topBanner;
    newOriginalFrame_iv_topBanner.size.height = originalFrame_iv_topBanner.size.height * 0.5f;
    
    iv_topBanner.frame = [commond useDefaultRatioToScaleFrame:newOriginalFrame_iv_topBanner];
    
    CGRect newOriginalFrame_iv_searchBg = originalFrame_iv_searchBg;
    newOriginalFrame_iv_searchBg.size.width = originalFrame_iv_searchBg.size.width - 50;
    iv_searchBg.frame = [commond useDefaultRatioToScaleFrame:newOriginalFrame_iv_searchBg];
    iv_searchBg.center = CGPointMake(iv_searchBg.center.x, LAYOUT_STATUSBAR_HEIGHT + (iv_topBanner.frame.size.height - LAYOUT_STATUSBAR_HEIGHT) / 2);
    
    CGRect newOriginalFrame_tf = originalFrame_tf;
    newOriginalFrame_tf.size.width = originalFrame_tf.size.width - 50;
    tf.frame = [commond useDefaultRatioToScaleFrame:newOriginalFrame_tf];
    tf.center = CGPointMake(tf.center.x, iv_searchBg.center.y);
    
    _frame = btn_cancel.frame;
    _frame.size.width = W - (iv_searchBg.frame.origin.x + iv_searchBg.frame.size.width) - 10 * 2;
    _frame.size.height = iv_searchBg.frame.size.height;
    _frame.origin.x = iv_searchBg.frame.origin.x + iv_searchBg.frame.size.width + 10;
    btn_cancel.frame = _frame;
    btn_cancel.center = CGPointMake(btn_cancel.center.x, iv_searchBg.center.y);
    [UIView commitAnimations];
    
    [self internalInitalSearchResultListView];
   
}

-(void)hideSearchResultListViewIfNeeded
{
    if(isNeedShowSearchResultList)
        return;

    if(view_mapList)
        view_mapList.hidden = NO;
    css_viewType.hidden = NO;
    tf.placeholder = multiLanguage(@"Find A Store");
    
    if(btn_cancel)
    {
        [btn_cancel removeFromSuperview];
        btn_cancel = nil;
    }
    CGRect _frame ;
    
    [UIView beginAnimations:nil context:nil];
    _frame = self.view_topPanel.frame;
    _frame.origin.y = LAYOUT_STATUSBAR_HEIGHT;
    self.view_topPanel.frame = _frame;
    
    iv_topBanner.frame = [commond useDefaultRatioToScaleFrame:originalFrame_iv_topBanner];
    iv_searchBg.frame = [commond useDefaultRatioToScaleFrame:originalFrame_iv_searchBg];
    tf.frame = [commond useDefaultRatioToScaleFrame:originalFrame_tf];
    css_viewType.frame = [commond useDefaultRatioToScaleFrame:originalFrame_css_viewType];
    
    [UIView commitAnimations];
    [tf resignFirstResponder];
    
    if(view_searchResultList)
    {
        view_searchResultList.delegate = nil;
        [view_searchResultList removeFromSuperview];
        view_searchResultList = nil;
    }
}

#pragma mark - buttonAction
-(void)buttonAction_searchCancel:(id)_sender
{
    isNeedShowSearchResultList = NO;
    [self hideSearchResultListViewIfNeeded];
}

-(void)buttonAction_back:(id)_sender
{
    if(isNeedShowRouteSearchView && view_routeSearchType)
    {
        isNeedShowRouteSearchView = NO;
        [self hideRouteSearchViewIfNeeded];
    }
    else
    {
        [super buttonAction_back:nil];
    }
}


#pragma mark - FGLocationsMapSearchResultListViewDelegate
-(void)searchResultListView:(FGLocationsMapSearchResultListView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    isNeedShowSearchResultList = NO;
    [self hideSearchResultListViewIfNeeded];
}

#pragma mark - FGCustomSegmentSelectViewDelegate
-(void)didSelectByIndex:(NSInteger)_index
{
    switch (_index) {
        case 0:
            currentMapType = MapType_Map;
            view_mapList.hidden = YES;
            view_locationMapView.hidden = NO;
            break;
            
        case 1:
            currentMapType = MapType_List;
            view_mapList.hidden = NO;
            view_locationMapView.hidden = YES;
            break;
    }
}

#pragma mark - BaiduMapWrapperViewDelegate
-(void)didGotoRouteSearchMode:(BaiduMapWrapperView *)_baiduWrapperView info:(NSMutableDictionary *)_dic_info
{
   
    if(currentMapType != MapType_Map)
        return;
    if(!isNeedShowRouteSearchView)
    {
         NSLog(@"%s %d",__FUNCTION__,__LINE__);
        isNeedShowRouteSearchView = YES;
        [self showRouteSearchViewIfNeeded];
    }
  
    
}

#pragma mark - UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField;
{
    isNeedShowSearchResultList = YES;
    [self showSearchResultListViewIfNeeded];
    if([tf.text length]>0)
    {
        [[NetworkManager sharedManager] postRequest_getStoresKeyword:tf.text userinfo:nil];
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;
{
    NSUInteger newLength = [textField.text length] + [string length] - range.length;
    if(newLength > 30 )
        return NO;
   
    NSString *newString = [textField.text stringByReplacingCharactersInRange:range withString:string];
     if(newLength >0)
     {
         [[NetworkManager sharedManager] postRequest_getStoresKeyword:newString userinfo:nil];
     }
    
    return YES;
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField;
{

    [textField resignFirstResponder];
    
    return YES;
}


#pragma mark - 网络事件通知
-(void)receivedDataFromNetwork:(NSNotification *)_notification
{
    [super receivedDataFromNetwork:_notification];
    NSMutableDictionary *_dic_requestInfo = _notification.object;
    NSString *_str_url = [_dic_requestInfo objectForKey:@"url"];
    
    if([HOST(URL_GetStores) isEqualToString:_str_url])
    {
        if(view_mapList)
            [view_mapList bindDataToUI];
        if(view_locationMapView)
            [view_locationMapView bindDataToUI];
    }
    if([HOST(URL_GetStoresKeyword) isEqualToString:_str_url])
    {
        if(view_searchResultList)
            [view_searchResultList bindDataToUI];
    }
}
@end
