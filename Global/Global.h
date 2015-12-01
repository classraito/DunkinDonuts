//
//  Global.h
//  MyStock
//
//  Created by Ryan Gong on 15/9/10.
//  Copyright (c) 2015年 Ryan Gong. All rights reserved.
//


#pragma mark - 导入头
#import "AppDelegate.h"
//工具
#import "commond.h"//一些实用的小工具 不归类了
#import "FGFont.h"
#import "WXApi.h"
#import "WXApiWrapper.h"//微信API封装
#import "WBApiWrapper.h"
#import "SFHFKeychainUtils.h"
#import "NSMutableArray+Safty.h"
#import "NSMutableDictionary+Safty.h"
#import "SecurityUtil.h"
#import "Reachability.h"
#import "NetworkManager.h"
#import "DataManager.h"
#import "UIDevice+IdentifierAddition.h"
#import "JSONKit.h"
#import "NSString+MD5.h"
#import "StringValidate.h"
#import "TAlertView.h"
#import "FGDatePickerView.h"
#import "FGLocationManagerWrapper.h"
#import <CoreLocation/CoreLocation.h>
#import <MapKit/MapKit.h>
#import "UIImageView+WebCache.h"
//viewController
#import "FGControllerManager.h"//管理所有viewcontroller类的 1.初始化 2.销毁 3.导航 4.传递参数 .etc (这个类需要手动管理内存 non-arc)
//字体
#import "Font.h"

//=============微信账号==================
#define WECHAT_APPID @"wx61fa75ed542e1883"
#define WECHAT_APPSECRET @"d4624c36b6795d1d99dcf0547af5443d"
//=============微博账号==================
#define WEIBO_APPKEY @"1438631530"
#define WEIBO_APPSECRET @"bf167edffb795fd1a3052fda4c90544e";
#define WEIBO_kRedirectURI @"http://"
//=============百度地图key=================
#define BAIDU_KEY @"Y0bGYosCzq8DnK1OyQY2wCQl"


#pragma mark -常用宏
#define multiLanguage(text) NSLocalizedString(text, nil)
#define DEBUG_MODE//注释这里 禁用所有NSLog输出
#ifdef DEBUG_MODE
#    define NSLog(...) NSLog(__VA_ARGS__)
#else
#    define NSLog(...)
#endif

#define rgb(r,g,b) [UIColor colorWithRed:(float)r / 255.0f green:(float)g / 255.0f blue:(float)b / 255.0f alpha:1]

#define appDelegate ((AppDelegate *)[UIApplication sharedApplication].delegate) //获得AppDelegate实例的宏 如果你的AppDelegate文件名与我不同 请在这里更改"AppDelegate"

#define LAYOUT_STATUSBAR_HEIGHT [[UIApplication sharedApplication] statusBarFrame].size.height
#define LAYOUT_TOPVIEW_HEIGHT 50        //标题栏的高度
#define LAYOUT_BOTTOMVIEW_HEIGHT 0     //底部标签栏的高度,目前没有底部标签栏，这里作为冗余，如果以后要加入就方便布局了

//============color===========
#define orangeColor rgb(248,117,38)
#define meihongColor rgb(226,40,130)

