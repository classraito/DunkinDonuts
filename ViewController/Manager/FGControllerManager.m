//
//  FGControllerManager.m
//  Autotrader_Iphone
//
//  Created by rui.gong on 11-5-5.
//  Copyright 2011年 __MyCompanyName__. All rights reserved.
//

#import "FGControllerManager.h"
#import "Global.h"
static FGControllerManager *manager;
UINavigationController *nav_main;


BOOL isSameClass(Class _class, Class  _class2)
{
    if([NSStringFromClass(_class)isEqualToString:NSStringFromClass(_class2)])
    {
        return YES;
    }
    else
        return NO;
}

BOOL isSubClassByClassName(Class _class,NSString *_className)
{
    if([_class isSubclassOfClass:NSClassFromString(_className)])
    {
        return YES;
    }
    else
    return NO;
}

extern void instanceXibClass(id * _obj,NSString *_str)
{
    *_obj = [[NSClassFromString(_str) alloc]initWithNibName:_str bundle:nil];
}



@implementation FGControllerManager
@synthesize vc_intro;
@synthesize vc_loading;
@synthesize vc_registerHome;
@synthesize vc_registerStep;
@synthesize vc_login;
@synthesize vc_loginStep;
@synthesize vc_loginUpdateProfile;
@synthesize vc_homepage;
@synthesize vc_ddPerks;
@synthesize vc_inbox;
@synthesize vc_locations;
@synthesize vc_redeem;
@synthesize vc_redeem_qrCode;
@synthesize vc_inboxDetail;
-(UIViewController*) getCurrentViewControllerInNav:(UINavigationController *)_nav
{
    if(!_nav)
        return nil;
    
    return  _nav.topViewController;
}

-(void)initNavigationByControllerRootName:(NSString *)_rootControllerName navigationController:(__strong UINavigationController **)_navController
{
    if(!(*_navController))
    {
        
        NSLog(@":::::>-(void)addNavigationByControllerByRootName:(NSString *)=%@",_rootControllerName);
        UIViewController *_viewController = [self initializeViewControllerByName:_rootControllerName];
        *_navController =[ [UINavigationController alloc] initWithRootViewController:_viewController];
        (*_navController).delegate = self;
        (*_navController).navigationBarHidden=YES;
        [_viewController release];
        
//        [appDelegate.window addSubview:(*_navController).view];
        
    }
    else
    {
//        [appDelegate.window bringSubviewToFront:(*_navController).view];
    }
    
    appDelegate.window.rootViewController = *_navController;
    NSLog(@"(*_navController).view] = %@",(*_navController).view);
    NSLog(@"window subviews=%@",[appDelegate.window subviews]);
    
}

-(void)initNavigationByControllerRootController:(UIViewController *)_rootController navigationController:(__strong UINavigationController **)_navController
{
    NSLog(@":::::>-(void)initNavigationByControllerRootController:(NSString *)=%@",_rootController);
    NSLog(@"_rootController=%@",_rootController);
    if(!(*_navController))
    {
        *_navController =[ [UINavigationController alloc] initWithRootViewController:_rootController];
        (*_navController).delegate = self;
        (*_navController).navigationBarHidden=YES;
        [_rootController release];
        [appDelegate.window addSubview:(*_navController).view];
    }
    else
    {
        [appDelegate.window bringSubviewToFront:(*_navController).view];
    }
    
    NSLog(@"window subviews=%@",[appDelegate.window subviews]);
}

-(void)pushControllerByName:(NSString *)_controllerName navigationController:(UINavigationController *)_navController withAnimation:(BOOL)_animation
{
    NSLog(@":::::>-(void)pushControllerByName:(NSString *)=%@ navigationController:(UINavigationController *)=%@",_controllerName,_navController);
    assert(_controllerName);
    assert(_navController);
    UIViewController *_viewController = [self initializeViewControllerByName:_controllerName];
    [_navController pushViewController:_viewController animated:_animation];
    [_viewController release];
}

-(void)popAllViewControllerByNavigation:(UINavigationController **)_nav
{
    NSLog(@"popAllViewControllerByNavigation:%@",*_nav);
    if(*_nav!=nil)
    {
        NSLog(@"*_nav=%@",(*_nav));
        [(*_nav) popToRootViewControllerAnimated:NO];
        [(*_nav) release];
        (*_nav)=nil;
    }
}

-(NSArray *)getAllControllersByNaviion:(UINavigationController *)_nav
{
    assert(_nav);
    return  [_nav viewControllers];
}



+(FGControllerManager *)sharedManager
{
    @synchronized(self)     {
        if(!manager)
        {
            manager=[[FGControllerManager alloc]init];
            NSLog(@"init FGControllerManager");
            return manager;
        }
    }
    return manager;
}

+(id)alloc
{
    @synchronized(self)     {
        NSAssert(manager == nil, @"企圖創建一個singleton模式下的FGControllerManager");
        return [super alloc];
    }
    return nil;
}

-(void)addViewControllerToWindowByName:(NSString *)_controllerName
{
    UIViewController *_controllerView = [self initializeViewControllerByName:_controllerName];
    assert(_controllerView);
    [appDelegate.window addSubview:_controllerView.view];
}

-(void)popToFirstViewControlerInNavigation:(UINavigationController **)_nav animated:(BOOL)_animated
{
    if( (* _nav) )
    {
        [(*_nav) popToRootViewControllerAnimated:_animated];
    }
}

-(void)popToViewControllerInNavigation:(UINavigationController **)_nav controller:(UIViewController *)_controller animated:(BOOL)_animated
{
    NSLog(@":::::>-(void)popToViewControllerInNavigationByName");
    if( (* _nav) )
    {
        if([(* _nav).viewControllers count]==1)
        {
            NSLog(@"just have one controller in UINavigationController back to home");
            //(* _nav)=nil;
        }
        else
        {
            [(* _nav) popToViewController:_controller animated:_animated];
        }
    }
}

-(void)popViewControllerInNavigation:(UINavigationController **)_nav  animated:(BOOL)_animated
{
    NSLog(@":::::>-(void)popViewControllerInNavigation");
    assert( (* _nav) );
    if([(* _nav).viewControllers count]==1)
    {
        NSLog(@"just have one controller in UINavigationController back to home");
    }
    else
    {
        [(* _nav) popViewControllerAnimated:_animated];
    }
}

-(UIViewController *)initializeViewControllerByName:(NSString *)_controllerName create:(BOOL)_isCreate
{
    
    NSLog(@":::::>-(UIViewController *)initializeViewControllerByName:(NSString *)=%@",_controllerName);
    
    if(isSubClassByClassName([FGIntroViewController class], _controllerName))
    {
        if(_isCreate)
            instanceXibClass(&vc_intro, _controllerName);
        return vc_intro;
    }
    if(isSubClassByClassName([FGLoadingViewController class], _controllerName))
    {
        if(_isCreate)
            instanceXibClass(&vc_loading, _controllerName);
        return vc_loading;
    }
    if(isSubClassByClassName([FGRegisterViewController class], _controllerName))
    {
        if(_isCreate)
            instanceXibClass(&vc_registerHome, _controllerName);
        return vc_registerHome;
    }
    
    if(isSubClassByClassName([FGRegisterStepViewController class], _controllerName))
    {
        if(_isCreate)
            instanceXibClass(&vc_registerStep, _controllerName);
        return vc_registerStep;
    }
    if(isSubClassByClassName([FGLoginViewController class], _controllerName))
    {
        if(_isCreate)
            instanceXibClass(&vc_login, _controllerName);
        return vc_login;
    }
    if(isSubClassByClassName([FGLoginStepViewController class], _controllerName))
    {
        if(_isCreate)
            instanceXibClass(&vc_loginStep, _controllerName);
        return vc_loginStep;
    }
    if(isSubClassByClassName([FGLoginUpdateProfileViewController class], _controllerName))
    {
        if(_isCreate)
            instanceXibClass(&vc_loginUpdateProfile, _controllerName);
        return vc_loginUpdateProfile;
    }
    if(isSubClassByClassName([FGHomePageViewController class], _controllerName))
    {
        if(_isCreate)
            instanceXibClass(&vc_homepage, _controllerName);
        return vc_homepage;
    }
    if(isSubClassByClassName([FGDDPerksViewController class], _controllerName))
    {
        if(_isCreate)
            instanceXibClass(&vc_ddPerks, _controllerName);
        return vc_ddPerks;
    }
    if(isSubClassByClassName([FGInboxViewController class], _controllerName))
    {
        if(_isCreate)
            instanceXibClass(&vc_inbox, _controllerName);
        return vc_inbox;
    }
    if(isSubClassByClassName([FGLocationsViewController class], _controllerName))
    {
        if(_isCreate)
            instanceXibClass(&vc_locations, _controllerName);
        return vc_locations;
    }
    if(isSubClassByClassName([FGRedeemCouponViewController class], _controllerName))
    {
        if(_isCreate)
            instanceXibClass(&vc_redeem, _controllerName);
        return vc_redeem;
    }
    if(isSubClassByClassName([FGRedeemCouponQRCodeViewController class], _controllerName))
    {
        if(_isCreate)
            instanceXibClass(&vc_redeem_qrCode, _controllerName);
        return vc_redeem_qrCode;
    }
    if(isSubClassByClassName([FGInboxDetailViewController class], _controllerName))
    {
        if(_isCreate)
            instanceXibClass(&vc_inboxDetail, _controllerName);
        return vc_inboxDetail;
    }
    return nil;
}

-(UIViewController *)initializeViewControllerByName:(NSString *)_controllerName
{
    return [self initializeViewControllerByName:_controllerName create:YES];
}

-(void)initNavigation:(UINavigationController **)_nav rootControllerName:(NSString *)_rootControllerName
{
    [self initNavigationByControllerRootName:_rootControllerName navigationController:_nav];
    
}

-(void)initNavigation:(UINavigationController **)_nav rootController:(UIViewController *)_rootController
{
    
    [self initNavigationByControllerRootController:_rootController navigationController:_nav];
    
}

-(void)pushControllerByName:(NSString *)_controllerName  inNavigation:(UINavigationController *)_nav
{
    [self pushControllerByName:_controllerName navigationController:_nav withAnimation:YES];
}

-(void)pushControllerByName:(NSString *)_controllerName inNavigation:(UINavigationController *)_nav withAnimtae:(BOOL)_animate
{
    [self pushControllerByName:_controllerName navigationController:_nav withAnimation:_animate];
}

-(void)pushController:(UIViewController *)_controller navigationController:(UINavigationController *)_navController
{
    assert(_navController);
    [_navController pushViewController:_controller animated:YES];
//    [_controller release];
}


-(void)purgeManager
{
    [manager release];
}

-(void)dealloc
{
    NSLog(@":::::>dealloc FGControllerManager");
    
    [super dealloc];
}

- (void)navigationController:(UINavigationController *)navigationController didShowViewController:(UIViewController *)viewController animated:(BOOL)animated
{
    NSLog(@"navigationController=%@  viewController=%@",navigationController,viewController);
}
@end


