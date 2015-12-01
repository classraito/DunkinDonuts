//
//  FGLocationsMapListViewTableCell.m
//  DunkinDonuts
//
//  Created by Ryan Gong on 15/11/26.
//  Copyright © 2015年 Ryan Gong. All rights reserved.
//

#import "FGLocationsMapListViewTableCell.h"
#import "Global.h"
@interface FGLocationsMapListViewTableCell()
{
    CGRect originalFrame_lb_storename;
    CGRect originalFrame_lb_address;
    CGRect originalFrame_lb_phone;
    CGRect originalFrame_lb_openTime;
    CGRect originalFrame_lb_distance;
    CGRect originalFrame_view_separatorLine;
    CGRect originalFrame_btn_pin;
    CGRect originalFrame_btn_metro;
    CGRect originalFrame_btn_call;
    CGRect originalFrame_iv_pin;
    CGRect originalFrame_iv_metro;
    CGRect originalFrame_iv_call;
    CGRect originalFrame_view_bg;
    
    
}
@end

@implementation FGLocationsMapListViewTableCell
@synthesize lb_storename;
@synthesize lb_address;
@synthesize lb_phone;
@synthesize lb_openTime;
@synthesize lb_distance;
@synthesize view_separatorLine;
@synthesize btn_pin;
@synthesize btn_metro;
@synthesize btn_call;
@synthesize iv_pin;
@synthesize iv_metro;
@synthesize iv_call;
@synthesize view_bg;
@synthesize storeid;
@synthesize isHideBgShadow;
- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
    [self setOriginalFrame];
     view_bg.backgroundColor = rgb(254,253,250);
    
    [self showBgShadow];
    lb_storename.font = font(FONT_NORMAL, 12);
    lb_address.font = font(FONT_NORMAL, 12);
    lb_phone.font = font(FONT_NORMAL, 12);
    lb_openTime.font = font(FONT_NORMAL, 12);
    lb_distance.font = font(FONT_BOLD,12);
    
    lb_storename.textColor = [UIColor blackColor];
    lb_distance.textColor = [UIColor blackColor];
    
    UIColor *textColor = rgb(69, 69, 69);
    lb_address.textColor = textColor;
    lb_phone.textColor = textColor;
    lb_openTime.textColor = textColor;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

-(void)showBgShadow
{
    isHideBgShadow = NO;
    view_bg.layer.shadowColor = [UIColor blackColor].CGColor;
    view_bg.layer.shadowOffset = CGSizeMake(0, 3);
    view_bg.layer.shadowOpacity = .4;
    view_bg.layer.shadowRadius = 2;

}

-(void)hideBgShadow
{
    isHideBgShadow = YES;
    view_bg.backgroundColor = rgb(254,253,250);
    view_bg.layer.shadowColor = [UIColor clearColor].CGColor;
}

-(void)setOriginalFrame
{
    originalFrame_btn_call = btn_call.frame;
    originalFrame_btn_metro = btn_metro.frame;
    originalFrame_btn_pin = btn_pin.frame;
    originalFrame_lb_address = lb_address.frame;
    originalFrame_lb_distance = lb_distance.frame;
    originalFrame_lb_openTime = lb_openTime.frame;
    originalFrame_lb_phone = lb_phone.frame;
    originalFrame_lb_storename = lb_storename.frame;
    originalFrame_view_separatorLine = view_separatorLine.frame;
    originalFrame_iv_call = iv_call.frame;
    originalFrame_iv_metro = iv_metro.frame;
    originalFrame_iv_pin = iv_pin.frame;
    originalFrame_view_bg = view_bg.frame;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    btn_call.frame = [commond useDefaultRatioToScaleFrame:originalFrame_btn_call];
    btn_metro.frame = [commond useDefaultRatioToScaleFrame:originalFrame_btn_metro];
    btn_pin.frame = [commond useDefaultRatioToScaleFrame:originalFrame_btn_pin];
    lb_address.frame = [commond useDefaultRatioToScaleFrame:originalFrame_lb_address];
    lb_distance.frame = [commond useDefaultRatioToScaleFrame:originalFrame_lb_distance];
    lb_openTime.frame = [commond useDefaultRatioToScaleFrame:originalFrame_lb_openTime];
    lb_phone.frame = [commond useDefaultRatioToScaleFrame:originalFrame_lb_phone];
    lb_storename.frame = [commond useDefaultRatioToScaleFrame:originalFrame_lb_storename];
    view_separatorLine.frame = [commond useDefaultRatioToScaleFrame:originalFrame_view_separatorLine];
    iv_call.frame = [commond useDefaultRatioToScaleFrame:originalFrame_iv_call];
    iv_pin.frame = [commond useDefaultRatioToScaleFrame:originalFrame_iv_pin];
    iv_metro.frame = [commond useDefaultRatioToScaleFrame:originalFrame_iv_metro];
    if(isHideBgShadow)
    {
        view_bg.frame = self.bounds;
    }
    else
    {
        view_bg.frame = [commond useDefaultRatioToScaleFrame:originalFrame_view_bg];
    }
    
}

-(void)dealloc
{
    NSLog(@":::::>dealloc %s %d",__FUNCTION__,__LINE__);
}
@end

