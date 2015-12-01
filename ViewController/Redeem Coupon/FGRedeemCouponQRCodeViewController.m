//
//  FGRedeemCouponQRCodeViewController.m
//  DunkinDonuts
//
//  Created by Ryan Gong on 15/11/26.
//  Copyright © 2015年 Ryan Gong. All rights reserved.
//

#import "FGRedeemCouponQRCodeViewController.h"
#import "Global.h"
@interface FGRedeemCouponQRCodeViewController ()
{
    CGRect originalFrame_lb_description;
    CGRect originalFrame_lb_tips;
    CGRect originalFrame_vsl_title;
    CGRect originalFrame_cb_terms;
    CGRect originalFrame_iv_qrcode;
    CGRect originalFrame_view_separatorLine;
      UILabel *lb_title;
}
@end

@implementation FGRedeemCouponQRCodeViewController
@synthesize lb_description;
@synthesize lb_tips;
@synthesize vsl_title;
@synthesize cb_terms;
@synthesize iv_qrcode;
@synthesize view_separatorLine;
@synthesize iv_topbg;
-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil PerkId:(NSString *)_str_perkId
{
    if(self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])
    {
        [[NetworkManager sharedManager] postRequest_getCouponImgByPerkId:_str_perkId userinfo:nil];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setOriginalFrame];
    self.view_topPanel.str_title = multiLanguage(@"Redeem Coupon");
    
    self.view_contentView.backgroundColor = rgb(241,235,228);
    
    lb_title = [[UILabel alloc] init];
    lb_title.backgroundColor = [UIColor clearColor];
    lb_title.textColor = meihongColor;
    lb_title.textAlignment = NSTextAlignmentCenter;
    lb_title.font = font(FONT_BOLD, 16);
    [self setupTitle:multiLanguage(@"Breakfast Special")];
    
    view_separatorLine.backgroundColor = meihongColor;
    lb_description.textColor = meihongColor;
    lb_description.font = font(FONT_BOLD, 18);
    
    lb_tips.textColor = [UIColor blackColor];
    lb_tips.font = font(FONT_NORMAL, 15);
    
    [cb_terms setFrame:cb_terms.frame title:multiLanguage(@"Terms & Conditions") arrimg:[UIImage imageNamed:@"down.png"] thumb:nil borderColor:nil textColor:[UIColor blackColor] bgColor:[UIColor whiteColor] padding:20 needTitleLeftAligment:YES];
    
    [cb_terms.button addTarget:self action:@selector(buttonAction_terms:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)setupTitle:(NSString *)_str_title
{
    lb_title.text = _str_title;
    [lb_title sizeToFit];
    [vsl_title setupByMiddleView:lb_title padding:5 lineHeight:3 lineColor:meihongColor];
}

-(void)setOriginalFrame
{
    originalFrame_cb_terms = cb_terms.frame;
    originalFrame_iv_qrcode = iv_qrcode.frame;
    originalFrame_lb_description = lb_description.frame;
    originalFrame_lb_tips = lb_tips.frame;
    originalFrame_view_separatorLine = view_separatorLine.frame;
    originalFrame_vsl_title = vsl_title.frame;
}

-(void)manullyFixSize
{
    [super manullyFixSize];
    
    cb_terms.frame = [commond useDefaultRatioToScaleFrame:originalFrame_cb_terms];
    iv_qrcode.frame = [commond useDefaultRatioToScaleFrame:originalFrame_iv_qrcode];
    lb_description.frame = [commond useDefaultRatioToScaleFrame:originalFrame_lb_description];
    lb_tips.frame = [commond useDefaultRatioToScaleFrame:originalFrame_lb_tips];
    view_separatorLine.frame = [commond useDefaultRatioToScaleFrame:originalFrame_view_separatorLine];
    vsl_title.frame = [commond useDefaultRatioToScaleFrame:originalFrame_vsl_title];
    [vsl_title setupByMiddleView:lb_title padding:5 lineHeight:3 lineColor:meihongColor];
}

#pragma mark - buttonAction
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
    
    if([HOST(URL_GetCouponImg) isEqualToString:_str_url])
    {
        
    }
}
@end
