//
//  FGLoginUpdateProfileViewController.m
//  DunkinDonuts
//
//  Created by Ryan Gong on 15/11/24.
//  Copyright © 2015年 Ryan Gong. All rights reserved.
//

#import "FGLoginUpdateProfileViewController.h"
#import "Global.h"
#import "FGRegisterPhoneNumPasswdView.h"
#import "FGRegisterEnterCodeView.h"
#import "FGRegisterProfileView.h"
#import "FGRegisterFinishView.h"
#import "FGProgressStepDotView.h"
#import "FGDatePickerView.h"
#import "FGCustomTextFieldView.h"
@interface FGLoginUpdateProfileViewController ()
{
    UserInfoBy userinfoBy;
}
@end

@implementation FGLoginUpdateProfileViewController
-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil userInfoBy:(UserInfoBy)_userinfoBy
{
    if(self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])
    {
        userinfoBy = _userinfoBy;
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view_topPanel.str_title = multiLanguage(@"Almost Done");
    self.iv_bg.image = [UIImage imageNamed:@"bg3.jpg"];
    [view_progressDotView removeFromSuperview];
    view_progressDotView = nil;
    [view_phonNumPasswd removeFromSuperview];
    view_phonNumPasswd = nil;
    [self internalInitalProfileView];
    [self bindDataByWeChatInfoIfNeeded];
    [self bindDataByWeiboInfoIfNeeded];
}

-(void)bindDataByWeChatInfoIfNeeded
{
    
    if(userinfoBy != UserInfoBy_WeChat)
        return;
    NSString *str_userinfo_jsonData = nil;
    str_userinfo_jsonData = [commond getFromKeyChain:KEYCHAIN_KEY_WECHATUSERINFO];//从keychain里拿到微信用户信息
    NSMutableDictionary *_dic_userinfo = [str_userinfo_jsonData objectFromJSONString];
    NSString *_str_username = [_dic_userinfo objectForKey:@"nickname"];
    int gender = [[_dic_userinfo objectForKey:@"sex"] intValue];
    NSString *_str_gender = nil;
    if(gender == 1)
        _str_gender = multiLanguage(@"男");
    else if(gender == 2)
        _str_gender = multiLanguage(@"女");
    
    if(_str_username)
    {
       view_profile.ctf_name.tf.text = _str_username;
    }
    
    
    if(_str_gender)
    {
         view_profile.cb_gender.lb_title.text = _str_gender;
        view_profile.cb_gender.lb_title.textColor = [UIColor blackColor];
    }
}

-(void)bindDataByWeiboInfoIfNeeded
{
    if(userinfoBy != UserInfoBy_Weibo)
        return;
    NSString *str_userinfo_jsonData = nil;
    str_userinfo_jsonData = [commond getFromKeyChain:KEYCHAIN_KEY_WEIBOUSERINFO];//从keychain里拿到微信用户信息
    NSMutableDictionary *_dic_userinfo = [str_userinfo_jsonData objectFromJSONString];
    NSString *_str_username = nil;
    _str_username = [_dic_userinfo objectForKey:@"name"];
    NSString *_str_gender = nil;
    NSString *_str_gender_temp = [_dic_userinfo objectForKey:@"gender"];
    if(_str_gender_temp)
    {
        if([@"m" isEqualToString:_str_gender_temp])
        {
            _str_gender = multiLanguage(@"男");
        }
        else if([@"f" isEqualToString:_str_gender_temp])
        {
            _str_gender = multiLanguage(@"女");
        }
    }
    if(_str_username)
    {
        view_profile.ctf_name.tf.text = _str_username;
    }
    
    
    if(_str_gender)
    {
        view_profile.cb_gender.lb_title.text = _str_gender;
        view_profile.cb_gender.lb_title.textColor = [UIColor blackColor];
    }
        
    
}

-(void)manullyFixSize
{
    [super manullyFixSize];
    
    if(!view_profile)
        return;
    CGRect _frame = view_profile.frame;
    _frame.size.width = self.view_contentView.frame.size.width;
    _frame.origin.y = 10;
    if(H<=568)
    {
        _frame.size.height = 250;
    }
    else
        _frame.size.height = self.view_contentView.frame.size.height - _frame.origin.y - currentKeyboardHeight;
    view_profile.frame = _frame;
    view_profile.center  = CGPointMake(self.view_contentView.frame.size.width/2, view_profile.center.y);
     NSLog(@"2.view_profile.cb_gender.lb_title.text = %@",view_profile.cb_gender.lb_title.text);
}

-(void)dealloc
{
    NSLog(@":::::>dealloc %s %d",__FUNCTION__,__LINE__);
}
@end
