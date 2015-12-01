//
//  FGRedeemCouponQRCodeViewController.h
//  DunkinDonuts
//
//  Created by Ryan Gong on 15/11/26.
//  Copyright © 2015年 Ryan Gong. All rights reserved.
//

#import "FGBaseViewController.h"
#import "FGViewWithSepratorLineView.h"
#import "FGCustomButton.h"
@interface FGRedeemCouponQRCodeViewController : FGBaseViewController
{
    
}
@property(nonatomic,assign)IBOutlet UIImageView *iv_topbg;
@property(nonatomic,assign)IBOutlet UIView *view_separatorLine;
@property(nonatomic,assign)IBOutlet UIImageView *iv_qrcode;
@property(nonatomic,assign)IBOutlet UILabel *lb_tips;
@property(nonatomic,assign)IBOutlet FGCustomButton *cb_terms;
@property(nonatomic,assign)IBOutlet FGViewWithSepratorLineView *vsl_title;
@property(nonatomic,assign)IBOutlet UILabel *lb_description;
-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil PerkId:(NSString *)_str_perkId;
@end
