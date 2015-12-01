//
//  FGRedeemCouponDescriptionView.h
//  DunkinDonuts
//
//  Created by Ryan Gong on 15/11/25.
//  Copyright © 2015年 Ryan Gong. All rights reserved.
//

#import "FGCustomizableBaseView.h"
#import "FGCustomButton.h"

@interface FGRedeemCouponDescriptionView : FGCustomizableBaseView
{
    
}
@property(nonatomic,assign)IBOutlet UITextView *tv_title;
@property(nonatomic,assign)IBOutlet FGCustomButton *cb_redeem;
@property(nonatomic,assign)IBOutlet FGCustomButton *cb_share;
@property(nonatomic,assign)IBOutlet FGCustomButton *cb_terms;
-(void)bindDataToUI;
@end
