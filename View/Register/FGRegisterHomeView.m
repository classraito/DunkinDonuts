//
//  FGRegisterHomeView.m
//  DunkinDonuts
//
//  Created by Ryan Gong on 15/11/17.
//  Copyright © 2015年 Ryan Gong. All rights reserved.
//

#import "FGRegisterHomeView.h"
#import "Global.h"
@interface FGRegisterHomeView()
{
    UILabel *lb_tips;
}
@end

@implementation FGRegisterHomeView
@synthesize cb_register;
@synthesize cb_wechat;
@synthesize cb_weibo;
@synthesize lb_description;
@synthesize iv_thumbnail;
@synthesize vsl_sepator;
@synthesize btn_underline;
-(void)awakeFromNib
{
    [super awakeFromNib];
    self.backgroundColor = [UIColor clearColor];
    
    lb_description.text = multiLanguage(@"Membership has its Perks.Log in to get big deals on your favorite Dunkin' treats.");
    lb_description.font = font(FONT_NORMAL, 16);
    
    [self internalInitalSeparatorView];
    
    btn_underline.btn.titleLabel.font = font(FONT_NORMAL,14);
    [btn_underline.btn setTitle:multiLanguage(@"Maybe Later") forState:UIControlStateNormal];
    [btn_underline.btn setTitle:multiLanguage(@"Maybe Later") forState:UIControlStateHighlighted];
    [btn_underline.btn sizeToFit];
    
    
}

-(void)internalInitalSeparatorView
{
    lb_tips = [[UILabel alloc] initWithFrame:CGRectZero];
    lb_tips.textAlignment = NSTextAlignmentCenter;
    lb_tips.textColor = [UIColor whiteColor];
    lb_tips.text = multiLanguage(@"Other ways");
    lb_tips.font = font(FONT_NORMAL, 14);
    [lb_tips sizeToFit];
    lb_tips.userInteractionEnabled = YES;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    vsl_sepator.center = CGPointMake(self.frame.size.width/2, vsl_sepator.center.y);
    
    [cb_register setFrame:cb_register.frame title:multiLanguage(@"REGISTER") arrimg:[UIImage
                                                                                   imageNamed:@"arr-1.png"] thumb:[UIImage imageNamed:@"icon-phone.png"] borderColor:[UIColor whiteColor] textColor:[UIColor whiteColor] bgColor:[UIColor clearColor] padding:10 font:font(FONT_NORMAL, 14) needTitleLeftAligment:NO];
    
    [vsl_sepator setupByMiddleView:lb_tips padding:5 lineHeight:1 lineColor:[UIColor whiteColor]];
    
    [cb_wechat setFrame:cb_wechat.frame title:multiLanguage(@"WECHAT") arrimg:[UIImage imageNamed:@"arr-1.png"] thumb:[UIImage imageNamed:@"icon-wechat.png"] borderColor:[UIColor whiteColor] textColor:[UIColor whiteColor] bgColor:[UIColor clearColor] padding:10 font:font(FONT_NORMAL, 14) needTitleLeftAligment:NO];
    
    [cb_weibo setFrame:cb_weibo.frame title:multiLanguage(@"WEIBO") arrimg:[UIImage imageNamed:@"arr-1.png"] thumb:[UIImage imageNamed:@"icon-weibo.png"] borderColor:[UIColor whiteColor] textColor:[UIColor whiteColor] bgColor:[UIColor clearColor] padding:10 font:font(FONT_NORMAL, 14) needTitleLeftAligment:NO];
}



-(void)dealloc
{
    NSLog(@":::::>dealloc %s %d",__FUNCTION__,__LINE__);
    
}


@end
