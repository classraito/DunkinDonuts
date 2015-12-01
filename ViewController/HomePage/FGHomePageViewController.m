//
//  FGHomePageViewController.m
//  DunkinDonuts
//
//  Created by Ryan Gong on 15/11/25.
//  Copyright © 2015年 Ryan Gong. All rights reserved.
//

#import "FGHomePageViewController.h"
#import "Global.h"

@interface FGHomePageViewController ()
{
    CGRect origianlFrame_userinfo;
    CGRect originalFrame_iv_arrLeft;
    CGRect originalFrame_iv_arrRight;
}
@end

@implementation FGHomePageViewController
@synthesize view_userinfo;
@synthesize view_menu;
@synthesize view_circleScrollView;
@synthesize iv_arrLeft;
@synthesize iv_arrRight;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.view_topPanel.lb_title removeFromSuperview];
    self.view_topPanel.lb_title = nil;
    [self.view_topPanel.btn_back removeFromSuperview];
    [self.view_topPanel.iv_back removeFromSuperview];
    self.view_topPanel.btn_back = nil;
    self.view_topPanel.iv_back=nil;
    [self.view_contentView removeFromSuperview];
    self.view_contentView = nil;
    [self.iv_bg removeFromSuperview];
    self.iv_bg = nil;
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
    [self setOriginalFrame];
    
    [view_menu.cell_ddPerks.btn addTarget:self action:@selector(buttonAction_menuselected:) forControlEvents:UIControlEventTouchUpInside];
    [view_menu.cell_findAStore.btn addTarget:self action:@selector(buttonAction_menuselected:) forControlEvents:UIControlEventTouchUpInside];
    [view_menu.cell_inbox.btn addTarget:self action:@selector(buttonAction_menuselected:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view bringSubviewToFront:iv_arrLeft];
    [self.view bringSubviewToFront:iv_arrRight];
    [self bindDataToUI];
}

-(void)manullyFixSize
{
    [super manullyFixSize];
    NSLog(@":::::>dealloc %s %d",__FUNCTION__,__LINE__);
    [self internalLayoutUserInfoViewIfNeeded];
    [self internalLayoutMenuViewIfNeeded];
    iv_arrRight.frame = [commond useDefaultRatioToScaleFrame:originalFrame_iv_arrRight];
    iv_arrLeft.frame = [commond useDefaultRatioToScaleFrame:originalFrame_iv_arrLeft];
}

-(void)setOriginalFrame
{
    origianlFrame_userinfo = view_userinfo.frame;
    originalFrame_iv_arrLeft = iv_arrLeft.frame;
    originalFrame_iv_arrRight = iv_arrRight.frame;
}

#pragma mark - layout
-(void)internalLayoutUserInfoViewIfNeeded
{
    view_userinfo.frame = CGRectMake(25, 30, origianlFrame_userinfo.size.width * ratioW, view_userinfo.frame.size.height);
}

-(void)internalLayoutMenuViewIfNeeded
{
    CGRect _frame = view_menu.frame;
    _frame.size.height = H / 2;
    _frame.origin.y = H - _frame.size.height;
    _frame.size.width = W;
    view_menu.frame = _frame;
}

-(void)bindDataToUI
{
    [view_circleScrollView bindDataToUI];
    [view_menu bindDataToUI];
}

#pragma mark - button action
-(void)buttonAction_menuselected:(id)_sender
{
    FGControllerManager *manager = [FGControllerManager sharedManager];
    if([_sender isEqual:view_menu.cell_ddPerks.btn])
    {
        
        [manager pushControllerByName:@"FGDDPerksViewController" inNavigation:nav_main];
    }
    else if([_sender isEqual:view_menu.cell_findAStore.btn])
    {
        [manager pushControllerByName:@"FGLocationsViewController" inNavigation:nav_main];
    }
    else if([_sender isEqual:view_menu.cell_inbox.btn])
    {
        [manager pushControllerByName:@"FGInboxViewController" inNavigation:nav_main];
    }
    
}

-(void)dealloc
{
    NSLog(@":::::>dealloc %s %d",__FUNCTION__,__LINE__);
}
@end
