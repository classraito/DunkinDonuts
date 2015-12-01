//
//  WBApiManager.h
//  DunkinDonuts
//
//  Created by Ryan Gong on 15/11/11.
//  Copyright © 2015年 Ryan Gong. All rights reserved.
//
#import <Foundation/Foundation.h>
#import "WXApi.h"
#define KEYCHAIN_KEY_ACCESSTOKEN_WECHAT @"KEYCHAIN_KEY_ACCESSTOKEN_WECHAT"
#define KEYCHAIN_KEY_REFRESHTOKEN_WECHAT @"KEYCHAIN_KEY_REFRESHTOKEN_WECHAT"
#define KEYCHAIN_KEY_OPENID_WECHAT @"KEYCHAIN_KEY_OPENID_WECHAT"
#define KEYCHAIN_KEY_UNIONID_WECHAT @"KEYCHAIN_KEY_UNIONID_WECHAT"
#define KEYCHAIN_KEY_WECHATUSERINFO @"KEYCHAIN_KEY_WECHATUSERINFO"

static NSString *kAuthScope = @"snsapi_message,snsapi_userinfo,snsapi_friend,snsapi_contact";
static NSString *kAuthState = @"xxx";

#define URL_GETACCESSTOKEN @"https://api.weixin.qq.com/sns/oauth2/access_token?appid=%@&secret=%@&code=%@&grant_type=authorization_code"
#define URL_CHECKTOKEN @"https://api.weixin.qq.com/sns/auth?access_token=%@&openid=%@"
#define URL_REFRESHTOKEN @"https://api.weixin.qq.com/sns/oauth2/refresh_token?appid=%@&grant_type=refresh_token&refresh_token=%@"
#define URL_GETUSERINFO @"https://api.weixin.qq.com/sns/userinfo?access_token=%@&openid=%@"
@protocol WXApiWrapperDelegate<NSObject>
-(void)wxDidReceiveUserInfo:(NSMutableDictionary *)_dic_userinfo;
@end



@interface WXApiWrapper : NSObject<WXApiDelegate>
{
    
}
@property (nonatomic) enum WXScene currentScene;
@property(nonatomic,assign)id<WXApiWrapperDelegate>delegate;
+ (instancetype)sharedManager;
- (void)sendTextContent:(NSString *)kTextMessage;
- (void)sendImageContent:(NSString *)filePath tagName:(NSString *)kImageTagName messageExt:(NSString *)kMessageExt messageAction:(NSString *)kMessageAction thumbimage:(UIImage *)thumbImage;
- (void)sendLinkContent:(NSString *)kLinkURL tagName:(NSString *)kLinkTagName title:(NSString *)kLinkTitle thumbImage:(UIImage *)thumbImage description:(NSString *)kLinkDescription;
- (void)sendMusicContent:(NSString *)kMusicURL dataURL:(NSString *)kMusicDataURL title:(NSString *)kMusicTitle description:(NSString *)kMusicDescription thumImage:(UIImage *)thumbImage;
- (void)sendVideoContent:(NSString *)kVideoURL title:(NSString *)kVideoTitle description:(NSString *)kVideoDescription thumbImage:(UIImage *)thumbImage;
- (void)loginInViewController:(UIViewController *)_controller;
- (void)sendFileContent:(NSString *)filePath fileExt:(NSString *)kFileExtension title:(NSString *)kFileTitle description:(NSString *)kFileDescription thumbImage:(UIImage *)thumbImage;
-(void)getUserInfo;
@end
