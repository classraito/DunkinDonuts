//
//  FGRedeemCouponBannerView.h
//  DunkinDonuts
//
//  Created by Ryan Gong on 15/11/25.
//  Copyright © 2015年 Ryan Gong. All rights reserved.
//

#import "FGCustomizableBaseView.h"
#import "FGViewWithSepratorLineView.h"

@interface FGRedeemCouponBannerView : FGCustomizableBaseView
{
    
}
@property(nonatomic,assign)IBOutlet FGViewWithSepratorLineView *vsl_title;
@property(nonatomic,assign)IBOutlet UILabel *lb_description;
@property(nonatomic,assign)IBOutlet UIImageView *iv_good;
@property(nonatomic,assign)IBOutlet UIImageView *iv_favorite;
@property(nonatomic,assign)IBOutlet UILabel *lb_counter;
@property(nonatomic,assign)IBOutlet UIButton *btn_good;
@property(nonatomic,assign)IBOutlet UIButton *btn_favorite;
@property(nonatomic,assign)IBOutlet UIImageView *iv_bg;

-(void)setupTitle:(NSString *)_str_title;
-(void)bindDataToUI;
@end
