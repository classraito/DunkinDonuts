//
//  WBApiManager.m
//  DunkinDonuts
//
//  Created by Ryan Gong on 15/11/11.
//  Copyright © 2015年 Ryan Gong. All rights reserved.
//

#import "WBApiWrapper.h"
#import "Global.h"
#import "WeiboUser.h"
#define KEY_LOGINTYPE @"KEY_LOGINTYPE"
#pragma mark - 内部方法
@implementation WBApiWrapper(Private)

- (void)dealloc {
    self.wbRefreshToken = nil;
    self.wbtoken = nil;
    self.wbCurrentUserID = nil;
}

/*用户授权*/
-(void)doLogin:(WeiboSDKHttpRequestDemoType)_wbRequestType
{
    WBAuthorizeRequest *request = [WBAuthorizeRequest request];
    request.redirectURI = kRedirectURI;
    request.scope = @"all";
    request.userInfo = @{KEY_LOGINTYPE:[NSString stringWithFormat:@"%ld",_wbRequestType]};
    [WeiboSDK sendRequest:request];
}

/*请求用户信息API*/
- (void)requestForUserProfile:(NSString *)_str_userid
{
    [WBHttpRequest requestForUserProfile:_str_userid withAccessToken:self.wbtoken andOtherProperties:nil queue:nil withCompletionHandler:^(WBHttpRequest *httpRequest, id result, NSError *error) {
        if([result isKindOfClass:[WeiboUser class]])
        {
            WeiboUser *wbUser = (WeiboUser *)result;
            [self saveUserInfo:wbUser];
//            [self requestHanlder:httpRequest result:result error:error];
        }
    }];
}

/*通用处理微博API返回信息*/
-(void)requestHanlder:(WBHttpRequest *)httpRequest result:(id)result error:(NSError *)error
{
    NSString *title = nil;
    UIAlertView *alert = nil;
    
    if (error)
    {
        title = NSLocalizedString(@"请求异常", nil);
        alert = [[UIAlertView alloc] initWithTitle:title
                                           message:[NSString stringWithFormat:@"%@",error]
                                          delegate:nil
                                 cancelButtonTitle:NSLocalizedString(@"确定", nil)
                                 otherButtonTitles:nil];
    }//TODO:exception
    else
    {
        
        
        title = NSLocalizedString(@"收到网络回调", nil);
        alert = [[UIAlertView alloc] initWithTitle:title
                                           message:[NSString stringWithFormat:@"%@",result]
                                          delegate:nil
                                 cancelButtonTitle:NSLocalizedString(@"确定", nil)
                                 otherButtonTitles:nil];
    }
    
    [alert show];
}

/*保存用户信息*/
-(void)saveUserInfo:(WeiboUser*)wbUser
{
    NSMutableDictionary *_dic_userInfo = [NSMutableDictionary dictionaryWithCapacity:1];
    [_dic_userInfo setObjectSafty:wbUser.userID forKey:@"userID"];
    [_dic_userInfo setObjectSafty:wbUser.userClass forKey:@"userClass"];
    [_dic_userInfo setObjectSafty:wbUser.screenName forKey:@"screenName"];
    [_dic_userInfo setObjectSafty:wbUser.name forKey:@"name"];
    [_dic_userInfo setObjectSafty:wbUser.province forKey:@"province"];
    [_dic_userInfo setObjectSafty:wbUser.city forKey:@"city"];
    [_dic_userInfo setObjectSafty:wbUser.location forKey:@"location"];
    [_dic_userInfo setObjectSafty:wbUser.userDescription forKey:@"userDescription"];
    [_dic_userInfo setObjectSafty:wbUser.url forKey:@"url"];
    [_dic_userInfo setObjectSafty:wbUser.profileImageUrl forKey:@"profileImageUrl"];
    [_dic_userInfo setObjectSafty:wbUser.coverImageUrl forKey:@"coverImageUrl"];
    [_dic_userInfo setObjectSafty:wbUser.coverImageForPhoneUrl forKey:@"coverImageForPhoneUrl"];
    [_dic_userInfo setObjectSafty:wbUser.profileUrl forKey:@"profileUrl"];
    [_dic_userInfo setObjectSafty:wbUser.userDomain forKey:@"userDomain"];
    [_dic_userInfo setObjectSafty:wbUser.weihao forKey:@"weihao"];
    [_dic_userInfo setObjectSafty:wbUser.gender forKey:@"gender"];
    [_dic_userInfo setObjectSafty:wbUser.followersCount forKey:@"followersCount"];
    [_dic_userInfo setObjectSafty:wbUser.friendsCount forKey:@"friendsCount"];
    [_dic_userInfo setObjectSafty:wbUser.pageFriendsCount forKey:@"pageFriendsCount"];
    [_dic_userInfo setObjectSafty:wbUser.statusesCount forKey:@"statusesCount"];
    [_dic_userInfo setObjectSafty:wbUser.favouritesCount forKey:@"favouritesCount"];
    [_dic_userInfo setObjectSafty:wbUser.createdTime forKey:@"createdTime"];
    [_dic_userInfo setObjectSafty:wbUser.language forKey:@"language"];
    NSError *error;
    NSData* jsonData = [NSJSONSerialization dataWithJSONObject:_dic_userInfo options:NSJSONWritingPrettyPrinted error:&error];//利用系统自带 JSON 工具封装 JSON 数据
    if(jsonData)
    {
        NSString *str_userinfo_json = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        
        if(self.delegate && [self.delegate respondsToSelector:@selector(wbDidReceiveUserInfo:)])
        {
            [self.delegate wbDidReceiveUserInfo:_dic_userInfo];
        }
        
        [commond saveToKeyChain:KEYCHAIN_KEY_WEIBOUSERINFO passwd:str_userinfo_json];//将微信用户信息保存到keychain中
        str_userinfo_json = nil;
    }
}
@end

#pragma mark - 外部方法
@implementation WBApiWrapper
@synthesize wbtoken;
@synthesize wbCurrentUserID;
@synthesize wbRefreshToken;
@synthesize delegate;
/*单例实例化*/
+(instancetype)sharedManager {
    static dispatch_once_t onceToken;
    static WBApiWrapper *instance;
    dispatch_once(&onceToken, ^{
        instance = [[WBApiWrapper alloc] init];
        
    });
    return instance;
}

/*登入*/
- (void)login
{
    [self doLogin:WeiboSDKHttpRequestDemoTypeRequestForUserProfile];
}

/*登出*/
- (void)logout
{
    [WeiboSDK logOutWithToken:self.wbtoken delegate:self withTag:@"user1"];
}

/*分享功能*/
- (void)shareToWeibo:(WBMessageObject*)_message
{
    if(!_message)
        return;
    
    WBAuthorizeRequest *authRequest = [WBAuthorizeRequest request];
    authRequest.redirectURI = kRedirectURI;
    authRequest.scope = @"all";
    
    WBSendMessageToWeiboRequest *request = [WBSendMessageToWeiboRequest requestWithMessage:_message authInfo:authRequest access_token:self.wbtoken];
    //request.shouldOpenWeiboAppInstallPageIfNotInstalled = NO;
    [WeiboSDK sendRequest:request];
}

/*被外部调用，请求微博API webapi的回调由请求自身的block处理返回*/
- (void)requestForWeiboAPIByType:(WeiboSDKHttpRequestDemoType)_wbRequestType
{
    self.wbtoken = [commond getFromKeyChain:KEYCHAIN_KEY_ACCESSTOKEN_WEIBO];
    self.wbRefreshToken = [commond getFromKeyChain:KEYCHAIN_KEY_REFRESHTOKEN_WEIBO];
    self.wbCurrentUserID = [commond getFromKeyChain:KEYCHAIN_KEY_USERID_WEIBO];//检查本地是否已经保存过账号信息，从而可以判断是否从未登录过
    if(!self.wbtoken||!self.wbRefreshToken||!self.wbCurrentUserID)
    {
        [self doLogin:_wbRequestType];
        return;
    }//如果没有登录过，先登录
    
    
    
    [WBHttpRequest requestForRenewAccessTokenWithRefreshToken:self.wbRefreshToken queue:nil withCompletionHandler:^(WBHttpRequest *httpRequest, id result, NSError *error) {
        if(error)
        {
            [self doLogin:_wbRequestType];
            return;
        }//刷新token失败，需要重新登录
        else
        {
            self.wbtoken = [result objectForKey:@"access_token"];
            self.wbRefreshToken = [result objectForKey:@"refresh_token"];
            self.wbCurrentUserID = [result objectForKey:@"uid"];
            
            [commond saveToKeyChain:KEYCHAIN_KEY_ACCESSTOKEN_WEIBO passwd:self.wbtoken];
            [commond saveToKeyChain:KEYCHAIN_KEY_REFRESHTOKEN_WEIBO passwd:self.wbRefreshToken];
            [commond saveToKeyChain:KEYCHAIN_KEY_USERID_WEIBO passwd:self.wbCurrentUserID];//刷新本地账户信息
            
            switch (_wbRequestType) {
                case WeiboSDKHttpRequestDemoTypeRequestForUserProfile:
                    [self requestForUserProfile:self.wbCurrentUserID];
                    break;
                    
                default:
                    break;
            }
        }//刷新成功后，执行相应的操作
    }];
}

/*添加文字到message中*/
- (WBMessageObject *)appendText:(NSString *)_str_text toMessage:(WBMessageObject *)_message
{
    _message.text = NSLocalizedString(@"测试通过WeiboSDK发送文字到微博!", nil);
    return _message;
}

/*添加图片到message中*/
- (WBMessageObject *)appendImageFilePath:(NSString *)_str_imgFilePath toMessage:(WBMessageObject *)_message
{
    
    WBImageObject *image = [WBImageObject object];
    image.imageData = [NSData dataWithContentsOfFile:_str_imgFilePath];
    _message.imageObject = image;
    return _message;
    
}

/*添加链接到message中*/
- (WBMessageObject *)appendMultiMediaObjectID:(NSString *)_str_objectid title:(NSString *)_str_title desc:(NSString *)_desc thumbnailFilePath:(NSString *)_str_thumbnailPath webpageUrl:(NSString *)_str_webPageUrl toMessage:(WBMessageObject *)_message
{
    WBWebpageObject *webpage = [WBWebpageObject object];
    webpage.objectID = _str_objectid;
    webpage.title = _str_title;
    webpage.description = _desc;
    webpage.thumbnailData = [NSData dataWithContentsOfFile:_str_thumbnailPath];
    webpage.webpageUrl = _str_webPageUrl;
    _message.mediaObject = webpage;
    return _message;
}

#pragma mark - WeiboSDKDelegate 分享和用户验证回调结束后的回调
- (void)didReceiveWeiboResponse:(WBBaseResponse *)_response
{
    if ([_response isKindOfClass:WBSendMessageToWeiboResponse.class])
    {
        WBSendMessageToWeiboResponse *response = (WBSendMessageToWeiboResponse *)_response;
        NSString* accessToken = [response.authResponse accessToken];
        if (accessToken)
        {
            wbtoken = accessToken;
            [commond saveToKeyChain:KEYCHAIN_KEY_ACCESSTOKEN_WEIBO passwd:wbtoken];
        }
        NSString* uid = [response.authResponse userID];
        if (uid) {
            wbCurrentUserID = uid;
            [commond saveToKeyChain:KEYCHAIN_KEY_USERID_WEIBO passwd:wbCurrentUserID];
        }
        NSString *refreshToken = [response.authResponse refreshToken];
        if(refreshToken)
        {
            wbRefreshToken = refreshToken;
            [commond saveToKeyChain:KEYCHAIN_KEY_REFRESHTOKEN_WEIBO passwd:wbRefreshToken];
        }
        [self requestHanlder:nil result:response.userInfo error:nil];
    }
    else if ([_response isKindOfClass:WBAuthorizeResponse.class])
    {
        WBAuthorizeResponse *response = (WBAuthorizeResponse *)_response;
        if(response.userInfo && [response.userInfo count]>0)
        {
            wbtoken = [response.userInfo objectForKey:@"access_token"];
            wbRefreshToken = [response.userInfo objectForKey:@"refresh_token"];
            wbCurrentUserID = [response.userInfo objectForKey:@"uid"];
            
            [commond saveToKeyChain:KEYCHAIN_KEY_ACCESSTOKEN_WEIBO passwd:wbtoken];
            [commond saveToKeyChain:KEYCHAIN_KEY_REFRESHTOKEN_WEIBO passwd:wbRefreshToken];
            [commond saveToKeyChain:KEYCHAIN_KEY_USERID_WEIBO passwd:wbCurrentUserID];//保存账户信息
            
            if(response.requestUserInfo && [response.requestUserInfo count]>0 && [[response.requestUserInfo allKeys] containsObject:KEY_LOGINTYPE])
            {
                WeiboSDKHttpRequestDemoType _wbReqeustType = [[response.requestUserInfo objectForKey:KEY_LOGINTYPE] integerValue];
                [self requestForWeiboAPIByType:_wbReqeustType];
            }//登录成功后 ，根据登录类型执行相应的操作
            
        }
        
    }
}

-(void)didReceiveWeiboRequest:(WBBaseRequest *)request
{
    
}

#pragma mark - WBHttpRequestDelegate 这里处理logout回调

- (void)request:(WBHttpRequest *)request didFinishLoadingWithResult:(NSString *)result
{
    NSLog(@":::>%s %d request = %@ result = %@",__FUNCTION__,__LINE__,request,result);
}

- (void)request:(WBHttpRequest *)request didFailWithError:(NSError *)error;
{
    NSLog(@":::>%s %d request = %@ error = %@",__FUNCTION__,__LINE__,request,error);
}
@end
