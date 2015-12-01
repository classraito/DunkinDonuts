//
//  AppDelegate.m
//  DunkinDonuts
//
//  Created by Ryan Gong on 15/11/10.
//  Copyright © 2015年 Ryan Gong. All rights reserved.
//

#import "AppDelegate.h"
#import "Global.h"
//==========全局变量===================
CGFloat W ;
CGFloat H ;
CGFloat ratioW;
CGFloat ratioH;
BOOL isNeedViewMoveUpWhenKeyboardShow;//是否允许键盘展现的时候将当前view上移
CGFloat heightNeedMoveWhenKeybaordShow;//当键盘展示时当前view上移多少个像素

@interface AppDelegate ()
{
    BMKMapManager* _mapManager;
}
@end

@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]] ;
    self.window.backgroundColor = [UIColor blackColor];
    
    [FGFont loadMyFonts];
    [FGFont showSupportedFont];
    
    // 要使用百度地图，请先启动BaiduMapManager
    _mapManager = [[BMKMapManager alloc]init];
    BOOL ret = [_mapManager start:BAIDU_KEY generalDelegate:self];
    if (!ret) {
        NSLog(@"manager start failed!");
    }
    
    //===========开启GPS============
    FGLocationManagerWrapper *locationManager = [FGLocationManagerWrapper sharedManager];
    [locationManager startUpdatingLocation:^(CLLocationDegrees lat, CLLocationDegrees lng) {
        NSLog(@"lat = %f",lat);
        NSLog(@"lng = %f",lng);
    }];
    
    //向微信注册
    [WXApi registerApp:WECHAT_APPID withDescription:@"demo 2.0"];
    //向微博注册
    [WeiboSDK enableDebugMode:YES];
    [WeiboSDK registerApp:WeiboAppKey];
//    [self go2LoadingView];
    [self testUI];
//    [self testCode];
    [self.window makeKeyAndVisible];
    
   
    
    return YES;
}

-(void)go2LoadingView
{
    FGLoadingViewController *vc_loading = [[FGLoadingViewController alloc] initWithNibName:@"FGLoadingViewController" bundle:nil];
    self.window.rootViewController = vc_loading;
}

-(void)testUI
{
    FGControllerManager *manager = [FGControllerManager sharedManager];
    [manager initNavigation:&nav_main rootControllerName:@"FGRegisterViewController"];
    
}

-(void)testCode
{
    NSString *testString = @"先AES加密 再base64加密 test test test<>?:!@#$%^&*()_+";
    
    
    NSData *aesData = [SecurityUtil encryptAESData:testString];
    NSLog(@"AES加密:%@", aesData);
    NSString *str = [SecurityUtil encodeBase64Data:aesData];
    NSLog(@"BASE64加密:%@", str);
    NSData *data = [SecurityUtil decodeBase64String:str];
     NSLog(@"BASE64解密:%@", data);
    NSLog(@"AES解密:%@", [SecurityUtil decryptAESData:data]);
    
    NSString *str_url = @"https://dunkindonuts.corfire360.com/mgw/getUnreadMessages";
    NSMutableDictionary *dic_params = [NSMutableDictionary dictionary];
    [dic_params setObject:@"2015-10-09 12:35:18 +0800" forKey:@"lastMessageRead"];
    NSDictionary *dic_headers = @{@"Accept":@"application/json",@"Cookie":@"JSESSIONID=6DAAD0390643D8A6AC838F932A179C18",@"User-Agent":@"iPhone OS|iPhone|3.7",@"Accept-Encoding":@"gzip, deflate"};
    [[NetworkManager sharedManager] requestUrl:str_url params:dic_params headers:dic_headers];
}

-(void)testCode1;
{
    WBApiWrapper *wbmanager = [WBApiWrapper sharedManager];
    WBMessageObject *message = [WBMessageObject message];
    [wbmanager appendText:@"测试通过WeiboSDK发送文字到微博!" toMessage:message];
    [wbmanager appendImageFilePath:[[NSBundle mainBundle] pathForResource:@"image_1" ofType:@"jpg"] toMessage:message];
    [wbmanager shareToWeibo:message];
}

-(void)testCode2;
{
    //    [[WBApiManager sharedManager] requestForWeiboAPIByType:WeiboSDKHttpRequestDemoTypeRequestForUserProfile];
    //    [[WXApiWrapper sharedManager] loginInViewController:self];
    [[WXApiWrapper sharedManager] getUserInfo];
}

- (BOOL)application:(UIApplication *)application openURL:(NSURL *)url sourceApplication:(NSString *)sourceApplication annotation:(id)annotation {
    if([sourceApplication isEqualToString:@"com.tencent.xin"])
    {
        return [WXApi handleOpenURL:url delegate:[WXApiWrapper sharedManager]];
    }
    else if([sourceApplication isEqualToString:@"com.sina.weibo"])
    {
        return [WeiboSDK handleOpenURL:url delegate:[WBApiWrapper sharedManager]];
    }
    
    return NO;
}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
    [BMKMapView willBackGround];
}

- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}

- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
    [BMKMapView didForeGround];
}

- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}

@end
