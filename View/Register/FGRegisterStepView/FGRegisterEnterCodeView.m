//
//  FGRegisterPhoneNumPasswdView.m
//  DunkinDonuts
//
//  Created by Ryan Gong on 15/11/19.
//  Copyright © 2015年 Ryan Gong. All rights reserved.
//

#import "FGREgisterEnterCodeView.h"
#import "Global.h"
@implementation FGREgisterEnterCodeView
@synthesize ct_enterCode;
@synthesize lb_description;
@synthesize cub_resendCode;
@synthesize cb_next;
@synthesize view_container;
@synthesize cub_loginNow;
@synthesize lb_hyperlink;
-(void)awakeFromNib
{
    [super awakeFromNib];
    self.backgroundColor = [UIColor clearColor];
    ct_enterCode.delegate = self;
    ct_enterCode.tf.keyboardType = UIKeyboardTypeNumberPad;
    ct_enterCode.tf.placeholder = multiLanguage(@"Enter Code");
    ct_enterCode.maxInputLength = 30;
    
    lb_description.text = multiLanguage(@"A verification code was send to your mobile");
    lb_description.font = font(FONT_NORMAL,12);
    
    lb_hyperlink.font = font(FONT_NORMAL, 12);
    lb_hyperlink.text = multiLanguage(@"Already a member?");
    
    [cub_loginNow.btn setTitle:multiLanguage(@"Login in now") forState:UIControlStateNormal];
    [cub_resendCode.btn setTitle:multiLanguage(@"Resend Code?") forState:UIControlStateNormal];
  
    isNeedViewMoveUpWhenKeyboardShow = NO;
    [ct_enterCode.tf becomeFirstResponder];
    
  [cb_next setFrame:cb_next.frame title:@"NEXT" arrimg:[UIImage imageNamed:@"arr-2.png"] borderColor:orangeColor textColor:orangeColor bgColor:[UIColor whiteColor]];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    
    CGRect _frame = self.frame;
    _frame.size.height = view_container.frame.origin.y + view_container.frame.size.height;
    self.frame = _frame;
}

-(void)dealloc
{
    NSLog(@":::::>dealloc %s %d",__FUNCTION__,__LINE__);
    ct_enterCode.delegate = nil;
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
