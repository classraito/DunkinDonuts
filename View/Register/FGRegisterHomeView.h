//
//  FGRegisterHomeView.h
//  DunkinDonuts
//
//  Created by Ryan Gong on 15/11/17.
//  Copyright © 2015年 Ryan Gong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FGCustomButton.h"
#import "FGViewWithSepratorLineView.h"
#import "FGCustomUnderlineButton.h"
@interface FGRegisterHomeView : UIView
{
    
}
@property(nonatomic,assign)IBOutlet FGCustomButton *cb_register;
@property(nonatomic,assign)IBOutlet FGCustomButton *cb_weibo;
@property(nonatomic,assign)IBOutlet FGCustomButton *cb_wechat;
@property(nonatomic,assign)IBOutlet UIImageView *iv_thumbnail;
@property(nonatomic,assign)IBOutlet UILabel *lb_description;
@property(nonatomic,assign)IBOutlet FGViewWithSepratorLineView *vsl_sepator;
@property(nonatomic,assign)IBOutlet FGCustomUnderlineButton *btn_underline;
@end
