//
//  FGRegisterPhoneNumPasswdView.m
//  DunkinDonuts
//
//  Created by Ryan Gong on 15/11/19.
//  Copyright © 2015年 Ryan Gong. All rights reserved.
//

#import "FGRegisterPhoneNumPasswdView.h"
#import "Global.h"
@implementation FGRegisterPhoneNumPasswdView
@synthesize ctf_mobile;
@synthesize ctf_passwd;
@synthesize cb_next;
@synthesize lb_hyperLink;
@synthesize cub_loginnow;
-(void)awakeFromNib
{
    [super awakeFromNib];
    self.backgroundColor = [UIColor clearColor];
    ctf_mobile.delegate = self;
    ctf_passwd.delegate = self;
    
    ctf_mobile.tf.keyboardType = UIKeyboardTypeNumberPad;
    ctf_passwd.tf.secureTextEntry = YES;
    ctf_mobile.tf.placeholder = multiLanguage(@"Mobile Number");
    ctf_passwd.tf.placeholder = multiLanguage(@"Create Password(6-16 characters)");
    [cub_loginnow.btn setTitle:multiLanguage(@"Login in now") forState:UIControlStateNormal];
    
    lb_hyperLink.text = multiLanguage(@"Already a member?");
    lb_hyperLink.font = font(FONT_NORMAL, 12);
    ctf_mobile.maxInputLength = 11;
    ctf_passwd.maxInputLength = 16;
    [cb_next setFrame:cb_next.frame title:@"NEXT" arrimg:[UIImage imageNamed:@"arr-2.png"] borderColor:orangeColor textColor:orangeColor bgColor:[UIColor whiteColor]];
    if(H<=568)
    {
        isNeedViewMoveUpWhenKeyboardShow = YES;
        heightNeedMoveWhenKeybaordShow = 50;
    }
    else
    {
        isNeedViewMoveUpWhenKeyboardShow = NO;
        [ctf_mobile.tf becomeFirstResponder];
    }
}

-(void)layoutSubviews
{
    [super layoutSubviews];
}

-(void)dealloc
{
    NSLog(@":::::>dealloc %s %d",__FUNCTION__,__LINE__);
    ctf_mobile.delegate = nil;
    ctf_passwd.delegate = nil;
}


#pragma mark -  FGCustomTextFieldDelegate
-(void)didClickDoneOnTextField:(UITextField *)_tf
{
    NSLog(@"_tf = %@",_tf);
}

-(void)didBeginEditing:(UITextField *)_tf
{
    
}
@end
