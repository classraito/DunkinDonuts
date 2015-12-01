//
//  FGHomePageCouponInfoView.m
//  DunkinDonuts
//
//  Created by Ryan Gong on 15/11/25.
//  Copyright © 2015年 Ryan Gong. All rights reserved.
//

#import "FGHomePageCouponInfoView.h"
#import "Global.h"
@interface FGHomePageCouponInfoView()
{
    CGRect origianlFrame_arrLeft;
    CGRect originalFrame_arrRight;
    CGRect originalFrame_title;
    CGRect originalFrame_description;
    CGRect originalFrame_redeem;
}
@end


@implementation FGHomePageCouponInfoView
@synthesize lb_title;
@synthesize lb_description;
@synthesize iv_left;
@synthesize iv_right;
@synthesize cub_redeem;
@synthesize str_perkId;
@synthesize couponType;
-(void)awakeFromNib
{
    [super awakeFromNib];
    
    self.backgroundColor = [UIColor clearColor];
    lb_title.font = font(FONT_BOLD, 28);
    lb_description.font = font(FONT_BOLD, 26);
    [cub_redeem setFrame:cub_redeem.frame title:multiLanguage(@"REDEEM NOW") arrimg:[UIImage imageNamed:@"arr-1.png"] borderColor:meihongColor textColor:[UIColor whiteColor] bgColor:meihongColor];
    cub_redeem.layer.shadowColor = [UIColor blackColor].CGColor;
    cub_redeem.layer.shadowOffset = CGSizeMake(1, 1);
    [cub_redeem.button addTarget:self action:@selector(buttonAction_redeem:) forControlEvents:UIControlEventTouchUpInside];
    [self setOriginalFrame];
}

-(void)setOriginalFrame
{
    origianlFrame_arrLeft = iv_left.frame;
    originalFrame_arrRight = iv_right.frame;
    originalFrame_title = lb_title.frame;
    originalFrame_description = lb_description.frame;
    originalFrame_redeem = cub_redeem.frame;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    CGRect _frame = iv_left.frame;
    _frame.origin.x = origianlFrame_arrLeft.origin.x * ratioW;
    _frame.size.width = origianlFrame_arrLeft.size.width * ratioW;
    _frame.size.height = origianlFrame_arrLeft.size.height * ratioH;
    iv_left.frame = _frame;
    iv_left.center = CGPointMake(iv_left.center.x, self.frame.size.height / 2);
    
    _frame = iv_right.frame;
    _frame.origin.x = originalFrame_arrRight.origin.x * ratioW;
    _frame.size.width = originalFrame_arrRight.size.width * ratioW;
    _frame.size.height = originalFrame_arrRight.size.height * ratioH;
    iv_right.frame = _frame;
    iv_right.center = CGPointMake(iv_right.center.x, self.frame.size.height / 2);
    
    _frame = lb_title.frame;
    _frame.size.width = originalFrame_title.size.width * ratioW;
    lb_title.frame = _frame;
    [lb_title sizeToFit];
    lb_title.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2 - lb_title.frame.size.height / 2-10);
    
    _frame = lb_description.frame;
    _frame.size.width = originalFrame_description.size.width * ratioW;
    lb_description.frame = _frame;
    [lb_description sizeToFit];
    lb_description.center = CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2 + 10 );
    
    _frame = cub_redeem.frame;
    _frame.size.width =originalFrame_redeem.size.width * ratioW;
    _frame.size.height = originalFrame_redeem.size.height * ratioH;
    _frame.origin.y = originalFrame_redeem.origin.y * ratioH;
    _frame.origin.x = originalFrame_redeem.origin.x * ratioW;
    cub_redeem.frame = _frame;
}

-(void)buttonAction_redeem:(id)_sender
{
    FGControllerManager *manager = [FGControllerManager sharedManager];
    FGRedeemCouponViewController *vc_redeem = [[FGRedeemCouponViewController alloc] initWithNibName:@"FGRedeemCouponViewController" bundle:nil PerkId:str_perkId];
    [manager pushController:vc_redeem navigationController:nav_main];
}

-(void)dealloc
{
    NSLog(@":::::>dealloc %s %d",__FUNCTION__,__LINE__);
}
@end
