//
//  FGRegisterPhoneNumPasswdView.m
//  DunkinDonuts
//
//  Created by Ryan Gong on 15/11/19.
//  Copyright © 2015年 Ryan Gong. All rights reserved.
//

#import "FGRegisterProfileView.h"
#import "Global.h"
@implementation FGRegisterProfileView
@synthesize ctf_email;
@synthesize ctf_mobile;
@synthesize ctf_name;
@synthesize cb_submit;
@synthesize cb_birthday;
@synthesize cb_gender;
-(void)awakeFromNib
{
    [super awakeFromNib];
    self.backgroundColor = [UIColor clearColor];
    ctf_name.delegate = self;
    ctf_mobile.delegate = self;
    ctf_email.delegate = self;
    
    ctf_mobile.tf.keyboardType = UIKeyboardTypeNumberPad;
    ctf_email.tf.keyboardType = UIKeyboardTypeEmailAddress;
    
    ctf_name.tf.placeholder = multiLanguage(@"Name*");
    ctf_mobile.tf.placeholder = multiLanguage(@"Mobile*");
    ctf_email.tf.placeholder = multiLanguage(@"Email");
    
    
    ctf_mobile.maxInputLength = 11;
    ctf_name.maxInputLength = 15;
    ctf_email.maxInputLength = 30;
    
    [cb_gender setFrame:cb_gender.frame title:multiLanguage(@"Gender*") arrimg:[UIImage imageNamed:@"down.png"] borderColor:nil textColor:[UIColor lightGrayColor] bgColor:[UIColor whiteColor] needTitleLeftAligment:YES];
    [cb_birthday setFrame:cb_birthday.frame title:multiLanguage(@"Birthday*") arrimg:[UIImage imageNamed:@"down.png"] borderColor:nil textColor:[UIColor lightGrayColor] bgColor:[UIColor whiteColor] needTitleLeftAligment:YES];
     [cb_submit setFrame:cb_submit.frame title:multiLanguage(@"SUBMIT")  arrimg:[UIImage imageNamed:@"arr-2.png"] borderColor:orangeColor textColor:orangeColor bgColor:[UIColor whiteColor]];
    [cb_gender.button addTarget:self action:@selector(buttonAction_gender:) forControlEvents:UIControlEventTouchUpInside];
    [cb_birthday.button addTarget:self action:@selector(buttonAction_birthday:) forControlEvents:UIControlEventTouchUpInside];
    if(H<=568)
    {
        isNeedViewMoveUpWhenKeyboardShow = YES;
        heightNeedMoveWhenKeybaordShow = 70;
    }
    else
    {
        isNeedViewMoveUpWhenKeyboardShow = NO;
        [ctf_name.tf becomeFirstResponder];
    }
    NSLog(@":::::>%s %d",__FUNCTION__,__LINE__);
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    NSLog(@":::::>%s %d",__FUNCTION__,__LINE__);
    cb_gender.lb_title.font = font(FONT_NORMAL, 16);
    cb_birthday.lb_title.font = font(FONT_NORMAL, 16);
   
}

-(void)dealloc
{
    NSLog(@":::::>dealloc %s %d",__FUNCTION__,__LINE__);
    if(view_daypick)
    {
        [view_daypick removeFromSuperview];
        view_daypick = nil;
    }
    if(view_datapicker)
    {
        [view_datapicker removeFromSuperview];
        view_datapicker = nil;
    }
}

-(void)buttonAction_gender:(id)_sender
{
    if(view_datapicker)
        return;
    
    
    [ctf_name.tf resignFirstResponder];
    [ctf_mobile.tf resignFirstResponder];
    [ctf_email.tf resignFirstResponder];
    [self removeDayPicker];
    
    view_datapicker = (FGDataPickeriView *)[[[NSBundle mainBundle] loadNibNamed:@"FGDataPickeriView" owner:nil options:nil] objectAtIndex:0];
    view_datapicker.delegate = self;
    [view_datapicker setupDatas:@[multiLanguage(@"男"),multiLanguage(@"女")]];
    CGRect _frame = view_datapicker.frame;
    _frame.size.width = self.frame.size.width;
    _frame.origin.y = H;
    view_datapicker.frame = _frame;
    view_datapicker.center = CGPointMake(self.frame.size.width / 2, view_datapicker.center.y);
    [nav_main.topViewController.view addSubview:view_datapicker];
    
    [UIView beginAnimations:nil context:nil];
    _frame = view_datapicker.frame;
    _frame.origin.y = H - view_datapicker.frame.size.height;
    view_datapicker.frame = _frame;
    [UIView commitAnimations];
}

-(void)buttonAction_birthday:(id)_sender
{
    if(view_daypick)
        return;
    
    [ctf_name.tf resignFirstResponder];
    [ctf_mobile.tf resignFirstResponder];
    [ctf_email.tf resignFirstResponder];
    [self removeDataPicker];
    
    view_daypick = (FGDatePickerView *)[[[NSBundle mainBundle] loadNibNamed:@"FGDatePickerView" owner:nil options:nil] objectAtIndex:0];
    view_daypick.delegate = self;
    CGRect _frame = view_daypick.frame;
    _frame.size.width = self.frame.size.width;
    _frame.origin.y = H;
    view_daypick.frame = _frame;
    view_daypick.center = CGPointMake(self.frame.size.width / 2, view_daypick.center.y);
    [nav_main.topViewController.view addSubview:view_daypick];
    
    [UIView beginAnimations:nil context:nil];
    _frame = view_daypick.frame;
    _frame.origin.y = H-view_daypick.frame.size.height;
    view_daypick.frame = _frame;
    [UIView commitAnimations];
    
}

#pragma mark -  FGCustomTextFieldDelegate
-(void)didBeginEditing:(UITextField *)_tf
{
    [self removeDayPicker];
    [self removeDataPicker];
}

-(void)didClickDoneOnTextField:(UITextField *)_tf
{
    
}

-(void)removeDayPicker
{
    if(!view_daypick)
        return;
    if(view_daypick.frame.origin.y>=H)
        return;
    [UIView animateWithDuration:.3 animations:^{
        CGRect _frame = view_daypick.frame;
        _frame.origin.y = H;
        view_daypick.frame = _frame;
    }completion:^(BOOL _finished){
       if(_finished)
       {
           [view_daypick removeFromSuperview];
           view_daypick = nil;
       }
    }];
}

-(void)removeDataPicker
{
    if(!view_datapicker)
        return;
    if(view_datapicker.frame.origin.y>=H)
        return;
    [UIView animateWithDuration:.3 animations:^{
        CGRect _frame = view_datapicker.frame;
        _frame.origin.y = H;
        view_datapicker.frame = _frame;
    }completion:^(BOOL _finished){
        if(_finished)
        {
            [view_datapicker removeFromSuperview];
            view_datapicker = nil;
        }
    }];
}


#pragma mark - FGDatePickerViewDelegate
-(void)didSelectedDate:(NSString *)_str_date
{
    cb_birthday.iv_arr.hidden = YES;
    cb_birthday.lb_title.text = _str_date;
    cb_birthday.lb_title.textColor = [UIColor blackColor];
    [self removeDayPicker];
}

#pragma mark - FGDataPickerViewDelegate
-(void)didSelectData:(NSString *)_str_selected
{
    cb_gender.iv_arr.hidden = YES;
    cb_gender.lb_title.text = _str_selected;
    cb_gender.lb_title.textColor = [UIColor blackColor];
    [self removeDataPicker];
}
@end
