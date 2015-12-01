//
//  FGControllerManager.h
//  Autotrader_Iphone
//
//  Created by rui.gong on 11-5-5.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FGIntroViewController.h"
#import "FGLoadingViewController.h"
#import "FGRegisterViewController.h"
#import "FGRegisterStepViewController.h"
#import "FGLoginViewController.h"
#import "FGLoginStepViewController.h"
#import "FGLoginUpdateProfileViewController.h"
#import "FGHomePageViewController.h"
#import "FGDDPerksViewController.h"
#import "FGInboxViewController.h"
#import "FGLocationsViewController.h"
#import "FGRedeemCouponViewController.h"
#import "FGRedeemCouponQRCodeViewController.h"
#import "FGInboxDetailViewController.h"
extern UINavigationController *nav_main;
BOOL isSameClass(Class _class, Class  _class2);
BOOL isSubClassByClassName(Class _class,NSString *_className);


@interface FGControllerManager : NSObject<UINavigationControllerDelegate> {
    FGIntroViewController *vc_intro;
    FGLoadingViewController *vc_loading;
    FGRegisterViewController *vc_register;
    FGRegisterStepViewController *vc_registerStep;
    FGLoadingViewController *vc_login;
    FGLoginStepViewController *vc_loginStep;
    FGLoginUpdateProfileViewController *vc_loginUpdateProfile;
    FGHomePageViewController *vc_homePage;
    FGDDPerksViewController *vc_ddPerks;
    FGInboxViewController *vc_inbox;
    FGLocationsViewController *vc_locations;
    FGRedeemCouponViewController *vc_redeemCoupon;
    FGRedeemCouponQRCodeViewController *vc_redeemCouponQrCode;
    FGInboxDetailViewController *vc_inboxDetail;
 }
@property(nonatomic,assign)FGLoadingViewController *vc_loading;
@property(nonatomic,assign)FGIntroViewController *vc_intro;
@property(nonatomic,assign)FGRegisterViewController *vc_registerHome;
@property(nonatomic,assign)FGRegisterStepViewController *vc_registerStep;
@property(nonatomic,assign)FGLoadingViewController *vc_login;
@property(nonatomic,assign)FGLoginStepViewController *vc_loginStep;
@property(nonatomic,assign)FGLoginUpdateProfileViewController *vc_loginUpdateProfile;
@property(nonatomic,assign)FGHomePageViewController *vc_homepage;
@property(nonatomic,assign)FGDDPerksViewController *vc_ddPerks;
@property(nonatomic,assign)FGInboxViewController *vc_inbox;
@property(nonatomic,assign)FGLocationsViewController *vc_locations;
@property(nonatomic,assign)FGRedeemCouponViewController *vc_redeem;
@property(nonatomic,assign)FGRedeemCouponQRCodeViewController *vc_redeem_qrCode;
@property(nonatomic,assign)FGInboxDetailViewController *vc_inboxDetail;
-(UIViewController*) getCurrentViewControllerInNav:(UINavigationController *)_nav;
-(void)pushControllerByName:(NSString *)_controllerName navigationController:(UINavigationController *)_navController withAnimation:(BOOL)_animation;
-(void)popAllViewControllerByNavigation:(UINavigationController **)_nav;
-(NSArray *)getAllControllersByNaviion:(UINavigationController *)_nav;
+(FGControllerManager *)sharedManager;
-(void)addViewControllerToWindowByName:(NSString *)_controllerName;
-(void)popToViewControllerInNavigation:(UINavigationController **)_nav controller:(UIViewController *)_controller animated:(BOOL)_animated;
-(void)popViewControllerInNavigation:(UINavigationController **)_nav  animated:(BOOL)_animated;
-(UIViewController *)initializeViewControllerByName:(NSString *)_controllerName create:(BOOL)_isCreate;
-(UIViewController *)initializeViewControllerByName:(NSString *)_controllerName;
-(void)initNavigation:(__strong UINavigationController **)_nav rootControllerName:(NSString *)_rootControllerName;
-(void)initNavigation:(__strong UINavigationController **)_nav rootController:(UIViewController *)_rootController;
-(void)pushControllerByName:(NSString *)_controllerName  inNavigation:(UINavigationController *)_nav;
-(void)pushControllerByName:(NSString *)_controllerName inNavigation:(UINavigationController *)_nav withAnimtae:(BOOL)_animate;
-(void)popToFirstViewControlerInNavigation:(UINavigationController **)_nav animated:(BOOL)_animated;
-(void)pushController:(UIViewController *)_controller navigationController:(UINavigationController *)_navController;
-(void)purgeManager;
@end









