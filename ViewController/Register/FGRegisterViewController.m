//
//  FGRegisterViewController.m
//  DunkinDonuts
//
//  Created by Ryan Gong on 15/11/17.
//  Copyright © 2015年 Ryan Gong. All rights reserved.
//

#import "FGRegisterViewController.h"
#import "Global.h"

@interface FGRegisterViewController()
{
    
}
@end

@implementation FGRegisterViewController
@synthesize view_agreement;
@synthesize view_registerHome;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view_topPanel.str_title = multiLanguage(@"Become a member");
    [self.view_topPanel.btn_back removeFromSuperview];
    [self.view_topPanel.iv_back removeFromSuperview];
    self.view_topPanel.btn_back = nil;
    self.view_topPanel.iv_back=nil;
    self.iv_bg.image = [UIImage imageNamed:@"bg1.jpg"];
   [[UIApplication sharedApplication] setStatusBarHidden:NO];
    
    [self internalInitalAgreementView];
    [self internalInitalRegisterHomeView];

}

-(void)internalInitalRegisterHomeView
{
    view_registerHome = (FGRegisterHomeView *)[[[NSBundle mainBundle] loadNibNamed:@"FGRegisterHomeView" owner:nil options:nil] objectAtIndex:0];
    [self.view_contentView addSubview:view_registerHome];
    [view_registerHome.cb_register.button addTarget:self action:@selector(buttonAction_go2Register:) forControlEvents:UIControlEventTouchUpInside];
    [view_registerHome.cb_wechat.button addTarget:self action:@selector(buttonAction_loginUseWeChat:) forControlEvents:UIControlEventTouchUpInside];
     [view_registerHome.cb_weibo.button addTarget:self action:@selector(buttonAction_loginUseWeibo:) forControlEvents:UIControlEventTouchUpInside];
    [view_registerHome.btn_underline.btn addTarget:self action:@selector(buttonAction_maybeLater:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)internalInitalAgreementView
{
    view_agreement = (FGAgreementPanelView *)[[[NSBundle mainBundle] loadNibNamed:@"FGAgreementPanelView" owner:nil options:nil] objectAtIndex:0];
    [self.view addSubview:view_agreement];
    
    NSString *str_privacyPolicy = multiLanguage(@"Privacy Policy");
    NSString *str_terms = multiLanguage(@"Terms and Conditions.");
    NSString *htmlString = [NSString stringWithFormat:@"By continuing you agree to our %@&\n%@",str_privacyPolicy,str_terms];
    [view_agreement setupByString:htmlString linkStr:@[str_privacyPolicy,str_terms]];
}

-(void)manullyFixSize
{
    [super manullyFixSize];
    
    self.view_contentView.frame = CGRectMake(0, self.view_topPanel.frame.origin.y + self.view_topPanel.frame.size.height,
                                             W, H-self.view_topPanel.frame.origin.y-self.view_topPanel.frame.size.height - LAYOUT_BOTTOMVIEW_HEIGHT - view_agreement.frame.size.height);
    
    CGRect _frame = view_agreement.frame;
    _frame.size.width = self.view.frame.size.width;
    _frame.origin.y = self.view.frame.size.height - view_agreement.frame.size.height;
    view_agreement.frame = _frame;
    
    
    
    _frame = view_registerHome.frame;
    _frame.size.height = self.view_contentView.frame.size.height;
    _frame.size.width = self.view_contentView.frame.size.width;
    view_registerHome.frame = _frame;
    view_registerHome.center = CGPointMake(self.view_contentView.frame.size.width/2,self.view_contentView.frame.size.height / 2);
    
}

#pragma mark - buttonAction
-(void)buttonAction_go2Register:(id)_sender
{
    FGControllerManager *manager = [FGControllerManager sharedManager];
    [manager pushControllerByName:@"FGRegisterStepViewController" inNavigation:nav_main];
}

-(void)buttonAction_loginUseWeChat:(id)_sender
{
    WXApiWrapper *wxapiWrapper = [WXApiWrapper sharedManager];
    wxapiWrapper.delegate = self;
    [wxapiWrapper loginInViewController:self];
}

-(void)buttonAction_loginUseWeibo:(id)_sender
{
    WBApiWrapper *wbapiWrapper = [WBApiWrapper sharedManager];
    wbapiWrapper.delegate = self;
    [wbapiWrapper requestForWeiboAPIByType:WeiboSDKHttpRequestDemoTypeRequestForUserProfile];
}

-(void)buttonAction_maybeLater:(id)_sender
{
    NSString *_str_uuid = [[UIDevice currentDevice] uniqueDeviceIdentifier];
    NSMutableDictionary *_dic_requestUserInfo = [NSMutableDictionary dictionary];
    [_dic_requestUserInfo setObject:@"MaybeLater" forKey:@"isMaybeLater"];
    
    [[NetworkManager sharedManager] postRequest_login:_str_uuid passwd:DEFAULTPASSWD_MaybeLater loginChannel:LoginChannel_maybeLater authCode:@"" userinfo:_dic_requestUserInfo];
}

-(void)dealloc
{
    NSLog(@":::::>dealloc %s %d",__FUNCTION__,__LINE__);
}

-(void)do_go2UpdateUserinfoByType:(UserInfoBy)_userinfoby
{
    FGControllerManager *manager = [FGControllerManager sharedManager];
    FGLoginUpdateProfileViewController *vc_loginUpdateProfile = [[FGLoginUpdateProfileViewController alloc] initWithNibName:@"FGLoginUpdateProfileViewController" bundle:nil userInfoBy:_userinfoby];
    [manager pushController:vc_loginUpdateProfile navigationController:nav_main];
    
}


#pragma mark - 网络事件通知
-(void)receivedDataFromNetwork:(NSNotification *)_notification
{
    [super receivedDataFromNetwork:_notification];
    NSMutableDictionary *_dic_requestInfo = _notification.object;
    NSString *_str_url = [_dic_requestInfo objectForKey:@"url"];
    
    if([HOST(URL_Login) isEqualToString:_str_url])
    {
        UserInfoBy userinfoby = 0;
        if([[_dic_requestInfo allKeys] containsObject:@"UserInfoBy"])
        {
            userinfoby = [[_dic_requestInfo objectForKey:@"UserInfoBy"] intValue];
            [self do_go2UpdateUserinfoByType:userinfoby];
        }
        else if([[_dic_requestInfo allKeys] containsObject:@"isMaybeLater"])
        {
            NSMutableDictionary *_dic_requestUserInfo = [NSMutableDictionary dictionary];
            [_dic_requestUserInfo setObject:@"go2HomeFromMaybeLater" forKey:@"go2HomeFromMaybeLater"];
            [[NetworkManager sharedManager] postRequest_getHomeItemByByCity:nil userinfo:_dic_requestUserInfo];//TODO:fix it - 城市暂时不传
            
        }//登录成功以后直接请求首页数据
    }
    
    if([HOST(URL_GetHomeItem) isEqualToString:_str_url])
    {
        if([[_dic_requestInfo allKeys] containsObject:@"go2HomeFromMaybeLater"])
        {
            [self go2HomeScreen];
        }
        
    }//获得首页数据后进入首页
}


#pragma mark - WXApiWrapperDelegate
-(void)wxDidReceiveUserInfo:(NSMutableDictionary *)_dic_userinfo
{
   if(!_dic_userinfo)
       return;
    if([_dic_userinfo count]<=0)
        return;
    
    NSString *_str_openid = [_dic_userinfo objectForKey:@"openid"];
    NSMutableDictionary *_dic_requestUserInfo = [NSMutableDictionary dictionary];
    [_dic_requestUserInfo setObject:[NSNumber numberWithInt:UserInfoBy_WeChat] forKey:@"UserInfoBy"];
    
    [[NetworkManager sharedManager] postRequest_login:_str_openid passwd:DEFAULTPASSWD_WechatAndWeibo loginChannel:LoginChannel_wechat authCode:@"" userinfo:_dic_requestUserInfo];
}

#pragma mark - WBApiWrapperDelegate
-(void)wbDidReceiveUserInfo:(NSMutableDictionary *)_dic_userinfo
{
    if(!_dic_userinfo)
        return;
    if([_dic_userinfo count]<=0)
        return;
    NSString *_str_uid = [_dic_userinfo objectForKey:@"userID"];
    NSMutableDictionary *_dic_requestUserInfo = [NSMutableDictionary dictionary];
    [_dic_requestUserInfo setObject:[NSNumber numberWithInt:UserInfoBy_Weibo] forKey:@"UserInfoBy"];
    
    [[NetworkManager sharedManager] postRequest_login:_str_uid passwd:DEFAULTPASSWD_WechatAndWeibo loginChannel:LoginChannel_weibo authCode:@"" userinfo:_dic_requestUserInfo];
}
@end
