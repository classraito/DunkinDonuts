//
//  FGIntroViewController.h
//  DunkinDonuts
//
//  Created by Ryan Gong on 15/11/10.
//  Copyright © 2015年 Ryan Gong. All rights reserved.
//

#import "FGBaseViewController.h"
#import "FGOTPageScrollView.h"
#import "FGCustomButton.h"
@interface FGIntroViewController : FGBaseViewController<FGOTPageScrollViewDelegate>
{
    FGOTPageScrollView *otp_scrollView;
    
}
@property(nonatomic,strong)IBOutlet FGCustomButton *cb_skip;
@end
