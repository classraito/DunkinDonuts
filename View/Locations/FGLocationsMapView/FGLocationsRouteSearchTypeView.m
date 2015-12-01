//
//  FGLocationsRouteSearchTypeView.m
//  DunkinDonuts
//
//  Created by Ryan Gong on 15/12/1.
//  Copyright © 2015年 Ryan Gong. All rights reserved.
//

#import "FGLocationsRouteSearchTypeView.h"
#import "Global.h"
@interface FGLocationsRouteSearchTypeView()
{
    CGRect originalFrame_iv_bus;
    CGRect originalFrame_iv_car;
    CGRect originalFrame_iv_walk;
    CGRect originalFrame_btn_bus;
    CGRect originalFrame_btn_car;
    CGRect originalFrame_btn_walk;
}
@end

@implementation FGLocationsRouteSearchTypeView
@synthesize iv_bus;
@synthesize iv_car;
@synthesize iv_walk;
@synthesize btn_bus;
@synthesize btn_car;
@synthesize btn_walk;
-(void)awakeFromNib
{
    [super awakeFromNib];
    self.backgroundColor = meihongColor;
    [self setOriginalFrame];
}

-(void)setOriginalFrame
{
    originalFrame_btn_bus = btn_bus.frame;
    originalFrame_btn_car = btn_car.frame;
    originalFrame_btn_walk = btn_walk.frame;
    originalFrame_iv_bus = iv_bus.frame;
    originalFrame_iv_car = iv_car.frame;
    originalFrame_iv_walk = iv_walk.frame;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    btn_bus.frame = [commond useDefaultRatioToScaleFrame:originalFrame_btn_bus] ;
    btn_car.frame = [commond useDefaultRatioToScaleFrame:originalFrame_btn_car];
    btn_walk.frame = [commond useDefaultRatioToScaleFrame:originalFrame_btn_walk];
    iv_walk.frame = [commond useDefaultRatioToScaleFrame:originalFrame_iv_walk];
    iv_bus.frame = [commond useDefaultRatioToScaleFrame:originalFrame_iv_bus];
    iv_car.frame = [commond useDefaultRatioToScaleFrame:originalFrame_iv_car];
}

-(void)dealloc
{
    NSLog(@":::::>dealloc %s %d",__FUNCTION__,__LINE__);
}
@end
