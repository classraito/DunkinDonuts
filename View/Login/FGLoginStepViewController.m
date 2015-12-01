//
//  FGLoginStepViewController.m
//  DunkinDonuts
//
//  Created by Ryan Gong on 15/11/23.
//  Copyright © 2015年 Ryan Gong. All rights reserved.
//

#import "FGLoginStepViewController.h"
#import "Global.h"
#import "FGLoginPhoneNumPasswdView.h"

@interface FGLoginStepViewController ()
{
    FGLoginPhoneNumPasswdView *view_phonNumPasswd;
}
@end

@implementation FGLoginStepViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view_topPanel.str_title = multiLanguage(@"Log In");
    self.view_topPanel.btn_back = nil;
    self.view_topPanel.iv_back = nil;
    self.iv_bg.image = [UIImage imageNamed:@"bg3.jpg"];
    
    if(view_phonNumPasswd)
        return;
    view_phonNumPasswd = (FGLoginPhoneNumPasswdView *)[[[NSBundle mainBundle] loadNibNamed:@"FGLoginPhoneNumPasswdView" owner:nil options:nil] objectAtIndex:0];
    [self.view_contentView addSubview:view_phonNumPasswd];
    [view_phonNumPasswd.cub_forgetPasswd.btn addTarget:self action:@selector(buttonAction_forgetPasswd:) forControlEvents:UIControlEventTouchUpInside];
    [view_phonNumPasswd.cb_next.button addTarget:self action:@selector(buttonAction_submit:) forControlEvents:UIControlEventTouchUpInside];
    [view_phonNumPasswd.cub_loginnow.btn addTarget:self action:@selector(buttonAction_enroll:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)manullyFixSize
{
    [super manullyFixSize];
    if(!view_phonNumPasswd)
        return;
    CGRect _frame = view_phonNumPasswd.frame;
    _frame.size.width = self.view_contentView.frame.size.width;
    _frame.origin.y = 57;
    if(H<=568)
    {
       _frame.origin.y = 0;
    }
    
        _frame.size.height = self.view_contentView.frame.size.height - _frame.origin.y - currentKeyboardHeight;
    view_phonNumPasswd.frame = _frame;
    view_phonNumPasswd.center  = CGPointMake(self.view_contentView.frame.size.width/2, view_phonNumPasswd.center.y);
}

-(void)dealloc
{
    NSLog(@":::::>dealloc %s %d",__FUNCTION__,__LINE__);
}

#pragma mark - 网络事件通知
-(void)receivedDataFromNetwork:(NSNotification *)_notification
{
    [super receivedDataFromNetwork:_notification];
    NSMutableDictionary *_dic_requestInfo = _notification.object;
    NSString *_str_url = [_dic_requestInfo objectForKey:@"url"];
    if([HOST(URL_Login) isEqualToString:_str_url])
    {
        if([[_dic_requestInfo allKeys] containsObject:@"isMobileLogin"])
        {
            NSMutableDictionary *_dic_requestUserInfo = [NSMutableDictionary dictionary];
            [_dic_requestUserInfo setObject:@"go2HomeFromMobileLogin" forKey:@"go2HomeFromMobileLogin"];
            [[NetworkManager sharedManager] postRequest_getHomeItemByByCity:nil userinfo:_dic_requestUserInfo];//TODO:fix it - 城市暂时不传
            
        }//登录成功以后直接请求首页数据
    }
    if([HOST(URL_GetHomeItem) isEqualToString:_str_url])
    {
        if([[_dic_requestInfo allKeys] containsObject:@"go2HomeFromMobileLogin"])
        {
            [self go2HomeScreen];
        }
        NSLog(@"::::::>go2HomeScreen");
    }//获得首页数据后进入首页
}

#pragma mark - buttonAction
-(void)buttonAction_enroll:(id)_enroll
{
    [nav_main popToRootViewControllerAnimated:NO];
    FGControllerManager *manager = [FGControllerManager sharedManager];
    [manager pushControllerByName:@"FGRegisterViewController" inNavigation:nav_main withAnimtae:NO];
}

-(void)buttonAction_forgetPasswd:(id)_forgetPasswd
{
    
}

-(void)buttonAction_submit:(id)_sender
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
        NSMutableDictionary *_dic_requestUserInfo = [NSMutableDictionary dictionary];
        [_dic_requestUserInfo setObject:@"MobileLogin" forKey:@"isMobileLogin"];
        [[NetworkManager sharedManager] postRequest_login:_str_mobile passwd:_str_passwd loginChannel:LoginChannel_mobile authCode:@"" userinfo:_dic_requestUserInfo];
    }
}
@end
