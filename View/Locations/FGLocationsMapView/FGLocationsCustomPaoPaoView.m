//
//  FGLocationsCustomPaoPaoView.m
//  DunkinDonuts
//
//  Created by Ryan Gong on 15/12/1.
//  Copyright © 2015年 Ryan Gong. All rights reserved.
//

#import "FGLocationsCustomPaoPaoView.h"
#import "Global.h"
@interface FGLocationsCustomPaoPaoView()
{
   
}
@end

@implementation FGLocationsCustomPaoPaoView
@synthesize lb_distance;
@synthesize lb_storeAddress;
@synthesize lb_storeName;
@synthesize lb_storeOpenTime;
@synthesize lb_storePhone;
@synthesize iv_thumbnail;
@synthesize cb_getDirection;
@synthesize iv_close;
@synthesize btn_close;
@synthesize iv_bg;
-(void)awakeFromNib
{
    [super awakeFromNib];
    lb_storeName.font = font(FONT_BOLD, 12);
    lb_storeAddress.font = font(FONT_BOLD,10);
    lb_storeOpenTime.font = font(FONT_BOLD, 10);
    lb_storePhone.font = font(FONT_BOLD, 10);
    lb_distance.font = font(FONT_BOLD, 14);
    lb_distance.textColor = [UIColor blackColor];
     lb_storeName.textColor = [UIColor blackColor];
    lb_storeAddress.textColor = [UIColor darkGrayColor];
    lb_storeOpenTime.textColor = [UIColor darkGrayColor];
    lb_storePhone.textColor = [UIColor darkGrayColor];
    
    [cb_getDirection setFrame:cb_getDirection.frame title:multiLanguage(@"GET DIRECTIONS") arrimg:nil borderColor:meihongColor textColor:meihongColor bgColor:[UIColor clearColor]];
    
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
