//
//  FGRegisterStepViewController.m
//  DunkinDonuts
//
//  Created by Ryan Gong on 15/11/19.
//  Copyright © 2015年 Ryan Gong. All rights reserved.
//

#import "FGRegisterStepViewController.h"
#import "Global.h"
#import "FGRegisterPhoneNumPasswdView.h"
#import "FGRegisterEnterCodeView.h"
#import "FGRegisterProfileView.h"
#import "FGRegisterFinishView.h"
#import "FGProgressStepDotView.h"
#import "FGDatePickerView.h"
#define KEYBOARD_HEIGHT 100
@interface FGRegisterStepViewController ()
{
  
}

@end

@implementation FGRegisterStepViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view_topPanel.str_title = multiLanguage(@"Register");
    self.view_topPanel.btn_back = nil;
    self.view_topPanel.iv_back = nil;
    self.iv_bg.image = [UIImage imageNamed:@"bg3.jpg"];
    
    [self internalInitalProgressDotView];
    [self internalInitalPhoneNumPasswdView];
}

-(void)dealloc
{
    NSLog(@":::::>dealloc %s %d",__FUNCTION__,__LINE__);
}
#pragma mark - 初始化子视图
-(void)internalInitalProgressDotView
{
    if(view_progressDotView)
        return;
    view_progressDotView = (FGProgressStepDotView *)[[[NSBundle mainBundle] loadNibNamed:@"FGProgressStepDotView" owner:nil options:nil] objectAtIndex:0];
    [self.view_contentView addSubview:view_progressDotView];
    
}

-(void)internalInitalPhoneNumPasswdView
{
    if(view_phonNumPasswd)
        return;
    view_phonNumPasswd = (FGRegisterPhoneNumPasswdView *)[[[NSBundle mainBundle] loadNibNamed:@"FGRegisterPhoneNumPasswdView" owner:nil options:nil] objectAtIndex:0];
    [self.view_contentView addSubview:view_phonNumPasswd];
    [view_phonNumPasswd.cub_loginnow.btn addTarget:self action:@selector(buttonAction_go2Login:) forControlEvents:UIControlEventTouchUpInside];
    [view_phonNumPasswd.cb_next.button addTarget:self action:@selector(buttonAction_go2VerifyMobileNo:) forControlEvents:UIControlEventTouchUpInside];
    
}

-(void)internalInitalEnterCodeView
{
    if(view_enterCode )
        return;
    view_enterCode = (FGREgisterEnterCodeView *)[[[NSBundle mainBundle] loadNibNamed:@"FGRegisterEnterCodeView" owner:nil options:nil] objectAtIndex:0];
    [self.view_contentView addSubview:view_enterCode];
    [view_enterCode.cub_resendCode.btn addTarget:self action:@selector(buttonAction_resend:) forControlEvents:UIControlEventTouchUpInside];
    [view_enterCode.cub_loginNow.btn addTarget:self action:@selector(buttonAction_go2Login:) forControlEvents:UIControlEventTouchUpInside];
    [view_enterCode.cb_next.button addTarget:self action:@selector(buttonAction_go2Profile:) forControlEvents:UIControlEventTouchUpInside];
    
}

-(void)internalInitalProfileView
{
    if(view_profile)
        return;
    view_profile = (FGRegisterProfileView *)[[[NSBundle mainBundle] loadNibNamed:@"FGRegisterProfileView" owner:nil options:nil] objectAtIndex:0];
    [self.view_contentView addSubview:view_profile];
    [view_profile.cb_submit.button addTarget:self action:@selector(buttonAction_submit:) forControlEvents:UIControlEventTouchUpInside];

}



-(void)internalInitalRegisterFinishView
{
    if(view_registerFinish)
        return;
    view_registerFinish = (FGRegisterFinishView *)[[[NSBundle mainBundle] loadNibNamed:@"FGRegisterFinishView" owner:nil options:nil] objectAtIndex:0];
    [self.view_contentView addSubview:view_registerFinish];
    [view_registerFinish.cb_done.button addTarget:self action:@selector(buttonAction_go2HomePage:) forControlEvents:UIControlEventTouchUpInside];
    
}

-(void)internalLayoutFinishView
{
    view_registerFinish.frame = self.view_contentView.bounds;
}

#pragma mark - 布局子视图
-(void)internalLayoutPhoneNumPasswdView
{
    if(!view_phonNumPasswd)
        return;
    CGRect _frame = view_phonNumPasswd.frame;
    _frame.size.width = self.view_contentView.frame.size.width;
    _frame.origin.y = view_progressDotView.frame.origin.y + view_progressDotView.frame.size.height+10;
    if(H<=568)
    {
        _frame.size.height = 220;
    }
    else
        _frame.size.height = self.view_contentView.frame.size.height - _frame.origin.y - currentKeyboardHeight;
    view_phonNumPasswd.frame = _frame;
    view_phonNumPasswd.center  = CGPointMake(self.view_contentView.frame.size.width/2, view_phonNumPasswd.center.y);
}

-(void)internalLayoutEnterCodeView
{
    if(!view_enterCode)
        return;
    CGRect _frame = view_enterCode.frame;
    _frame.size.width = self.view_contentView.frame.size.width;
    _frame.origin.y = view_progressDotView.frame.origin.y + view_progressDotView.frame.size.height+10;
    if(H<=568)
    {
        _frame.size.height = 220;
    }
    else
        _frame.size.height = self.view_contentView.frame.size.height - _frame.origin.y - currentKeyboardHeight;
    view_enterCode.frame = _frame;
    view_enterCode.center  = CGPointMake(self.view_contentView.frame.size.width/2, view_enterCode.center.y);
    
}

-(void)internalLayoutProfileView
{
    if(!view_profile)
        return;
    CGRect _frame = view_profile.frame;
    _frame.size.width = self.view_contentView.frame.size.width;
    _frame.origin.y = view_progressDotView.frame.origin.y + view_progressDotView.frame.size.height+10;
    if(H<=568)
    {
        _frame.size.height = 250;
    }
    else
        _frame.size.height = self.view_contentView.frame.size.height - _frame.origin.y - currentKeyboardHeight;
    view_profile.frame = _frame;
    view_profile.center  = CGPointMake(self.view_contentView.frame.size.width/2, view_profile.center.y);
}

-(void)internalLayoutProgressDotView
{
    if(!view_progressDotView)
        return;
    CGRect _frame = view_progressDotView.frame;
    _frame.origin.y = 0;
    _frame.size.width = self.view_contentView.frame.size.width / 1.5;
    view_progressDotView.frame = _frame;
    view_progressDotView.center = CGPointMake(self.view_contentView.frame.size.width/2, view_progressDotView.center.y);
}

#pragma mark - 从父类继承的手动布局方法,将在viewDidAppear和viewWillAppear时被调用
-(void)manullyFixSize
{
    [super manullyFixSize];
   NSLog(@":::::>%s %d",__FUNCTION__,__LINE__);
    [self internalLayoutProgressDotView];
    [self internalLayoutPhoneNumPasswdView];
    [self internalLayoutEnterCodeView];
    [self internalLayoutProfileView];
    [self internalLayoutFinishView];
    
}




-(void)do_go2VerfigyMobileNo
{
    [view_progressDotView highlightedByIndex:1];
    [view_phonNumPasswd removeFromSuperview];
    view_phonNumPasswd = nil;
    [self internalInitalEnterCodeView];
    [self manullyFixSize];
}

-(void)do_go2Profile
{
    [view_progressDotView highlightedByIndex:2];
    [view_enterCode removeFromSuperview];
    view_enterCode = nil;
    [self internalInitalProfileView];
    [self manullyFixSize];
}

-(void)do_submitProfile
{
    if(view_progressDotView)
    {
        [view_progressDotView removeFromSuperview];
        view_progressDotView = nil;
    }
    [view_profile removeFromSuperview];
    view_profile = nil;
    [self internalInitalRegisterFinishView];
    [self manullyFixSize];
    

}

#pragma mark - button Action



#pragma mark - button in FGRegisterPhoneNumPasswdView
-(void)buttonAction_go2VerifyMobileNo:(id)_sender
{

    NSString *_str_mobile = view_phonNumPasswd.ctf_mobile.tf.text;
    NSString *_str_passwd = view_phonNumPasswd.ctf_passwd.tf.text;
    NSString *str_errorMessage = nil;
    if([StringValidate isEmpty:_str_mobile])
        str_errorMessage = multiLanguage(@"手机号码必须是11位的数字");
    else if([_str_passwd length] < 6 || [_str_passwd length] > 11)
        str_errorMessage = multiLanguage(@"密码必须是6-16位");
    else if(![StringValidate isMobileNum:_str_mobile ])
        str_errorMessage = multiLanguage(@"手机号码格式不正确");
    if(str_errorMessage)
    {
        [self alert:multiLanguage(@"警告") message:multiLanguage(str_errorMessage) callback:nil];
    }
    else
    {
        [[NetworkManager sharedManager] postRequest_getMobileCodeByMobile:view_phonNumPasswd.ctf_mobile.tf.text passwd:view_phonNumPasswd.ctf_passwd.tf.text userinfo:nil];
    }
    
}

-(void)buttonAction_go2Login:(id)_sender
{
    [nav_main popToRootViewControllerAnimated:NO];
    FGControllerManager *manager = [FGControllerManager sharedManager];
    [manager pushControllerByName:@"FGLoginViewController" inNavigation:nav_main withAnimtae:NO];
}

#pragma mark - button in FGRegisterEnterCodeView
-(void)buttonAction_resend:(id)_sender
{
    
}

-(void)buttonAction_go2Profile:(id)_sender
{

    NSString *_str_verifyCode = view_enterCode.ct_enterCode.tf.text;
    NSString *str_errorMessage = nil;
    if([_str_verifyCode length]<6 || [_str_verifyCode length]>16)
        str_errorMessage = multiLanguage(@"验证码必须是6位的数字");
    if(str_errorMessage)
    {
        [self alert:multiLanguage(@"警告") message:multiLanguage(str_errorMessage) callback:nil];
    }
    else
    {
        [[NetworkManager sharedManager] postRequest_sendRegMobileCode:view_enterCode.ct_enterCode.tf.text userinfo:nil];
    }
    
}

#pragma mark - button in FGRegisterProfileView
-(void)buttonAction_submit:(id)_sender
{

    
    NSString *_str_name = view_profile.ctf_name.tf.text;
    NSString *_str_mobile = view_profile.ctf_mobile.tf.text;
    NSString *_str_email = view_profile.ctf_email.tf.text;
    NSString *_str_gender = view_profile.cb_gender.lb_title.text;
    NSString *_str_birthday = view_profile.cb_birthday.lb_title.text;
    NSString *str_errorMessage = nil;
    if([_str_name length]<=0)
        str_errorMessage = multiLanguage(@"用户名不能为空");
    else if([multiLanguage(@"Gender*") isEqualToString: _str_gender])
        str_errorMessage = multiLanguage(@"您还没有选择您的性别");
    else if([multiLanguage(@"Birthday*") isEqualToString: _str_birthday])
        str_errorMessage = multiLanguage(@"您还没有选择您的生日");
    else if([StringValidate isEmpty:_str_mobile])
        str_errorMessage = multiLanguage(@"手机号码必须是11位的数字");
    else if(![StringValidate isMobileNum:_str_mobile ])
        str_errorMessage = multiLanguage(@"手机号码格式不正确");
    else if(![StringValidate isEmpty:_str_email]&&![StringValidate isEmail:_str_email ])
        str_errorMessage = multiLanguage(@"电子邮件格式不正确");
    
    
    if(str_errorMessage)
    {
        [self alert:multiLanguage(@"警告") message:multiLanguage(str_errorMessage) callback:nil];
    }
    else
    {
        if(!_str_email)
            _str_email = @"";
         [[NetworkManager sharedManager] postRequest_setUserInfo:_str_name gender:_str_gender birthday:_str_birthday mobile:_str_mobile email:_str_email usericon:nil userinfo:nil];
    }
   
}

#pragma mark - button in FGRegisterFinishView
-(void)buttonAction_go2HomePage:(id)_sender
{
    NSMutableDictionary *_dic_requestUserInfo = [NSMutableDictionary dictionary];
    [_dic_requestUserInfo setObject:@"go2HomeFromRegisterFinish" forKey:@"go2HomeFromRegisterFinish"];
    [[NetworkManager sharedManager] postRequest_getHomeItemByByCity:nil userinfo:_dic_requestUserInfo];//TODO:fix it - 城市暂时不传
}

#pragma mark - 网络事件通知
-(void)receivedDataFromNetwork:(NSNotification *)_notification
{
    [super receivedDataFromNetwork:_notification];
    NSMutableDictionary *_dic_requestInfo = _notification.object;
    NSString *_str_url = [_dic_requestInfo objectForKey:@"url"];
    
    if([HOST(URL_GetMobileCode) isEqualToString:_str_url])
    {
        [self do_go2VerfigyMobileNo];
    }
    if([HOST(URL_SendRegMobileCode) isEqualToString:_str_url])
    {
        [self do_go2Profile];
    }
    if([HOST(URL_SetUserInfo) isEqualToString:_str_url])
    {
        [self do_submitProfile];
    }
    if([HOST(URL_GetHomeItem) isEqualToString:_str_url])
    {
        if([[_dic_requestInfo allKeys] containsObject:@"go2HomeFromRegisterFinish"])
        {
            [self go2HomeScreen];
        }
        
    }//获得首页数据后进入首页
}

@end
