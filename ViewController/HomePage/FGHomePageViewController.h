//
//  FGHomePageViewController.h
//  DunkinDonuts
//
//  Created by Ryan Gong on 15/11/25.
//  Copyright © 2015年 Ryan Gong. All rights reserved.
//

#import "FGBaseViewController.h"
#import "FGHomePageUserInfoView.h"
#import "FGHomePageMenuView.h"
#import "FGHomePageCircleScrollView.h"
@interface FGHomePageViewController : FGBaseViewController
{
    
}
@property(nonatomic,assign)IBOutlet FGHomePageUserInfoView *view_userinfo;
@property(nonatomic,assign)IBOutlet FGHomePageMenuView *view_menu;
@property(nonatomic,assign)IBOutlet FGHomePageCircleScrollView *view_circleScrollView;
@property(nonatomic,assign)IBOutlet UIImageView *iv_arrLeft;
@property(nonatomic,assign)IBOutlet UIImageView *iv_arrRight;
@end
