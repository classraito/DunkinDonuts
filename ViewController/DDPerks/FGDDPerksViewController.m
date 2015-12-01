//
//  FGDDPerksViewController.m
//  DunkinDonuts
//
//  Created by Ryan Gong on 15/11/25.
//  Copyright © 2015年 Ryan Gong. All rights reserved.
//

#import "FGDDPerksViewController.h"
#import "Global.h"
@interface FGDDPerksViewController ()
{
    GetPerkType currentPerkType;
}
@end

@implementation FGDDPerksViewController
@synthesize iv_topBanner;
@synthesize css_showMode;
@synthesize view_listView;
-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if(self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])
    {
        [[NetworkManager sharedManager] postRequest_getPerksBySearchType:GetPerkType_VIEWALL userinfo:nil];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view_topPanel.str_title = multiLanguage(@"DD Perks");
    [self.iv_bg removeFromSuperview];
    self.iv_bg = nil;
    self.view.backgroundColor = rgb(241,235,228);
    css_showMode.delegate = self;
    
    [css_showMode setupByTitles:@[multiLanguage(@"VIEW ALL"),multiLanguage(@"MEMBERS ONLY"),multiLanguage(@"FAVORITES")] font:font(FONT_BOLD, 12) textColor:[UIColor whiteColor] lineColor:meihongColor lineHeight:8 spaceV:5];
    
    
}

-(void)manullyFixSize
{
    [super manullyFixSize];
   
    iv_topBanner.frame = CGRectMake(0, 0, W, LAYOUT_STATUSBAR_HEIGHT + LAYOUT_TOPVIEW_HEIGHT + 50);
    CGRect _frame = self.view_contentView.frame;
    _frame.origin.y = iv_topBanner.frame.size.height + iv_topBanner.frame.origin.y;
    _frame.size.height = H - _frame.origin.y;
    self.view_contentView.frame = _frame;
    view_listView.frame = self.view_contentView.bounds;
}


-(void)dealloc
{
    NSLog(@":::::>dealloc %s %d",__FUNCTION__,__LINE__);
}

#pragma mark - FGCustomSegmentSelectViewDelegate
-(void)didSelectByIndex:(NSInteger)_index
{
    switch (_index) {
        case 0:
            currentPerkType = GetPerkType_VIEWALL;
            
            break;
            
        case 1:
            currentPerkType = GetPerkType_MEMBERS;
            break;
        case 2:
            currentPerkType = GetPerkType_FAVORITE;
            break;
    }
    [[NetworkManager sharedManager] postRequest_getPerksBySearchType:currentPerkType userinfo:nil];
}

#pragma mark - 网络事件通知
-(void)receivedDataFromNetwork:(NSNotification *)_notification
{
    [super receivedDataFromNetwork:_notification];
    NSMutableDictionary *_dic_requestInfo = _notification.object;
    NSString *_str_url = [_dic_requestInfo objectForKey:@"url"];
    
    if([HOST(URL_GetPerks) isEqualToString:_str_url])
    {
        [view_listView bindDataToUI];
    }
    if([HOST(URL_SubmitFavorite) isEqualToString:_str_url])
    {
        if([[_dic_requestInfo allKeys] containsObject:@"FavoriteType"])
        {
            if([[_dic_requestInfo objectForKey:@"FavoriteType"] isEqualToString:@"Coupon"] && currentPerkType == GetPerkType_FAVORITE)
            {
                [[NetworkManager sharedManager] postRequest_getPerksBySearchType:GetPerkType_FAVORITE userinfo:nil];
            }
        }//对收藏做了操作，并且当前过滤使用的是收藏 这里就需要刷新一下

    }
}

@end
