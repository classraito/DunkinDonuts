//
//  FGRedeemCouponViewController.m
//  DunkinDonuts
//
//  Created by Ryan Gong on 15/11/25.
//  Copyright © 2015年 Ryan Gong. All rights reserved.
//

#import "FGRedeemCouponViewController.h"
#import "Global.h"
@interface FGRedeemCouponViewController ()
{
    NSString *str_perkId;
}
@end

@implementation FGRedeemCouponViewController
@synthesize view_bannerView;
@synthesize view_description;
-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil PerkId:(NSString *)_str_perkId
{
    if(self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])
    {
        str_perkId = _str_perkId;
        [[NetworkManager sharedManager] postrequest_getPerksInfoByPerkId:_str_perkId userinfo:nil];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view_topPanel.str_title = multiLanguage(@"DD Perks");
    [self.iv_bg removeFromSuperview];
    self.iv_bg = nil;
    [self.view_contentView removeFromSuperview];
    self.view_contentView = nil;
    self.view.backgroundColor = rgb(241,235,228);
    [self internalInitalBannerView];
    [self internalInitalDescriptionView];
}

-(void)internalInitalBannerView
{
    [view_bannerView setupTitle:multiLanguage(@"Breakfast Special")];
    view_bannerView.lb_description.text = multiLanguage(@"¥5 Off Sweet Black Pepper\n Bacon Sandwich");
}

-(void)internalInitalDescriptionView
{
    [view_description.cb_redeem.button addTarget:self action:@selector(buttonAction_redeem:) forControlEvents:UIControlEventTouchUpInside];
    [view_description.cb_share.button addTarget:self action:@selector(buttonAction_share:) forControlEvents:UIControlEventTouchUpInside];
    [view_description.cb_terms.button addTarget:self action:@selector(buttonAction_terms:) forControlEvents:UIControlEventTouchUpInside];
    
//    view_description.tv_title.text = multiLanguage(@"");
}

-(void)manullyFixSize
{
    [super manullyFixSize];
    
    view_bannerView.frame = CGRectMake(0, 0, W, H/2);
    view_description.frame = CGRectMake(0, H/2, W, H);
}


#pragma mark - buttonAction in FGRedeemCouponDescriptionView
-(void)buttonAction_redeem:(id)_sender
{
    FGControllerManager *manager = [FGControllerManager sharedManager];
    FGRedeemCouponQRCodeViewController *vc_redeemQrCode = [[FGRedeemCouponQRCodeViewController alloc] initWithNibName:@"FGRedeemCouponQRCodeViewController" bundle:nil PerkId:str_perkId];
    [manager pushController:vc_redeemQrCode navigationController:nav_main];
}

-(void)buttonAction_share:(id)_sender
{
    
}

-(void)buttonAction_terms:(id)_sender
{
    
}

-(void)dealloc
{
    NSLog(@":::::>dealloc %s %d",__FUNCTION__,__LINE__);
}

#pragma mark - 网络事件通知
-(void)receivedDataFromNetwork:(NSNotification *)_notification
{
    [super receivedDataFromNetwork:_notification];
    NSMutableDictionary *_dic_requestInfo = _notification.object;
    NSString *_str_url = [_dic_requestInfo objectForKey:@"url"];
    
    if([HOST(URL_GetPerkInfo) isEqualToString:_str_url])
    {
        [view_bannerView bindDataToUI];
        [view_description bindDataToUI];
    }
}
@end
