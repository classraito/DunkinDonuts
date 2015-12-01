//
//  WBApiManager.h
//  DunkinDonuts
//
//  Created by Ryan Gong on 15/11/11.
//  Copyright © 2015年 Ryan Gong. All rights reserved.
//

#import "WXApiWrapper.h"
#import "WXApiRequestHandler.h"
#import "Global.h"
@implementation WXApiWrapper
@synthesize currentScene;
@synthesize delegate;
#pragma mark - LifeCycle
+(instancetype)sharedManager {
    static dispatch_once_t onceToken;
    static WXApiWrapper *instance;
    dispatch_once(&onceToken, ^{
        instance = [[WXApiWrapper alloc] init];
    });
    return instance;
}

- (void)dealloc {
    [super dealloc];
}




-(BOOL)preCheckWXAppInstalled
{
    BOOL retVal = [WXApi isWXAppInstalled];
    if(!retVal)
    {
        
    }//TODO: alert here
    
    return retVal;
}

#pragma mark - 微信官方封装好的请求方法
- (void)sendTextContent:(NSString *)kTextMessage {
    if(![self preCheckWXAppInstalled])
        return;
    [WXApiRequestHandler sendText:kTextMessage
                          InScene:currentScene];
}

- (void)sendImageContent:(NSString *)filePath tagName:(NSString *)kImageTagName messageExt:(NSString *)kMessageExt messageAction:(NSString *)kMessageAction thumbimage:(UIImage *)thumbImage {
    if(![self preCheckWXAppInstalled])
        return;
    NSData *imageData = [NSData dataWithContentsOfFile:filePath];
    [WXApiRequestHandler sendImageData:imageData
                               TagName:kImageTagName
                            MessageExt:kMessageExt
                                Action:kMessageAction
                            ThumbImage:thumbImage
                               InScene:currentScene];
}

- (void)sendLinkContent:(NSString *)kLinkURL tagName:(NSString *)kLinkTagName title:(NSString *)kLinkTitle thumbImage:(UIImage *)thumbImage description:(NSString *)kLinkDescription {
    if(![self preCheckWXAppInstalled])
        return;
    [WXApiRequestHandler sendLinkURL:kLinkURL
                             TagName:kLinkTagName
                               Title:kLinkTitle
                         Description:kLinkDescription
                          ThumbImage:thumbImage
                             InScene:currentScene];
}

- (void)sendMusicContent:(NSString *)kMusicURL dataURL:(NSString *)kMusicDataURL title:(NSString *)kMusicTitle description:(NSString *)kMusicDescription thumImage:(UIImage *)thumbImage {
    if(![self preCheckWXAppInstalled])
        return;
    [WXApiRequestHandler sendMusicURL:kMusicURL
                              dataURL:kMusicDataURL
                                Title:kMusicTitle
                          Description:kMusicDescription
                           ThumbImage:thumbImage
                              InScene:currentScene];
}

- (void)sendVideoContent:(NSString *)kVideoURL title:(NSString *)kVideoTitle description:(NSString *)kVideoDescription thumbImage:(UIImage *)thumbImage{
    if(![self preCheckWXAppInstalled])
        return;
    [WXApiRequestHandler sendVideoURL:kVideoURL
                                Title:kVideoTitle
                          Description:kVideoDescription
                           ThumbImage:thumbImage
                              InScene:currentScene];
}

/*调出登录界面*/
- (void)loginInViewController:(UIViewController *)_controller {
    if(![self preCheckWXAppInstalled])
        return;
    [WXApiRequestHandler sendAuthRequestScope: kAuthScope
                                        State:kAuthState
                                       OpenID:nil
                             InViewController:_controller];
}

- (void)sendFileContent:(NSString *)filePath fileExt:(NSString *)kFileExtension title:(NSString *)kFileTitle description:(NSString *)kFileDescription thumbImage:(UIImage *)thumbImage {
    if(![self preCheckWXAppInstalled])
        return;
    NSData *fileData = [NSData dataWithContentsOfFile:filePath];
    [WXApiRequestHandler sendFileData:fileData
                        fileExtension:kFileExtension
                                Title:kFileTitle
                          Description:kFileDescription
                           ThumbImage:thumbImage
                              InScene:currentScene];
}

#pragma mark - 自定义的使用NSURLConnection请求的API接口
/*刷新accessToken 因为刷新了一个没过期的token会自动延期那个token 所以checkAccessToken方法显得没有必要了*/
-(void)refreshAccessToken
{
    NSString *str_refreshToken = [commond getFromKeyChain:KEYCHAIN_KEY_REFRESHTOKEN_WECHAT];
    if(str_refreshToken)
    {
        NSString *str_url = [NSString stringWithFormat:URL_REFRESHTOKEN,WECHAT_APPID,str_refreshToken];
        [self requestUrl:str_url params:nil doAfterFinish:@selector(doGetUserInfo:) methos:@"GET"];
        //这里没有考虑refreshToken超过30天 需要重新授权的情况
    }
    else
    {
        //TODO:do exception
    }
}

/*这个方法可以方便的被外部调用 在获得用户信息之前首先刷新token*/
-(void)getUserInfo
{
    if(![self preCheckWXAppInstalled])
        return;
    [self refreshAccessToken];
}
#pragma mark - 发送异步网络请求通用方法
-(void)requestUrl:(NSString *)_str_url params:(NSMutableDictionary *)_dic_params doAfterFinish:(SEL)selector methos:(NSString *)_str_method
{
    NSError *error = nil;
   
    NSMutableURLRequest* request = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:_str_url] cachePolicy:NSURLRequestUseProtocolCachePolicy timeoutInterval:30.0];
    [request setHTTPMethod:_str_method];
    [request setValue:@"application/json" forHTTPHeaderField:@"Accept"];
    [request setValue:@"application/json" forHTTPHeaderField:@"Content-Type"];
    if(_dic_params)
    {
        NSData* jsonData = [NSJSONSerialization dataWithJSONObject:_dic_params options:NSJSONWritingPrettyPrinted error: &error];//利用系统自带 JSON 工具封装 JSON 数据
        [request setValue:[NSString stringWithFormat:@"%lu",(unsigned long)[jsonData length]] forHTTPHeaderField:@"Content-length"];
        [request setHTTPBody:jsonData];//把刚才封装的 JSON 数据塞进去
    }
    
    NSOperationQueue *queue = [[NSOperationQueue alloc]init];
    /*
     *发起异步访问网络操作 并用 block 操作回调函数
     */
    [NSURLConnection sendAsynchronousRequest:request queue:queue completionHandler:
     ^(NSURLResponse *response,
       NSData *data,
       NSError *error){
         if ([data length]>0 && error == nil) {
            __block NSMutableDictionary  *resultDic = [NSJSONSerialization JSONObjectWithData: data options: NSJSONReadingMutableContainers
                                                           error: &error];
             [self performSelector:selector withObject:resultDic];
         } else{
             NSLog(@"exception");
         }//TODO:net exception
         [queue release];
     }];
}

#pragma mark - WXApiDelegate
- (void)onResp:(BaseResp *)resp {
    if ([resp isKindOfClass:[SendMessageToWXResp class]]) {
        
        SendMessageToWXResp *messageResp = (SendMessageToWXResp *)resp;
        NSLog(@"messageResp = %@",messageResp);
    }//分享数据回调
    else if ([resp isKindOfClass:[SendAuthResp class]]) {
        SendAuthResp *authResp = (SendAuthResp *)resp;
        if(authResp.errCode==0 && !authResp.errStr)
        {
            //通过code换取accesstoken
            NSString *str_url = [NSString stringWithFormat:URL_GETACCESSTOKEN,WECHAT_APPID,WECHAT_APPSECRET,authResp.code];
            [self requestUrl:str_url params:nil doAfterFinish:@selector(didReceiveCode:) methos:@"GET"];
        }
    }//用户登录回调
}//从微信返回本应用后会调用

#pragma mark - 回调方法
/*获得code后*/
-(void)didReceiveCode:(NSMutableDictionary *)_dic_receivedData
{
    if(!_dic_receivedData)
        return;
    if([_dic_receivedData count]<=0)
        return;//安全检查 防止崩溃
    
    NSString *str_accessToken = [_dic_receivedData objectForKey:@"access_token"];
    NSString *str_openid = [_dic_receivedData objectForKey:@"openid"];
    NSString *str_refreshToken = [_dic_receivedData objectForKey:@"refresh_token"];
    NSString *str_unionid = [_dic_receivedData objectForKey:@"unionid"];
    [commond saveToKeyChain:KEYCHAIN_KEY_ACCESSTOKEN_WECHAT passwd:str_accessToken];
    [commond saveToKeyChain:KEYCHAIN_KEY_OPENID_WECHAT passwd:str_openid];
    [commond saveToKeyChain:KEYCHAIN_KEY_REFRESHTOKEN_WECHAT passwd:str_refreshToken];
    [commond saveToKeyChain:KEYCHAIN_KEY_UNIONID_WECHAT passwd:str_unionid];//将以上重要信息保存到keychain中
    [self doGetUserInfo:_dic_receivedData];
}

/*刷新accesstoken后 立即请求获得用户信息*/
-(void)doGetUserInfo:(NSMutableDictionary *)_dic_receivedData
{
    if(!_dic_receivedData)
        return;
    if([_dic_receivedData count]<=0)
        return;//安全检查 防止崩溃
    
    NSString *str_accessToken = [_dic_receivedData objectForKey:@"access_token"];
    NSString *str_openid = [_dic_receivedData objectForKey:@"openid"];
    NSString *str_refreshToken = [_dic_receivedData objectForKey:@"refresh_token"];
    [commond saveToKeyChain:KEYCHAIN_KEY_ACCESSTOKEN_WECHAT passwd:str_accessToken];
    [commond saveToKeyChain:KEYCHAIN_KEY_OPENID_WECHAT passwd:str_openid];
    [commond saveToKeyChain:KEYCHAIN_KEY_REFRESHTOKEN_WECHAT passwd:str_refreshToken];
    if(str_accessToken && str_openid)
    {
        NSString *str_url = [NSString stringWithFormat:URL_GETUSERINFO,str_accessToken,str_openid];
        [self requestUrl:str_url params:nil doAfterFinish:@selector(didReceiveUserInfo:) methos:@"GET"];
    }
}

/*获得用户信息以后*/
-(void)didReceiveUserInfo:(NSMutableDictionary *)_dic_receivedData
{
    if(!_dic_receivedData)
        return;
    if([_dic_receivedData count]<=0)
        return;//安全检查 防止崩溃
    NSString *str_openid = [_dic_receivedData objectForKey:@"openid"];
    NSString *str_unionid = [_dic_receivedData objectForKey:@"unionid"];
    [commond saveToKeyChain:KEYCHAIN_KEY_OPENID_WECHAT passwd:str_openid];
    [commond saveToKeyChain:KEYCHAIN_KEY_UNIONID_WECHAT passwd:str_unionid];
    
    NSError *error;
    NSData* jsonData = [NSJSONSerialization dataWithJSONObject:_dic_receivedData options:NSJSONWritingPrettyPrinted error: &error];//利用系统自带 JSON 工具封装 JSON 数据
    if(jsonData)
    {
        if(delegate && [delegate respondsToSelector:@selector(wxDidReceiveUserInfo:)])
        {
            [delegate wxDidReceiveUserInfo:_dic_receivedData];
        }
        
        
        NSString *str_userinfo_json = [[NSString alloc] initWithData:jsonData encoding:NSUTF8StringEncoding];
        [commond saveToKeyChain:KEYCHAIN_KEY_WECHATUSERINFO passwd:str_userinfo_json];//将微信用户信息保存到keychain中
        [str_userinfo_json release];
        str_userinfo_json = nil;
    }
}
@end
