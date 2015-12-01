//
//  NetworkManager.m
//  MyStock
//
//  Created by Ryan Gong on 15/9/10.
//  Copyright (c) 2015年 Ryan Gong. All rights reserved.
//


#import "NetworkManager.h"
#import "Global.h"

static NetworkManager *manager;


@implementation NetworkManager
+(id)alloc
{
    @synchronized(self)     {
        NSAssert(manager == nil, @"企圖創建一個singleton模式下的NetworkManager");
        return [super alloc];
    }
    return nil;
}

+(NetworkManager *)sharedManager//用这个方法来初始化NetworkManager
{
    @synchronized(self)     {
        if(!manager)
        {
            manager=[[NetworkManager alloc]init];
            return manager;
        }
    }
    return manager;
}

#pragma mark - request
#pragma mark - 注册填写用户名密码
-(void)postRequest_getMobileCodeByMobile:(NSString *)_str_mobileNum passwd:(NSString *)_str_passwd userinfo:(NSMutableDictionary *)_dic_userinfo
{
    NSMutableDictionary *dic_params = [NSMutableDictionary dictionary];
    [dic_params setObject:[[UIDevice currentDevice] uniqueDeviceIdentifier] forKey:@"DeviceToken"];
    [dic_params setObject:[NSNumber numberWithInt:2] forKey:@"DeviceTypeId"];//填写设备类型1-android 2-ios
    [dic_params setObject:projectversion forKey:@"Version"];//填写当前工程版本号
    [dic_params setObject:_str_mobileNum forKey:@"MobileNum"];
    [dic_params setObject:[NSString md5:_str_passwd] forKey:@"Password"];
    [self requestUrl:HOST(URL_GetMobileCode) params:dic_params headers:nil userinfo:_dic_userinfo];
}

#pragma mark - 刷新AccessToken
-(void)postRequest_refreshToken
{
    
}

#pragma mark - 登录
/*再包一层*/
-(void)postRequest_login:(NSString *)_str_loginID passwd:(NSString *)_str_passwd loginChannel:(LoginChannel)_loginChannel authCode:(NSString *)_str_authCode
{
    [self postRequest_login:_str_loginID passwd:_str_passwd loginChannel:_loginChannel authCode:_str_authCode userinfo:nil];
}

-(void)postRequest_login:(NSString *)_str_loginID passwd:(NSString *)_str_passwd loginChannel:(LoginChannel)_loginChannel authCode:(NSString *)_str_authCode userinfo:(NSMutableDictionary *)_dic_userinfo
{
    NSString *_str_url = HOST(URL_Login);
    NSString *_passwd = nil;
    if([DEFAULTPASSWD_MaybeLater isEqualToString:_str_passwd])
        _passwd = _str_passwd;
    else if([DEFAULTPASSWD_WechatAndWeibo isEqualToString:_str_passwd])
        _passwd = _str_passwd;
    else
        _passwd = [NSString md5:_str_passwd];
    NSMutableDictionary *dic_params = [NSMutableDictionary dictionary];
    [dic_params setObject:[[UIDevice currentDevice] uniqueDeviceIdentifier] forKey:@"DeviceToken"];
    [dic_params setObject:[NSNumber numberWithInt:2] forKey:@"DeviceTypeId"];//填写设备类型1-android 2-ios
    [dic_params setObject:projectversion forKey:@"Version"];//填写当前工程版本号
    [dic_params setObject:_passwd forKey:@"Password"];
    [dic_params setObject:_str_authCode forKey:@"AuthCode"];
    [dic_params setObject:[NSNumber numberWithInt:_loginChannel] forKey:@"Channel"];
    [dic_params setObject:_str_loginID forKey:@"LoginId"];
        [self requestUrl:_str_url params:dic_params headers:nil userinfo:_dic_userinfo];
}

#pragma mark - 再次获取手机验证码
-(void)postrequest_getMobileCodeAgain
{
    
}

#pragma mark - 提交手机验证码
-(void)postRequest_sendRegMobileCode:(NSString *)_str_verifyCode userinfo:(NSMutableDictionary *)_dic_userinfo
{
    NSString *_str_url = HOST(URL_SendRegMobileCode);
    NSMutableDictionary *_dic = [[DataManager sharedManager] getDataByUrl:HOST(URL_GetMobileCode)];
    NSString *_str_uuid =[_dic objectForKey:@"UUID"];
    
    NSMutableDictionary *_dic_params = [NSMutableDictionary dictionary];
    [_dic_params setObject:_str_uuid forKey:@"UUID"];
    [_dic_params setObject:_str_verifyCode forKey:@"VerifyCode"];
    
    [self requestUrl:_str_url params:_dic_params headers:nil userinfo:_dic_userinfo];
}

#pragma mark - 提交用户信息
-(void)postRequest_setUserInfo:(NSString *)_str_username gender:(NSString *)_str_gender birthday:(NSString *)_str_birthday mobile:(NSString *)_str_mobile email:(NSString *)_str_email usericon:(NSString *)_str_usericon userinfo:(NSMutableDictionary *)_dic_userinfo
{
    NSString *_str_url = HOST(URL_SetUserInfo);
    NSString *str_accessToken = [commond getFromKeyChain:KEY_ACCESSTOKEN];
    
    NSString *_str_alias = [commond getFromKeyChain:KEY_ALIAS];

    NSString *_str_userid = [commond getFromKeyChain:KEY_USERID];
    int userid = [_str_userid intValue];
    int gender = 3;
    if([multiLanguage(@"男") isEqualToString:_str_gender])
        gender = 0;
    else if([multiLanguage(@"女") isEqualToString:_str_gender])
        gender = 1;
    
    NSMutableArray *_arr_action = [NSMutableArray array];
    [_arr_action addObject:@{@"ActionType":@"UserName",@"Value":_str_username}];
    [_arr_action addObject:@{@"ActionType":@"Gender",@"Value":[NSNumber numberWithInt:gender]}];
    [_arr_action addObject:@{@"ActionType":@"Birthday",@"Value":_str_birthday}];
    [_arr_action addObject:@{@"ActionType":@"Mobile",@"Value":_str_mobile}];
    [_arr_action addObject:@{@"ActionType":@"Email",@"Value":_str_email}];
    
    NSMutableDictionary *_dic_params = [NSMutableDictionary dictionary];
    [_dic_params setObjectSafty:[NSNumber numberWithInt:userid] forKey:@"UserId"];
    [_dic_params setObjectSafty:_str_alias forKey:@"Alias"];
    [_dic_params setObjectSafty:_arr_action forKey:@"Action"];
    [_dic_params setObjectSafty:@"" forKey:@"headerfile"];
    
    NSMutableDictionary *_dic_headers = [NSMutableDictionary dictionary];
    [_dic_headers setObject:str_accessToken forKey:@"AccessToken"];
    [self requestUrl:_str_url params:_dic_params headers:_dic_headers userinfo:_dic_userinfo];
}

#pragma mark - 获得用户信息
-(void)postRequest_getUserInfo
{
    
}

#pragma mark - 获得首页信息
-(void)postRequest_getHomeItemByByCity:(NSString *)_str_city userinfo:(NSMutableDictionary *)_dic_userinfo
{
    if(!_str_city)
        _str_city  = @" ";
    FGLocationManagerWrapper *locationManager = [FGLocationManagerWrapper sharedManager];
    BOOL isLocationUpdated = [locationManager startUpdatingLocation:^(CLLocationDegrees lat, CLLocationDegrees lng) {
        long latitude = [commond EnCodeCoordinate:lat];
        long lngtitude = [commond EnCodeCoordinate:lng];
        
        NSString *_str_url = HOST(URL_GetHomeItem);
        NSString *str_accessToken = [commond getFromKeyChain:KEY_ACCESSTOKEN];
        NSString *_str_alias = [commond getFromKeyChain:KEY_ALIAS];
        NSString *_str_userid = [commond getFromKeyChain:KEY_USERID];
        NSNumber *num_lat = [NSNumber numberWithLong:latitude];
        NSNumber *num_lng = [NSNumber numberWithLong:lngtitude];
        NSNumber *num_userid = [NSNumber numberWithInt:[_str_userid intValue]];
        
        NSMutableDictionary *_dic_params = [NSMutableDictionary dictionary];
        [_dic_params setObject:num_userid forKey:@"UserId"];
        [_dic_params setObject:num_lng forKey:@"Lng"];//维度
        [_dic_params setObject:num_lat forKey:@"Lat"];//经度
        [_dic_params setObject:_str_alias forKey:@"Alias"];
        [_dic_params setObject:_str_city forKey:@"City"];
        
        NSMutableDictionary *_dic_headers = [NSMutableDictionary dictionary];
        [_dic_headers setObject:str_accessToken forKey:@"AccessToken"];
        [self requestUrl:_str_url params:_dic_params headers:_dic_headers userinfo:_dic_userinfo];
    }];
    NSLog(@"isLocationUpdated = %d",isLocationUpdated);
}

#pragma mark - 获得优惠券列表 (DDPerks)
-(void)postRequest_getPerksBySearchType:(GetPerkType)_getPerkType userinfo:(NSMutableDictionary *)_dic_userinfo
{
    NSString *_str_url = HOST(URL_GetPerks);
    NSString *_str_userid = [commond getFromKeyChain:KEY_USERID];
    
    NSString *str_accessToken = [commond getFromKeyChain:KEY_ACCESSTOKEN];
    NSNumber *num_userid = [NSNumber numberWithInt:[_str_userid intValue]];
    NSNumber *num_searchKey = [NSNumber numberWithInt:_getPerkType];
    NSNumber *num_page = [NSNumber numberWithInt:1];
    NSNumber *num_pagesize = [NSNumber numberWithInt:0];
    NSString *_str_alias = [commond getFromKeyChain:KEY_ALIAS];
    
    NSMutableDictionary *_dic_params = [NSMutableDictionary dictionary];
    [_dic_params setObject:num_userid forKey:@"UserId"];
    [_dic_params setObject:num_searchKey forKey:@"SearchKey"];//过滤条件
    [_dic_params setObject:num_page forKey:@"Page"];//页数 默认 1
    [_dic_params setObject:num_pagesize forKey:@"PageSize"];//每页多少条数据，默认0，条数有服务器设置返回
    [_dic_params setObject:_str_alias forKey:@"Alias"];
    
    NSMutableDictionary *_dic_headers = [NSMutableDictionary dictionary];
    [_dic_headers setObject:str_accessToken forKey:@"AccessToken"];
    
    [self requestUrl:_str_url params:_dic_params headers:_dic_headers userinfo:_dic_userinfo];
    
}

#pragma mark - 获得优惠券详情
-(void)postrequest_getPerksInfoByPerkId:(NSString *)_str_perkId userinfo:(NSMutableDictionary *)_dic_userinfo
{
    if(!_str_perkId)
        return;
    
    NSString *_str_url = HOST(URL_GetPerkInfo);
    NSString *_str_userid = [commond getFromKeyChain:KEY_USERID];
    
    NSString *str_accessToken = [commond getFromKeyChain:KEY_ACCESSTOKEN];
    NSNumber *num_userid = [NSNumber numberWithInt:[_str_userid intValue]];
    NSString *_str_alias = [commond getFromKeyChain:KEY_ALIAS];
    
    NSMutableDictionary *_dic_params = [NSMutableDictionary dictionary];
    [_dic_params setObject:num_userid forKey:@"UserId"];
    [_dic_params setObject:_str_alias forKey:@"Alias"];
    [_dic_params setObject:_str_perkId forKey:@"PerkId"];//优惠券ID eg:joefweflenfldsfsdfd3
    
    NSMutableDictionary *_dic_headers = [NSMutableDictionary dictionary];
    [_dic_headers setObject:str_accessToken forKey:@"AccessToken"];
    
    [self requestUrl:_str_url params:_dic_params headers:_dic_headers userinfo:_dic_userinfo];

}

#pragma mark - 获取二维码图片
-(void)postRequest_getCouponImgByPerkId:(NSString *)_str_perkId userinfo:(NSMutableDictionary *)_dic_userinfo
{
    if(!_str_perkId)
        return;
    
    NSString *_str_url = HOST(URL_GetCouponImg);
    NSString *_str_userid = [commond getFromKeyChain:KEY_USERID];
    
    NSString *str_accessToken = [commond getFromKeyChain:KEY_ACCESSTOKEN];
    NSNumber *num_userid = [NSNumber numberWithInt:[_str_userid intValue]];
    NSString *_str_alias = [commond getFromKeyChain:KEY_ALIAS];
    
    NSMutableDictionary *_dic_params = [NSMutableDictionary dictionary];
    [_dic_params setObject:num_userid forKey:@"UserId"];
    [_dic_params setObject:_str_alias forKey:@"Alias"];
    [_dic_params setObject:_str_perkId forKey:@"PerkId"];//优惠券ID eg:joefweflenfldsfsdfd3
    
    NSMutableDictionary *_dic_headers = [NSMutableDictionary dictionary];
    [_dic_headers setObject:str_accessToken forKey:@"AccessToken"];
    
    [self requestUrl:_str_url params:_dic_params headers:_dic_headers userinfo:_dic_userinfo];
}

#pragma mark - 获取店铺列表 搜索店铺列表
-(void)postRequest_getSotresBySearchWord:(NSString *)_str_searchWord userinfo:(NSMutableDictionary *)_dic_userinfo
{
    [self postRequest_getSotresBySearchWord:_str_searchWord storeId:0 userinfo:_dic_userinfo];
}

-(void)postRequest_getSotresByStoreId:(int)_storeId userinfo:(NSMutableDictionary *)_dic_userinfo
{
    [self postRequest_getSotresBySearchWord:@"" storeId:_storeId userinfo:_dic_userinfo];
}

-(void)postRequest_getSotresBySearchWord:(NSString *)_str_searchWord storeId:(int)_storeId userinfo:(NSMutableDictionary *)_dic_userinfo
{
    if(!_str_searchWord)
        _str_searchWord = @" ";
    
    FGLocationManagerWrapper *locationManager = [FGLocationManagerWrapper sharedManager];
    BOOL isLocationUpdated = [locationManager startUpdatingLocation:^(CLLocationDegrees lat, CLLocationDegrees lng) {
        long latitude = [commond EnCodeCoordinate:lat];
        long lngtitude = [commond EnCodeCoordinate:lng];
        
        NSString *_str_url = HOST(URL_GetStores);
        NSString *_str_userid = [commond getFromKeyChain:KEY_USERID];
        
        NSString *str_accessToken = [commond getFromKeyChain:KEY_ACCESSTOKEN];
        NSNumber *num_userid = [NSNumber numberWithInt:[_str_userid intValue]];
        NSString *_str_alias = [commond getFromKeyChain:KEY_ALIAS];
        NSNumber *num_page = [NSNumber numberWithInt:1];
        NSNumber *num_pagesize = [NSNumber numberWithInt:0];
        NSNumber *num_lat = [NSNumber numberWithLong:latitude];
        NSNumber *num_lng = [NSNumber numberWithLong:lngtitude];
        
        NSMutableDictionary *_dic_params = [NSMutableDictionary dictionary];
        [_dic_params setObject:num_userid forKey:@"UserId"];
        [_dic_params setObject:_str_alias forKey:@"Alias"];
        [_dic_params setObject:_str_searchWord forKey:@"SearchWord"];//搜索关键字
        [_dic_params setObject:[NSNumber numberWithInt:_storeId] forKey:@"SotreId"];//默认0，如果大于0，会忽略SearchWord
        [_dic_params setObject:num_page forKey:@"Page"];//页数 默认 1
        [_dic_params setObject:num_pagesize forKey:@"PageSize"];//每页多少条数据，默认0，条数有服务器设置返回
        [_dic_params setObject:num_lng forKey:@"Lng"];//维度
        [_dic_params setObject:num_lat forKey:@"Lat"];//经度
        [_dic_params setObject:@" " forKey:@"City"];
        NSMutableDictionary *_dic_headers = [NSMutableDictionary dictionary];
        [_dic_headers setObject:str_accessToken forKey:@"AccessToken"];
        
        [self requestUrl:_str_url params:_dic_params headers:_dic_headers userinfo:_dic_userinfo];
    }];
    NSLog(@"isLocationUpdated = %d",isLocationUpdated);
}

#pragma mark - 店铺列表关键字搜索
-(void)postRequest_getStoresKeyword:(NSString *)_str_keyWord userinfo:(NSMutableDictionary *)_dic_userinfo
{
    if(!_str_keyWord)
        _str_keyWord = @" ";
    
    FGLocationManagerWrapper *locationManager = [FGLocationManagerWrapper sharedManager];
    BOOL isLocationUpdated = [locationManager startUpdatingLocation:^(CLLocationDegrees lat, CLLocationDegrees lng) {
        long latitude = [commond EnCodeCoordinate:lat];
        long lngtitude = [commond EnCodeCoordinate:lng];
        
        NSString *_str_url = HOST(URL_GetStoresKeyword);
        NSString *_str_userid = [commond getFromKeyChain:KEY_USERID];
        
        NSString *str_accessToken = [commond getFromKeyChain:KEY_ACCESSTOKEN];
        NSNumber *num_userid = [NSNumber numberWithInt:[_str_userid intValue]];
        NSString *_str_alias = [commond getFromKeyChain:KEY_ALIAS];
        NSNumber *num_lat = [NSNumber numberWithLong:latitude];
        NSNumber *num_lng = [NSNumber numberWithLong:lngtitude];
        
        NSMutableDictionary *_dic_params = [NSMutableDictionary dictionary];
        [_dic_params setObject:num_userid forKey:@"UserId"];
        [_dic_params setObject:_str_alias forKey:@"Alias"];
        [_dic_params setObject:_str_keyWord forKey:@"KeyWord"];//搜索关键字
        [_dic_params setObject:num_lng forKey:@"Lng"];//维度
        [_dic_params setObject:num_lat forKey:@"Lat"];//经度
        [_dic_params setObject:@" " forKey:@"City"];
        NSMutableDictionary *_dic_headers = [NSMutableDictionary dictionary];
        [_dic_headers setObject:str_accessToken forKey:@"AccessToken"];
        
        [self requestUrl:_str_url params:_dic_params headers:_dic_headers userinfo:_dic_userinfo];
    }];
    NSLog(@"isLocationUpdated = %d",isLocationUpdated);
}

#pragma mark - 获取新闻
-(void)postRequest_getNews:(GetNewsType)_getNewsType userinfo:(NSMutableDictionary *)_dic_userinfo
{
    NSString *_str_url = HOST(URL_GetNews);
    NSString *_str_userid = [commond getFromKeyChain:KEY_USERID];
    
    NSString *str_accessToken = [commond getFromKeyChain:KEY_ACCESSTOKEN];
    NSNumber *num_userid = [NSNumber numberWithInt:[_str_userid intValue]];
    NSString *_str_alias = [commond getFromKeyChain:KEY_ALIAS];
    NSNumber *num_page = [NSNumber numberWithInt:1];
    NSNumber *num_pagesize = [NSNumber numberWithInt:0];
    
    NSMutableDictionary *_dic_params = [NSMutableDictionary dictionary];
    [_dic_params setObject:num_userid forKey:@"UserId"];
    [_dic_params setObject:_str_alias forKey:@"Alias"];
    [_dic_params setObject:num_page forKey:@"Page"];//页数 默认 1
    [_dic_params setObject:num_pagesize forKey:@"PageSize"];//每页多少条数据，默认0，条数有服务器设置返回
    [_dic_params setObject:[NSNumber numberWithInt:_getNewsType] forKey:@"Type"];
    NSMutableDictionary *_dic_headers = [NSMutableDictionary dictionary];
    [_dic_headers setObject:str_accessToken forKey:@"AccessToken"];
    
    [self requestUrl:_str_url params:_dic_params headers:_dic_headers userinfo:_dic_userinfo];
}

#pragma mark - 获取新闻详情
-(void)postRequest_getNewsInfo:(int)_newsId userinfo:(NSMutableDictionary *)_dic_userinfo
{
    NSString *_str_url = HOST(URL_GetNewsInfo);
    NSString *_str_userid = [commond getFromKeyChain:KEY_USERID];
    
    NSString *str_accessToken = [commond getFromKeyChain:KEY_ACCESSTOKEN];
    NSNumber *num_userid = [NSNumber numberWithInt:[_str_userid intValue]];
    NSString *_str_alias = [commond getFromKeyChain:KEY_ALIAS];
    
    NSMutableDictionary *_dic_params = [NSMutableDictionary dictionary];
    [_dic_params setObject:num_userid forKey:@"UserId"];
    [_dic_params setObject:_str_alias forKey:@"Alias"];
    [_dic_params setObject:[NSNumber numberWithInt:_newsId] forKey:@"NewsId"];
    NSMutableDictionary *_dic_headers = [NSMutableDictionary dictionary];
    [_dic_headers setObject:str_accessToken forKey:@"AccessToken"];
    
    [self requestUrl:_str_url params:_dic_params headers:_dic_headers userinfo:_dic_userinfo];

}

#pragma mark - 点赞
-(void)postRequest_submitLove:(LoveFavoriteType)_loveFavoriteType loveId:(NSString *)_str_loveid loveflag:(BOOL)_isLove userinfo:(NSMutableDictionary *)_dic_userinfo
{
    NSString *_str_url = HOST(URL_SubmitLove);
    NSString *_str_userid = [commond getFromKeyChain:KEY_USERID];
    
    NSString *str_accessToken = [commond getFromKeyChain:KEY_ACCESSTOKEN];
    NSNumber *num_userid = [NSNumber numberWithInt:[_str_userid intValue]];
    NSString *_str_alias = [commond getFromKeyChain:KEY_ALIAS];
    
    NSMutableDictionary *_dic_params = [NSMutableDictionary dictionary];
    [_dic_params setObject:num_userid forKey:@"UserId"];
    [_dic_params setObject:_str_alias forKey:@"Alias"];
    [_dic_params setObject:_str_loveid forKey:@"LoveId"];
    [_dic_params setObject:[NSNumber numberWithInt:_loveFavoriteType] forKey:@"Type"];
    [_dic_params setObject:[NSNumber numberWithBool:_isLove] forKey:@"LoveFlag"];
    NSMutableDictionary *_dic_headers = [NSMutableDictionary dictionary];
    [_dic_headers setObject:str_accessToken forKey:@"AccessToken"];
    
    [self requestUrl:_str_url params:_dic_params headers:_dic_headers userinfo:_dic_userinfo];

}

#pragma mark - 收藏
-(void)postRequest_SubmitFavorite:(LoveFavoriteType)_loveFavoriteType favoriteId:(NSString *)_str_favoriteId favoriteFlag:(BOOL)_isFavorite userinfo:(NSMutableDictionary *)_dic_userinfo
{
    NSString *_str_url = HOST(URL_SubmitFavorite);
    NSString *_str_userid = [commond getFromKeyChain:KEY_USERID];
    
    NSString *str_accessToken = [commond getFromKeyChain:KEY_ACCESSTOKEN];
    NSNumber *num_userid = [NSNumber numberWithInt:[_str_userid intValue]];
    NSString *_str_alias = [commond getFromKeyChain:KEY_ALIAS];
    
    NSMutableDictionary *_dic_params = [NSMutableDictionary dictionary];
    [_dic_params setObject:num_userid forKey:@"UserId"];
    [_dic_params setObject:_str_alias forKey:@"Alias"];
    [_dic_params setObject:_str_favoriteId forKey:@"FavoriteId"];
    [_dic_params setObject:[NSNumber numberWithInt:_loveFavoriteType] forKey:@"Type"];
    [_dic_params setObject:[NSNumber numberWithBool:_isFavorite] forKey:@"FavoriteFlag"];
    NSMutableDictionary *_dic_headers = [NSMutableDictionary dictionary];
    [_dic_headers setObject:str_accessToken forKey:@"AccessToken"];
    
    [self requestUrl:_str_url params:_dic_params headers:_dic_headers userinfo:_dic_userinfo];
}



#pragma mark - response
-(void)saveImportInfoToKeyChain:(NSMutableDictionary *)_dic_result
{
    
    NSString *_str_accessToken = [_dic_result objectForKey:@"AccessToken"];
    NSString *_str_alias = [_dic_result objectForKey:@"Alias"];
    int userid = [[_dic_result objectForKey:@"UserId"] intValue];
    NSString *_str_userid = [NSString stringWithFormat:@"%d",userid];
    [commond saveToKeyChain:KEY_ACCESSTOKEN passwd:_str_accessToken];
    [commond saveToKeyChain:KEY_ALIAS passwd:_str_alias];
    [commond saveToKeyChain:KEY_USERID passwd:_str_userid];
}

#pragma mark -
/*ASIHttpRequestDelegate 处理回调*/
-(void)requestFinished:(ASIHTTPRequest *)request
{
    NSString *str_response = request.responseString;
    int responseCode = request.responseStatusCode;
    
    if(responseCode != 200)
    {
        return;//第一级检查返回码
    }
    NSString *_str_requestUrl = request.url.absoluteString;
    NSMutableDictionary *_dic_json = [str_response mutableObjectFromJSONString];
     NSLog(@":::::>response %@ %@ ",_str_requestUrl,_dic_json);
    if(!_dic_json )
        return;
   
    if(![self isReturnCodePass:_dic_json])
    {
        NSDictionary *_dic_failedInfo = @{@"result":_dic_json,@"url":_str_requestUrl};
        [[NSNotificationCenter defaultCenter] postNotificationName:Notification_UpdateFailed object:_dic_failedInfo];
        return;
    }
    
    
    if([HOST(URL_SendRegMobileCode) isEqualToString:_str_requestUrl])
    {
        [self saveImportInfoToKeyChain:_dic_json];
    }
    if([HOST(URL_Login) isEqualToString:_str_requestUrl])
    {
        [self saveImportInfoToKeyChain:_dic_json];
    }//保存一份到钥匙串中
    NSMutableDictionary *dic_info = nil;
    if(request.userInfo)
    {
        dic_info = [NSMutableDictionary dictionaryWithDictionary:request.userInfo];
    }
    else
    {
        dic_info =  [NSMutableDictionary dictionary];
    }
    [dic_info setObject:_str_requestUrl forKey:@"url"];
    
       [[DataManager sharedManager] saveData:_dic_json info:dic_info];
    //保存到数据内存中
    
    
}

/*处理连接错误*/
-(void)requestFailed:(ASIHTTPRequest *)request
{
    NSLog(@"XXXXXXXXXXXXXX> response error:%@ url:%@",request.error,request.url);
}

/* 子方法 */
-(void)clearAllRequeast
{
    
}

/*通用请求方法*/
-(ASIFormDataRequest *)requestUrl:(NSString *)_str_url
                           params:(NSMutableDictionary *)_dic_params
                          headers:(NSMutableDictionary *)_dic_headers
                         userinfo:(NSMutableDictionary *)_dic_userinfo;
{
    
    if(![[Reachability reachabilityForInternetConnection] isReachable])
        return nil;
    
    if(![self isParameterValid:_dic_params])
        return nil;
    
    NSURL *url = [NSURL URLWithString:[_str_url stringByReplacingPercentEscapesUsingEncoding:NSUTF8StringEncoding]];
    ASIFormDataRequest *request=[[ASIFormDataRequest alloc] initWithURL:url];
    [request setTimeOutSeconds:60];
    [request setRequestMethod:@"POST"];
    [request addRequestHeader:@"User-Agent" value:@"ASIHTTPRequest"];
    [request addRequestHeader:@"Content-Type" value:@"application/json; charset=utf-8"];
    if(_dic_userinfo)
        request.userInfo = _dic_userinfo;
//    [request setValidatesSecureCertificate:NO];
    if(_dic_headers && [_dic_headers count]>0)
    {
        for(int i=0;i<[_dic_headers count];i++)
        {
            id key = [[_dic_headers allKeys] objectAtIndex:i];
            [request addRequestHeader:key value:[_dic_headers objectForKey:key]];
        }
    }
    
    [request appendPostData:[_dic_params JSONData]];
    request.delegate = self;
    
    [request startAsynchronous];
    
    NSLog(@"::::::::::::::::::>request:[%@] %@ %@",_str_url,_dic_params,request.requestHeaders);
    return request;
    
}

-(ASIFormDataRequest *)requestUrl:(NSString *)_str_url
                           params:(NSMutableDictionary *)_dic_params
                          headers:(NSMutableDictionary *)_dic_headers;
{
    return [self requestUrl:_str_url params:_dic_params headers:_dic_headers userinfo:nil];
}

/*判断返回码*/
-(BOOL)isReturnCodePass:(NSMutableDictionary *)_dic_result
{
    
    NSNumber *_num_returncode = [_dic_result objectForKey:@"Code"];
    
    
    NSInteger _returncode = [_num_returncode integerValue];
    
    switch (_returncode) {
        case 100:
            
            return YES;//获取数据成功
            
    }
    return NO;
}


/*判断参数字典中是否有空值*/
-(BOOL)isParameterValid:(NSDictionary *)_dic_params
{
    for(NSString *str_key in [_dic_params allKeys])
    {
        NSString *str_value = [_dic_params objectForKey:str_key];
        if(!str_value)
            return NO;
    }
    return YES;
}

-(void)dealloc
{

}
@end
