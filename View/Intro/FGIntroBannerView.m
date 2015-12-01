//
//  FGIntroBannerView.m
//  DunkinDonuts
//
//  Created by Ryan Gong on 15/11/17.
//  Copyright © 2015年 Ryan Gong. All rights reserved.
//

#import "FGIntroBannerView.h"
#import "Global.h"
@implementation FGIntroBannerView
@synthesize lb_title;
@synthesize lb_subtitle;
@synthesize iv_banner;
-(void)awakeFromNib
{
    [super awakeFromNib];
    self.backgroundColor = [UIColor clearColor];
    lb_title.text = @"Introducing the new";
    lb_subtitle.text = @"Mobile App";
    lb_title.textColor = [UIColor blackColor];
    lb_subtitle.textColor = [UIColor blackColor];
    lb_subtitle.font = font(FONT_NORMAL, 15);
    lb_title.font = font(FONT_NORMAL, 15);
}

-(void)layoutSubviews
{
    [super layoutSubviews];
}

-(void)dealloc
{
    NSLog(@":::::>dealloc %s %d",__FUNCTION__,__LINE__);
}
@end
