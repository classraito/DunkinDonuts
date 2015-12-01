//
//  FGLoginPhoneNumPasswdView.m
//  DunkinDonuts
//
//  Created by Ryan Gong on 15/11/23.
//  Copyright © 2015年 Ryan Gong. All rights reserved.
//

#import "FGLoginPhoneNumPasswdView.h"
#import "Global.h"
@implementation FGLoginPhoneNumPasswdView
@synthesize cub_forgetPasswd;
-(void)awakeFromNib
{
    [super awakeFromNib];
    self.backgroundColor = [UIColor clearColor];
   
    [self.cub_loginnow.btn setTitle:multiLanguage(@"Enroll now") forState:UIControlStateNormal];
    [cub_forgetPasswd.btn setTitle:multiLanguage(@"Forget Passwd?") forState:UIControlStateNormal];
    self.lb_hyperLink.text = multiLanguage(@"Need a Dunkin Donut account now?");
    self.lb_hyperLink.font = font(FONT_NORMAL, 12);
  
        isNeedViewMoveUpWhenKeyboardShow = NO;
        [self.ctf_mobile.tf becomeFirstResponder];
        
    

}

-(void)layoutSubviews
{
    [super layoutSubviews];
    [self.cb_next setFrame:self.cb_next.frame title:@"SUBMIT" arrimg:[UIImage imageNamed:@"arr-2.png"] borderColor:orangeColor textColor:orangeColor bgColor:[UIColor whiteColor]];
}



-(void)dealloc
{
    NSLog(@":::::>dealloc %s %d",__FUNCTION__,__LINE__);
}


#pragma mark -  FGCustomTextFieldDelegate
-(void)didClickDoneOnTextField:(UITextField *)_tf
{
    NSLog(@"_tf = %@",_tf);
}


@end
