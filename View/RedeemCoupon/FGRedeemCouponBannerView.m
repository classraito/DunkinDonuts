//
//  FGRedeemCouponBannerView.m
//  DunkinDonuts
//
//  Created by Ryan Gong on 15/11/25.
//  Copyright © 2015年 Ryan Gong. All rights reserved.
//

#import "FGRedeemCouponBannerView.h"
#import "Global.h"
#define DEFAULT_COUPONBGIMG @"offers1.jpg"
@interface FGRedeemCouponBannerView()
{
    CGRect originalFrame_vsl_title;
    CGRect originalFrame_lb_description;
    CGRect originalFrame_iv_good;
    CGRect originalFrame_iv_favorite;
    CGRect originalFrame_lb_counter;
    CGRect originalFrame_btn_good;
    CGRect originalFrame_btn_favorite;
    CGRect originalFrame_iv_bg;
    
     UILabel *lb_title;
    int LoveCount;
    BOOL loveFlag;
    BOOL favoriteFlag;
    NSString *str_perkId;
}
@end

@implementation FGRedeemCouponBannerView
@synthesize vsl_title;
@synthesize lb_description;
@synthesize iv_good;
@synthesize iv_favorite;
@synthesize lb_counter;
@synthesize btn_good;
@synthesize btn_favorite;
@synthesize iv_bg;

-(void)awakeFromNib
{
    [super awakeFromNib];
    self.view_content.backgroundColor = [UIColor clearColor];
    lb_title = [[UILabel alloc] init];
    lb_title.backgroundColor = [UIColor clearColor];
    lb_title.textColor = [UIColor whiteColor];
    lb_title.textAlignment = NSTextAlignmentCenter;
    lb_title.font = font(FONT_BOLD, 16);
    lb_description.font = font(FONT_BOLD, 18);
    lb_counter.font = font(FONT_BOLD, 10);
    
    [self setOriginalFrame];
    [btn_favorite addTarget:self action:@selector(buttonAction_favorite:) forControlEvents:UIControlEventTouchUpInside];
    [btn_good addTarget:self action:@selector(buttonAction_good:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)setupTitle:(NSString *)_str_title
{
    lb_title.text = _str_title;
    [lb_title sizeToFit];
    [vsl_title setupByMiddleView:lb_title padding:5 lineHeight:3 lineColor:[UIColor whiteColor]];
}

-(void)setOriginalFrame
{
    originalFrame_vsl_title = vsl_title.frame;
    originalFrame_lb_description = lb_description.frame;
    originalFrame_iv_good = iv_good.frame;
    originalFrame_iv_favorite = iv_favorite.frame;
    originalFrame_lb_counter = lb_counter.frame;
    originalFrame_btn_good = btn_good.frame;
    originalFrame_btn_favorite = btn_favorite.frame;
    originalFrame_iv_bg = iv_bg.frame;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    iv_bg.frame = [commond useDefaultRatioToScaleFrame:originalFrame_iv_bg];
    
    lb_description.frame = [commond useDefaultRatioToScaleFrame:originalFrame_lb_description];
    iv_favorite.frame = [commond useDefaultRatioToScaleFrame:originalFrame_iv_favorite];
    iv_good.frame = [commond useDefaultRatioToScaleFrame:originalFrame_iv_good];
    vsl_title.frame = [commond useDefaultRatioToScaleFrame:originalFrame_vsl_title];
    btn_good.frame = [commond useDefaultRatioToScaleFrame:originalFrame_btn_good];
    btn_favorite.frame = [commond useDefaultRatioToScaleFrame:originalFrame_btn_favorite];
    lb_counter.frame = [commond useDefaultRatioToScaleFrame:originalFrame_lb_counter];
    [vsl_title setupByMiddleView:lb_title padding:5 lineHeight:3 lineColor:[UIColor whiteColor]];
    [lb_description sizeToFit];
    CGRect _frame = lb_description.frame;
    _frame.origin.y = vsl_title.frame.origin.y + vsl_title.frame.size.height + 10;
    lb_description.frame = _frame;
    lb_description.center = CGPointMake(self.frame.size.width / 2, lb_description.center.y);
}

-(void)bindDataToUI
{
    DataManager *dataManager = [DataManager sharedManager];
    NSMutableDictionary *_dic_datas = [dataManager getDataByUrl:HOST(URL_GetPerkInfo)];
    NSMutableDictionary *_dic_singleData = [[_dic_datas objectForKey:@"List"] firstObject];
    NSString *_str_BgImg = [_dic_singleData objectForKey:@"InfoImg"];
    NSString *_str_Content = [_dic_singleData objectForKey:@"Content"];
    NSString *_str_Name = [_dic_singleData objectForKey:@"Name"];
    LoveCount = [[_dic_singleData objectForKey:@"LoveCount"] intValue];
    loveFlag = [[_dic_singleData objectForKey:@"LoveFlag"] boolValue];
    favoriteFlag = [[_dic_singleData objectForKey:@"FavoriteFlag"] boolValue];
    str_perkId = [_dic_singleData objectForKey:@"PerkId"];

    [iv_bg sd_setImageWithURL:[NSURL URLWithString:_str_BgImg] placeholderImage:[UIImage imageNamed:DEFAULT_COUPONBGIMG]];
    lb_title.text = _str_Name;
    lb_description.text = _str_Content;
    lb_counter.text = [NSString stringWithFormat:@"%d",LoveCount];
    iv_good.highlighted = loveFlag;
    iv_favorite.highlighted = favoriteFlag;
}

#pragma mark - buttonAction in FGRedeemCouponBannerView
-(void)buttonAction_favorite:(id)_sender;
{
    favoriteFlag = favoriteFlag ? NO : YES;
    iv_favorite.highlighted = favoriteFlag;
    
    NSMutableDictionary *_dic_requestinfo = [NSMutableDictionary dictionary];
    [_dic_requestinfo setObject:@"Coupon" forKey:@"FavoriteType"];
    [[NetworkManager sharedManager] postRequest_SubmitFavorite:LoveFavoriteType_Coupon favoriteId:str_perkId favoriteFlag:favoriteFlag userinfo:_dic_requestinfo];
}

-(void)buttonAction_good:(id)_sender;
{
    loveFlag = loveFlag ? NO : YES;
    iv_good.highlighted = loveFlag;
    int lovecount = [lb_counter.text intValue];
    if(loveFlag)
        lovecount += 1;
    else
    {
        lovecount = lovecount >0 ? lovecount - 1 : 0;
    }
    lb_counter.text = [NSString stringWithFormat:@"%d",lovecount];
    [[NetworkManager sharedManager] postRequest_submitLove:LoveFavoriteType_Coupon loveId:str_perkId loveflag:loveFlag userinfo:nil];
}


-(void)dealloc
{
    NSLog(@":::::>dealloc %s %d",__FUNCTION__,__LINE__);
}
@end
