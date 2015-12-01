//
//  FGLoadingViewController.m
//  DunkinDonuts
//
//  Created by Ryan Gong on 15/11/16.
//  Copyright © 2015年 Ryan Gong. All rights reserved.
//

#import "FGLoadingViewController.h"
#import "Global.h"
@interface FGLoadingViewController ()

@end

@implementation FGLoadingViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self.view_topPanel removeFromSuperview];
    self.view_topPanel = nil;
      [[UIApplication sharedApplication] setStatusBarHidden:YES];
    
    arr_bgColors = @[rgb(109, 160, 192),rgb(254, 213, 135),rgb(234, 108, 42),rgb(78, 47, 18),rgb(231, 223, 216)];
    arr_tips = @[multiLanguage(@"Mmm,smells like coffee."),
                 multiLanguage(@"50% chance of Dunkin."),
                 multiLanguage(@"Hello there,sunshine."),
                 multiLanguage(@"Donut a day keeps the doctor away."),
                 multiLanguage(@"Great day for a Dunkin' Run")];
    view_first.backgroundColor = [UIColor clearColor];
    view_second.backgroundColor = [UIColor clearColor];
    view_third.backgroundColor = [UIColor clearColor];
    view_fourth.backgroundColor = [UIColor clearColor];
    view_fifth.backgroundColor = [UIColor clearColor];
    int randomShow = arc4random() % 5;
    self.view_contentView.backgroundColor = [arr_bgColors objectAtIndex:randomShow];
    switch (randomShow) {
        case 0:
            [self.view_contentView addSubview:view_first];
            view_first.center = CGPointMake(W/2, H/2);
            break;
            
        case 1:
            [self.view_contentView addSubview:view_second];
            view_second.center = CGPointMake(W/2, H/2);
            break;
            
        case 2:
            [self.view_contentView addSubview:view_third];
            view_third.center = CGPointMake(W/2, H/2);
            break;
        case 3:
            [self.view_contentView addSubview:view_fourth];
            view_fourth.center = CGPointMake(W/2, H/2);
            break;
        case 4:
            [self.view_contentView addSubview:view_fifth];
            view_fifth.center = CGPointMake(W/2, H/2);
            break;
    }
    lb_tips.text = [arr_tips objectAtIndex:arc4random()%5];
    [self performSelector:@selector(go2Intro) withObject:nil afterDelay:4];
}

-(void)go2Intro
{
    appDelegate.window.rootViewController = nil;
    FGControllerManager *manager = [FGControllerManager sharedManager];
    [manager initNavigation:&nav_main rootControllerName:@"FGIntroViewController"];
    
}

-(void)manullyFixSize
{
    [super manullyFixSize];
    self.view_contentView.frame = CGRectMake(0, 0, W, H);
}

-(void)dealloc
{
    NSLog(@":::::>dealloc %s %d",__FUNCTION__,__LINE__);
}
@end
