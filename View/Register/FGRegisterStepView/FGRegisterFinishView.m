//
//  FGRegisterPhoneNumPasswdView.m
//  DunkinDonuts
//
//  Created by Ryan Gong on 15/11/19.
//  Copyright © 2015年 Ryan Gong. All rights reserved.
//

#import "FGRegisterFinishView.h"
#import "Global.h"
@interface FGRegisterFinishView()
{
    UIImageView *iv_separator;
}
@end

@implementation FGRegisterFinishView
@synthesize cb_done;
@synthesize lb_title;
@synthesize lb_description;
@synthesize vsl_sepator;
-(void)awakeFromNib
{
    [super awakeFromNib];
    self.backgroundColor = [UIColor clearColor];
    lb_title.font = font(FONT_BOLD, 18);
    lb_description.font = font(FONT_BOLD, 18);
    lb_title.text = multiLanguage(@"Woohoo!");
    lb_description.text = multiLanguage(@"Welcome!you are nnow a member of DD Perks.");
    
    iv_separator = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"icon-cup.png"]];
    CGRect _frame = iv_separator.frame;
    _frame.size.width = iv_separator.image.size.width / 3;
    _frame.size.height = iv_separator.image.size.height / 3;
    iv_separator.frame = _frame;
    
    [cb_done setFrame:cb_done.frame title:multiLanguage(@"DONE")  arrimg:[UIImage imageNamed:@"arr-2.png"] borderColor:orangeColor textColor:orangeColor bgColor:[UIColor whiteColor]];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    [vsl_sepator setupByMiddleView:iv_separator padding:5 lineHeight:1 lineColor:[UIColor whiteColor]];
    
    
}

-(void)dealloc
{
    NSLog(@":::::>dealloc %s %d",__FUNCTION__,__LINE__);
}
@end
