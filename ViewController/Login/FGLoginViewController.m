//
//  FGLoginViewController.m
//  DunkinDonuts
//
//  Created by Ryan Gong on 15/11/23.
//  Copyright © 2015年 Ryan Gong. All rights reserved.
//

#import "FGLoginViewController.h"
#import "Global.h"
@interface FGLoginViewController ()

@end

@implementation FGLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view_registerHome.cb_register.lb_title.text = multiLanguage(@"LOG IN");
}

-(void)manullyFixSize
{
    [super manullyFixSize];
    self.view_registerHome.cb_register.lb_title.text = multiLanguage(@"LOG IN");
}

-(void)dealloc
{
    NSLog(@":::::>dealloc %s %d",__FUNCTION__,__LINE__);
}

-(void)buttonAction_go2Register:(id)_sender
{
    FGControllerManager *manager = [FGControllerManager sharedManager];
    [manager pushControllerByName:@"FGLoginStepViewController" inNavigation:nav_main];
}
@end
