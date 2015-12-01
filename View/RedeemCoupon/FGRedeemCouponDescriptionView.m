//
//  FGRedeemCouponDescriptionView.m
//  DunkinDonuts
//
//  Created by Ryan Gong on 15/11/25.
//  Copyright © 2015年 Ryan Gong. All rights reserved.
//

#import "FGRedeemCouponDescriptionView.h"
#import "Global.h"
@interface FGRedeemCouponDescriptionView()
{
    CGRect originalFrame_tv_title;
    CGRect originalFrame_cb_redeem;
    CGRect originalFrame_cb_share;
    CGRect originalFrame_cb_terms;
}
@end

@implementation FGRedeemCouponDescriptionView
@synthesize tv_title;
@synthesize cb_redeem;
@synthesize cb_share;
@synthesize cb_terms;
-(void)awakeFromNib
{
    [super awakeFromNib];
    self.view_content.backgroundColor = [UIColor clearColor];
    
    tv_title.font = font(FONT_NORMAL, 14);
    tv_title.backgroundColor = [UIColor clearColor];
    [cb_redeem setFrame:cb_redeem.frame title:multiLanguage(@"REDEEM COUPON") arrimg:nil thumb:[UIImage imageNamed:@"icon-down.png"] borderColor:meihongColor textColor:meihongColor bgColor:[UIColor clearColor] padding:5 needTitleLeftAligment:NO];
    [cb_share setFrame:cb_share.frame title:multiLanguage(@"SHARE THIS OFFER") arrimg:nil thumb:[UIImage imageNamed:@"icon-forward.png"] borderColor:meihongColor textColor:meihongColor bgColor:[UIColor clearColor] padding:5 needTitleLeftAligment:NO];
    [cb_terms setFrame:cb_terms.frame title:multiLanguage(@"Terms & Conditions") arrimg:[UIImage imageNamed:@"down.png"] thumb:nil borderColor:nil textColor:[UIColor blackColor] bgColor:[UIColor whiteColor] padding:20 needTitleLeftAligment:YES];
    [self setOriginalFrame];
}

-(void)setOriginalFrame
{
    originalFrame_tv_title = tv_title.frame;
    originalFrame_cb_redeem = cb_redeem.frame;
    originalFrame_cb_share  = cb_share.frame;
    originalFrame_cb_terms = cb_terms.frame;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    tv_title.frame = [commond useDefaultRatioToScaleFrame:originalFrame_tv_title];
    cb_redeem.frame = [commond useDefaultRatioToScaleFrame:originalFrame_cb_redeem];
    cb_share.frame = [commond useDefaultRatioToScaleFrame:originalFrame_cb_share];
    cb_terms.frame = [commond useDefaultRatioToScaleFrame:originalFrame_cb_terms];
}

-(void)bindDataToUI
{
    DataManager *dataManager = [DataManager sharedManager];
    NSMutableDictionary *_dic_datas = [dataManager getDataByUrl:HOST(URL_GetPerkInfo)];
    NSMutableDictionary *_dic_singleData = [[_dic_datas objectForKey:@"List"] firstObject];
    NSString *_str_description = [_dic_singleData objectForKey:@"Describe"];
    tv_title.text = _str_description;
}

-(void)dealloc
{
    NSLog(@":::::>dealloc %s %d",__FUNCTION__,__LINE__);
}
@end
