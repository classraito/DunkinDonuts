//
//  FGRedeemCouponViewController.h
//  DunkinDonuts
//
//  Created by Ryan Gong on 15/11/25.
//  Copyright © 2015年 Ryan Gong. All rights reserved.
//

#import "FGBaseViewController.h"
#import "FGRedeemCouponBannerView.h"
#import "FGRedeemCouponDescriptionView.h"
@interface FGRedeemCouponViewController : FGBaseViewController
{
    
}
@property(nonatomic,assign)IBOutlet FGRedeemCouponBannerView *view_bannerView;
@property(nonatomic,assign)IBOutlet FGRedeemCouponDescriptionView *view_description;
-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil PerkId:(NSString *)_str_perkId;
@end
