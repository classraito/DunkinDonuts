//
//  FGDDPerksListViewTableCell.m
//  DunkinDonuts
//
//  Created by Ryan Gong on 15/11/25.
//  Copyright © 2015年 Ryan Gong. All rights reserved.
//

#import "FGDDPerksListViewTableCell.h"
#import "Global.h"

@interface FGDDPerksListViewTableCell()
{
    CGRect origianlFrame_bg;
    CGRect originalFrame_title;
    CGRect originalFrame_description;
    CGRect originalFrame_good;
    CGRect originalFrame_favorite;
    CGRect originalFrame_good_btn;
    CGRect originalFrame_favorite_btn;
    CGRect originalFrame_lb_counter;
   
}
@end

@implementation FGDDPerksListViewTableCell
@synthesize vsl_title;
@synthesize lb_description;
@synthesize iv_bg;
@synthesize iv_favorite;
@synthesize iv_good;
@synthesize btn_favorite;
@synthesize btn_good;
@synthesize lb_counter;
@synthesize lb_title;
@synthesize str_perkId;
@synthesize loveFlag;
@synthesize favoriteFlag;
- (void)awakeFromNib {
    [super awakeFromNib];
    [self setOriginalFrame];
    lb_title = [[UILabel alloc] init];
    lb_title.backgroundColor = [UIColor clearColor];
    lb_title.textColor = [UIColor whiteColor];
    lb_title.textAlignment = NSTextAlignmentCenter;
    lb_title.font = font(FONT_BOLD, 16);
    lb_description.font = font(FONT_BOLD, 15);
    lb_counter.font = font(FONT_BOLD, 12);
    iv_bg.layer.shadowColor = [UIColor blackColor].CGColor;
    iv_bg.layer.shadowOffset = CGSizeMake(2, 2);
    iv_bg.layer.shadowRadius = 2;
    iv_bg.layer.shadowOpacity = 1;
    
}

-(void)setupTitle:(NSString *)_str_title
{
    lb_title.text = _str_title;
    [lb_title sizeToFit];
    [vsl_title setupByMiddleView:lb_title padding:5 lineHeight:3 lineColor:[UIColor whiteColor]];
}

-(void)setOriginalFrame
{
    origianlFrame_bg = iv_bg.frame;
    originalFrame_description = lb_description.frame;
    originalFrame_favorite = iv_favorite.frame;
    originalFrame_good = iv_good.frame;
    originalFrame_title = vsl_title.frame;
    originalFrame_good_btn = btn_good.frame;
    originalFrame_favorite_btn = btn_favorite.frame;
    originalFrame_lb_counter = lb_counter.frame;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    iv_bg.frame = [commond useDefaultRatioToScaleFrame:origianlFrame_bg];
    lb_description.frame = [commond useDefaultRatioToScaleFrame:originalFrame_description];
    iv_favorite.frame = [commond useDefaultRatioToScaleFrame:originalFrame_favorite];
    iv_good.frame = [commond useDefaultRatioToScaleFrame:originalFrame_good];
    vsl_title.frame = [commond useDefaultRatioToScaleFrame:originalFrame_title];
    btn_good.frame = [commond useDefaultRatioToScaleFrame:originalFrame_good_btn];
    btn_favorite.frame = [commond useDefaultRatioToScaleFrame:originalFrame_favorite_btn];
    lb_counter.frame = [commond useDefaultRatioToScaleFrame:originalFrame_lb_counter];
    [vsl_title setupByMiddleView:lb_title padding:5 lineHeight:3 lineColor:[UIColor whiteColor]];
}

-(void)dealloc
{
    NSLog(@":::::>dealloc %s %d",__FUNCTION__,__LINE__);
    lb_title = nil;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}

-(IBAction)buttonAction_favorite:(id)_sender;
{
    favoriteFlag = favoriteFlag ? NO : YES;
    iv_favorite.highlighted = favoriteFlag;
    NSMutableDictionary *_dic_requestinfo = [NSMutableDictionary dictionary];
    [_dic_requestinfo setObject:@"Coupon" forKey:@"FavoriteType"];
    [[NetworkManager sharedManager] postRequest_SubmitFavorite:LoveFavoriteType_Coupon favoriteId:str_perkId favoriteFlag:favoriteFlag userinfo:_dic_requestinfo];
}

-(IBAction)buttonAction_good:(id)_sender;
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

@end
