//
//  FGLoadingViewController.h
//  DunkinDonuts
//
//  Created by Ryan Gong on 15/11/16.
//  Copyright © 2015年 Ryan Gong. All rights reserved.
//

#import "FGBaseViewController.h"

@interface FGLoadingViewController : FGBaseViewController
{
    int currentPage;
    IBOutlet UIView *view_first;
    IBOutlet UIView *view_second;
    IBOutlet UIView *view_third;
    IBOutlet UIView *view_fourth;
    IBOutlet UIView *view_fifth;
    IBOutlet UILabel *lb_tips;
    NSArray *arr_bgColors;
    NSArray *arr_tips;
}
@end
