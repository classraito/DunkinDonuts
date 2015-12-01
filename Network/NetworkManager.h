//
//  NetworkManager.h
//  MyStock
//
//  Created by Ryan Gong on 15/9/10.
//  Copyright (c) 2015年 Ryan Gong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "ASIHTTPRequest.h"
#import "ASIFormDataRequest.h"
#define HOSTNAME @"http://brand.fugumobile.cn"
//API URL
#define URL_Login @"/durnkim/api/Account/Login.ashx"
#define URL_GetMobileCode @"/durnkim/api/Account/GetMobileCode.ashx"
#define URL_GetMobileCodeAgain @"/durnkim/api/Account/GetMobileCodeAgain.ashx"
#define URL_SendRegMobileCode @"/durnkim/api/Account/SendRegMobileCode.ashx"
#define URL_SetUserInfo @"/durnkim/api/Account/SetUserInfo.ashx"
#define URL_GetUserInfo @"/durnkim/api/Account/GetUserInfo.ashx"
#define URL_GetHomeItem @"/durnkim/api/Business/GetHomeItem.ashx"
#define URL_GetPerks @"/durnkim/api/Business/GetPerks.ashx"
#define URL_GetPerkInfo @"/durnkim/api/Business/GetPerkInfo.ashx"
#define URL_GetCouponImg @"/durnkim/api/Business/GetCouponImg.ashx"
#define URL_GetStores @"/durnkim/api/Business/GetStores.ashx"
#define URL_GetStoresKeyword @"/durnkim/api/Business/GetStoresKeyWord.ashx"
#define URL_GetNews @"/durnkim/api/Business/GetNews.ashx"
#define URL_SubmitLove @"/durnkim/api/Business/SetLove.ashx"
#define URL_SubmitFavorite @"/durnkim/api/Business/SetFavorite.ashx"
#define URL_GetNewsInfo @"/durnkim/api/Business/GetNewsInfo.ashx"
#define URL_GetCouponStatus @"/durnkim/api/Business/GetCouPonStatus.ashx"


#define HOST(_str_url) [NSString stringWithFormat:@"%@%@",HOSTNAME,_str_url]
#define projectversion [[[NSBundle mainBundle] infoDictionary] objectForKey:(NSString *)kCFBundleVersionKey]

#define DEFAULTPASSWD_WechatAndWeibo @"552015111917074829254a240fe2d4de4a2d8f1d73294f11de71"
#define DEFAULTPASSWD_MaybeLater @"552015111fj39j3l24a240fe2d4de4a2d8f1d73294f11de71"
typedef enum{
    LoginChannel_mobile = 0,
    LoginChannel_maybeLater = 1,
    LoginChannel_wechat = 2,
    LoginChannel_weibo = 3
}LoginChannel;

typedef enum{
    GetPerkType_VIEWALL = 1,
    GetPerkType_MEMBERS = 2,
    GetPerkType_FAVORITE = 3
}GetPerkType;

typedef enum{
    GetNewsType_All = 1,
    GetNewsType_Unread = 2
}GetNewsType;

typedef enum{
    LoveFavoriteType_Coupon = 1,
    LoveFavoriteType_News = 2
}LoveFavoriteType;

typedef enum{
    CouponType_Member = 1,
    CouponType_Free = 2
}CouponType;

@interface NetworkManager : NSObject<ASIHTTPRequestDelegate>
{

}
+(NetworkManager *)sharedManager;//manager 单例初始化
/*通用请求方法*/
-(ASIFormDataRequest *)requestUrl:(NSString *)_str_url
                           params:(NSDictionary *)_dic_params
                          headers:(NSDictionary *)_dic_headers;
-(void)postRequest_getMobileCodeByMobile:(NSString *)_str_mobileNum passwd:(NSString *)_str_passwd userinfo:(NSMutableDictionary *)_dic_userinfo;
-(void)postRequest_sendRegMobileCode:(NSString *)_str_verifyCode userinfo:(NSMutableDictionary *)_dic_userinfo;
-(void)postRequest_setUserInfo:(NSString *)_str_username gender:(NSString *)_gender birthday:(NSString *)_str_birthday mobile:(NSString *)_str_mobile email:(NSString *)_str_email usericon:(NSString *)_str_usericon userinfo:(NSMutableDictionary *)_dic_userinfo;
-(void)postRequest_login:(NSString *)_str_loginID passwd:(NSString *)_str_passwd loginChannel:(LoginChannel)_loginChannel authCode:(NSString *)_str_authCode;
-(void)postRequest_login:(NSString *)_str_loginID passwd:(NSString *)_str_passwd loginChannel:(LoginChannel)_loginChannel authCode:(NSString *)_str_authCode userinfo:(NSMutableDictionary *)_dic_userinfo;
-(void)postRequest_getHomeItemByByCity:(NSString *)_str_city userinfo:(NSMutableDictionary *)_dic_userinfo;
-(void)postRequest_getPerksBySearchType:(GetPerkType)_getPerkType userinfo:(NSMutableDictionary *)_dic_userinfo;
-(void)postrequest_getPerksInfoByPerkId:(NSString *)_str_perkId userinfo:(NSMutableDictionary *)_dic_userinfo;
-(void)postRequest_getCouponImgByPerkId:(NSString *)_str_perkId userinfo:(NSMutableDictionary *)_dic_userinfo;
-(void)postRequest_getSotresBySearchWord:(NSString *)_str_searchWord userinfo:(NSMutableDictionary *)_dic_userinfo;
-(void)postRequest_getSotresByStoreId:(int)_storeId userinfo:(NSMutableDictionary *)_dic_userinfo;
-(void)postRequest_getStoresKeyword:(NSString *)_str_keyWord userinfo:(NSMutableDictionary *)_dic_userinfo;
-(void)postRequest_getNews:(GetNewsType)_getNewsType userinfo:(NSMutableDictionary *)_dic_userinfo;
-(void)postRequest_getNewsInfo:(int)_newsId userinfo:(NSMutableDictionary *)_dic_userinfo;
-(void)postRequest_submitLove:(LoveFavoriteType)_loveFavoriteType loveId:(NSString *)_str_loveid loveflag:(BOOL)_isLove userinfo:(NSMutableDictionary *)_dic_userinfo;
-(void)postRequest_SubmitFavorite:(LoveFavoriteType)_loveFavoriteType favoriteId:(NSString *)_str_favoriteId favoriteFlag:(BOOL)_isFavorite userinfo:(NSMutableDictionary *)_dic_userinfo;
@end









