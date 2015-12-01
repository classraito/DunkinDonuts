//
//  FGHomePageCouponInfoView.h
//  DunkinDonuts
//
//  Created by Ryan Gong on 15/11/25.
//  Copyright © 2015年 Ryan Gong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FGCustomButton.h"
#import "NetworkManager.h"
@interface FGHomePageCouponInfoView : UIView
{
    
}
@property(nonatomic,assign)IBOutlet UILabel *lb_title;
@property(nonatomic,assign)IBOutlet UILabel *lb_description;
@property(nonatomic,assign)IBOutlet UIImageView *iv_left;
@property(nonatomic,assign)IBOutlet UIImageView *iv_right;
@property(nonatomic,assign)IBOutlet FGCustomButton *cub_redeem;
@property(nonatomic,assign)NSString *str_perkId;
@property CouponType couponType;
@end
