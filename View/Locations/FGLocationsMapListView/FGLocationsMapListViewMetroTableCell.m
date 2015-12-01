//
//  FGLocationsMapListViewMetroTableCell.m
//  DunkinDonuts
//
//  Created by Ryan Gong on 15/11/26.
//  Copyright © 2015年 Ryan Gong. All rights reserved.
//

#import "FGLocationsMapListViewMetroTableCell.h"
#import "Global.h"
@interface FGLocationsMapListViewMetroTableCell()
{
    CGRect originalFrame_lb_key_metroline;
    CGRect originalFrame_lb_value_metroline;
    CGRect originalFrame_lb_key_station;
    CGRect originalFrame_lb_value_station;
    CGRect originalFrame_lb_key_exitno;
    CGRect originalFrame_lb_value_exitno;
    CGRect originalFrame_view_line1;
    CGRect originalFrame_view_line2;
    CGRect originalFrame_iv_close;
    CGRect originalFrame_btn_close;
    CGRect originalFrame_iv_triangle;
    CGRect originalFrame_view_bg;
}
@end

@implementation FGLocationsMapListViewMetroTableCell
@synthesize lb_key_metroline;
@synthesize lb_value_metroline;
@synthesize lb_key_station;
@synthesize lb_value_station;
@synthesize lb_key_exitno;
@synthesize lb_value_exitno;
@synthesize view_line1;
@synthesize view_line2;
@synthesize iv_close;
@synthesize btn_close;
@synthesize iv_triangle;
@synthesize view_bg;
@synthesize storeId;
@synthesize lat;
@synthesize lng;
- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
    [self setOriginalFrame];
    lb_key_metroline.font = font(FONT_NORMAL, 11);
    lb_value_metroline.font = font(FONT_NORMAL, 11);
    lb_key_station.font = font(FONT_NORMAL, 11);
    lb_value_station.font = font(FONT_NORMAL, 11);
    lb_key_exitno.font = font(FONT_NORMAL, 11);
    lb_value_exitno.font = font(FONT_NORMAL, 11);
    UIColor *textColor = rgb(78, 70, 62);
    lb_key_metroline.textColor =  textColor;
    lb_value_metroline.textColor = textColor;
    lb_key_station.textColor = textColor;
    lb_value_station.textColor = textColor;
    lb_key_exitno.textColor = textColor;
    lb_value_exitno.textColor = textColor;
    
    view_bg.layer.shadowColor = [UIColor blackColor].CGColor;
    view_bg.layer.shadowOffset = CGSizeMake(0, 3);
    view_bg.layer.shadowOpacity = .4;
    view_bg.layer.shadowRadius = 2;
    
    lb_key_exitno.text = multiLanguage(@"Exit No:");
    lb_key_metroline.text = multiLanguage(@"Metro line:");
    lb_key_station.text = multiLanguage(@"Station:");
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setOriginalFrame
{
    originalFrame_btn_close = btn_close.frame;
    originalFrame_iv_close = iv_close.frame;
    originalFrame_lb_key_exitno = lb_key_exitno.frame;
    originalFrame_lb_key_metroline = lb_key_metroline.frame;
    originalFrame_lb_key_station = lb_key_station.frame;
    originalFrame_lb_value_exitno = lb_value_exitno.frame;
    originalFrame_lb_value_metroline = lb_value_metroline.frame;
    originalFrame_lb_value_station = lb_value_station.frame;
    originalFrame_view_line1 = view_line1.frame;
    originalFrame_view_line2 = view_line2.frame;
    originalFrame_iv_triangle = iv_triangle.frame;
    originalFrame_view_bg = view_bg.frame;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    btn_close.frame = [commond useDefaultRatioToScaleFrame:originalFrame_btn_close];
    iv_close.frame = [commond useDefaultRatioToScaleFrame:originalFrame_iv_close];
    lb_key_exitno.frame = [commond useDefaultRatioToScaleFrame:originalFrame_lb_key_exitno];
    lb_key_metroline.frame = [commond useDefaultRatioToScaleFrame:originalFrame_lb_key_metroline];
    lb_key_station.frame = [commond useDefaultRatioToScaleFrame:originalFrame_lb_key_station];
    lb_value_exitno.frame = [commond useDefaultRatioToScaleFrame:originalFrame_lb_value_exitno];
    lb_value_metroline.frame = [commond useDefaultRatioToScaleFrame:originalFrame_lb_value_metroline];
    lb_value_station.frame = [commond useDefaultRatioToScaleFrame:originalFrame_lb_value_station];
    view_line1.frame = [commond useDefaultRatioToScaleFrame:originalFrame_view_line1];
    view_line2.frame = [commond useDefaultRatioToScaleFrame:originalFrame_view_line2];
    iv_triangle.frame = [commond useDefaultRatioToScaleFrame:originalFrame_iv_triangle];
    view_bg.frame = [commond useDefaultRatioToScaleFrame:originalFrame_view_bg];
    
}

-(void)dealloc
{
    NSLog(@":::::>dealloc %s %d",__FUNCTION__,__LINE__);
}
@end
