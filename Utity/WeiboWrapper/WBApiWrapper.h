//
//  WBApiManager.h
//  DunkinDonuts
//
//  Created by Ryan Gong on 15/11/11.
//  Copyright © 2015年 Ryan Gong. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "WeiboSDK.h"
#define WeiboAppKey         @"1438631530"
#define kRedirectURI    @"http://"

#define KEYCHAIN_KEY_ACCESSTOKEN_WEIBO @"KEYCHAIN_KEY_ACCESSTOKEN_WEIBO"
#define KEYCHAIN_KEY_REFRESHTOKEN_WEIBO @"KEYCHAIN_KEY_REFRESHTOKEN_WEIBO"
#define KEYCHAIN_KEY_USERID_WEIBO @"KEYCHAIN_KEY_USERID_WEIBO"
#define KEYCHAIN_KEY_WEIBOUSERINFO @"KEYCHAIN_KEY_WEIBOUSERINFO"

enum
{
    WeiboSDKHttpRequestDemoTypeReturn = 0,
    WeiboSDKHttpRequestDemoTypeRequestForFriendsListOfUser,
    WeiboSDKHttpRequestDemoTypeRequestForFriendsUserIDListOfUser,
    WeiboSDKHttpRequestDemoTypeRequestForCommonFriendsListBetweenTwoUser,
    WeiboSDKHttpRequestDemoTypeRequestForBilateralFriendsListOfUser,
    WeiboSDKHttpRequestDemoTypeRequestForFollowersListOfUser,
    WeiboSDKHttpRequestDemoTypeRequestForFollowersUserIDListOfUser,
    WeiboSDKHttpRequestDemoTypeRequestForActiveFollowersListOfUser,
    WeiboSDKHttpRequestDemoTypeRequestForBilateralFollowersListOfUser,
    WeiboSDKHttpRequestDemoTypeRequestForFriendshipDetailBetweenTwoUser,
    WeiboSDKHttpRequestDemoTypeRequestForFollowAUser,
    WeiboSDKHttpRequestDemoTypeRequestForCancelFollowingAUser,
    WeiboSDKHttpRequestDemoTypeRequestForRemoveFollowerUser,
    WeiboSDKHttpRequestDemoTypeRequestForInviteBilateralFriend,
    WeiboSDKHttpRequestDemoTypeRequestForUserProfile,
    WeiboSDKHttpRequestDemoTypeRequestForStatusIDs,
    WeiboSDKHttpRequestDemoTypeRequestForRepostAStatus,
    WeiboSDKHttpRequestDemoTypeRequestForPostAStatus,
    WeiboSDKHttpRequestDemoTypeRequestForPostAStatusAndPic,
    WeiboSDKHttpRequestDemoTypeRequestForPostAStatusAndPicurl,
    WeiboSDKHttpRequestDemoTypeRequestForRenewAccessToken,
    WeiboSDKHttpRequestDemoTypeAddGameObject,
    WeiboSDKHttpRequestDemoTypeAddGameAchievementObject,
    WeiboSDKHttpRequestDemoTypeAddGameAchievementGain,
    WeiboSDKHttpRequestDemoTypeAddGameScoreGain,
    WeiboSDKHttpRequestDemoTypeRequestForGameScore,
    WeiboSDKHttpRequestDemoTypeRequestForFriendsGameScore,
    WeiboSDKHttpRequestDemoTypeRequestForGameAchievementGain,
};
typedef NSUInteger WeiboSDKHttpRequestDemoType;//这里有很多类型都没有方法实现，需要的话再加方法

@protocol WBApiWrapperDelegate <NSObject>
-(void)wbDidReceiveUserInfo:(NSMutableDictionary *)_dic_userinfo;
@end

@interface WBApiWrapper : NSObject<WeiboSDKDelegate,WBHttpRequestDelegate>
{
    
}
+(instancetype)sharedManager;
@property (strong, nonatomic) NSString *wbtoken;//token
@property (strong, nonatomic) NSString *wbRefreshToken;//refreshToken
@property (strong, nonatomic) NSString *wbCurrentUserID;//userid
@property(nonatomic,assign)id<WBApiWrapperDelegate>delegate;
- (void)login;//登录
- (void)logout;//登出
- (void)requestForWeiboAPIByType:(WeiboSDKHttpRequestDemoType)_wbRequestType;//更具类型请求api方法
- (void)shareToWeibo:(WBMessageObject*)_message;//分享message到微博
- (WBMessageObject *)appendText:(NSString *)_str_text toMessage:(WBMessageObject *)_message;//添加文本到message中
- (WBMessageObject *)appendImageFilePath:(NSString *)_str_imgFilePath toMessage:(WBMessageObject *)_message;//添加图片到message中
- (WBMessageObject *)appendMultiMediaObjectID:(NSString *)_str_objectid title:(NSString *)_str_title desc:(NSString *)_desc thumbnailFilePath:(NSString *)_str_thumbnailPath webpageUrl:(NSString *)_str_webPageUrl toMessage:(WBMessageObject *)_message;//添加链接到message中
@end
