//
//  AppDelegate.h
//  DunkinDonuts
//
//  Created by Ryan Gong on 15/11/10.
//  Copyright © 2015年 Ryan Gong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FGLocationManagerWrapper.h"
#import <BaiduMapAPI_Base/BMKBaseComponent.h>
extern CGFloat W ;
extern CGFloat H ;
extern CGFloat ratioW;
extern CGFloat ratioH;
extern BOOL isNeedViewMoveUpWhenKeyboardShow;//是否允许键盘展现的时候将当前view上移
extern CGFloat heightNeedMoveWhenKeybaordShow;//当键盘展示时当前view上移多少个像素
@interface AppDelegate : UIResponder <UIApplicationDelegate,BMKGeneralDelegate>

@property (strong, nonatomic) UIWindow *window;


@end

