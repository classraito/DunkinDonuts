//
//  FGIntroViewController.m
//  DunkinDonuts
//
//  Created by Ryan Gong on 15/11/10.
//  Copyright © 2015年 Ryan Gong. All rights reserved.
//

#import "FGIntroViewController.h"
#import "Global.h"
#import "FGIntroCircleView.h"
#import "FGIntroGoCircleView.h"
#import "FGIntroBannerView.h"
@interface FGIntroViewController ()
{
    FGIntroBannerView *bannerView ;
  
}
@end

@implementation FGIntroViewController
@synthesize cb_skip;
- (void)viewDidLoad {
    [super viewDidLoad];
    /*去掉标题栏和状态栏*/
    [self.view_topPanel removeFromSuperview];
    self.view_topPanel = nil;
    [self.iv_bg removeFromSuperview];
    self.iv_bg = nil;
    self.view_contentView.backgroundColor = rgb(242, 234, 227);
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
    
    /*初始化数据*/
    // Do any additional setup after loading the view from its nib.
    NSArray *arr_thumbnail = @[@"icon-1.png",@"icon-2.png",@"icon-3.png"];
    NSArray *arr_descriptions = @[
     multiLanguage(@"Full access to great offers\nView mouth watering offers\nand redeem at the\nnearest store"),
     multiLanguage(@"Full access to great offers\nView mouth watering offers\nand redeem at the\nnearest store"),
     multiLanguage(@"Full access to great offers\nView mouth watering offers\nand redeem at the\nnearest store")
    ];
    NSMutableArray *arr_views = [NSMutableArray arrayWithCapacity:1];
    
    /*初始化4个圆*/
    CGFloat cellHeight = 0;
    for(int i=0;i<[arr_thumbnail count];i++)
    {
        FGIntroCircleView *view_circle = (FGIntroCircleView *)[[[NSBundle mainBundle] loadNibNamed:@"FGIntroCircleView" owner:nil options:nil] objectAtIndex:0];
        cellHeight = view_circle.frame.size.height;
        [view_circle formatString:[arr_descriptions objectAtIndex:i] thumbnail:[arr_thumbnail objectAtIndex:i]];
        [arr_views addObject:view_circle];
    }
    
    
    
    FGIntroGoCircleView *view_circle_go = (FGIntroGoCircleView *)[[[NSBundle mainBundle] loadNibNamed:@"FGIntroGoCircleView" owner:nil options:nil] objectAtIndex:0];
    [arr_views addObject:view_circle_go];
    [view_circle_go.customButton.button addTarget:self action:@selector(buttonAction_go:) forControlEvents:UIControlEventTouchUpInside];
    
    /*放到OT ScrollView 中*/
    otp_scrollView = [[FGOTPageScrollView alloc] initWithFrame:CGRectMake(0, 0, W, 324) views:arr_views];
    otp_scrollView.delegate = self;
    [self.view_contentView addSubview:otp_scrollView];
    
    
    /*广告位*/
    bannerView = (FGIntroBannerView *)[[[NSBundle mainBundle] loadNibNamed:@"FGIntroBannerView" owner:nil options:nil] objectAtIndex:0];
    [self.view_contentView addSubview:bannerView];
    
    /*跳过按钮*/
    [cb_skip.button addTarget:self action:@selector(buttonAction_skip:) forControlEvents:UIControlEventTouchUpInside];
}

-(void)manullyFixSize
{
    [super manullyFixSize];
    self.iv_bg.hidden = YES;
    self.view_contentView.frame = CGRectMake(0, 0, W, H);
    otp_scrollView.center = CGPointMake(W/2, H/2);
    bannerView.center = CGPointMake(W/2, bannerView.center.y);
    CGRect _frame = bannerView.frame;
    
    _frame.origin.y = 10;
    if(W<=320)
    {
        _frame.size.height = 100; //iphone4处理
        _frame.origin.y = 0;
    }
    
    bannerView.frame = _frame;
    
    
    _frame = cb_skip.frame;
    _frame.origin.y = self.view.frame.size.height - cb_skip.frame.size.height - 20;
    cb_skip.frame = _frame;
    cb_skip.center = CGPointMake(self.view.frame.size.width / 2, cb_skip.center.y);
    [cb_skip setFrame:cb_skip.frame title:multiLanguage(@"SKIP") arrimg:[UIImage imageNamed:@"arr-2.png"] borderColor:rgb(248,117,38) textColor:rgb(248,117,38) bgColor:[UIColor clearColor]];
}
#pragma mark - button action
-(void)buttonAction_skip:(id)_sender
{
    FGControllerManager *manager = [FGControllerManager sharedManager];
    [manager pushControllerByName:@"FGRegisterViewController" inNavigation:nav_main];
}

-(void)buttonAction_go:(id)_sender
{
    FGControllerManager *manager = [FGControllerManager sharedManager];
    [manager pushControllerByName:@"FGRegisterViewController" inNavigation:nav_main];
}

#pragma mark - FGOTPageScrollViewDelegate
- (void)otPageScrollViewDidEndDecelerating:(UIScrollView *)scrollView atIndex:(NSInteger)index;
{
    if(index == 3)
        cb_skip.hidden = YES;
    else
        cb_skip.hidden = NO;
}

-(void)otPageScrollView:(OTPageScrollView *)pageScrollView didTapPageAtIndex:(NSInteger)index
{
    
}

-(void)dealloc
{
    NSLog(@":::::>dealloc %s %d",__FUNCTION__,__LINE__);
    otp_scrollView.delegate = nil;
    otp_scrollView= nil;
    cb_skip = nil;
}
@end
