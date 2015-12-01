//
//  FGRegisterPhoneNumPasswdView.h
//  DunkinDonuts
//
//  Created by Ryan Gong on 15/11/19.
//  Copyright © 2015年 Ryan Gong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FGCustomTextFieldView.h"
#import "FGCustomButton.h"
#import "FGCustomUnderlineButton.h"
@interface FGRegisterPhoneNumPasswdView : UIView<FGCustomTextFieldViewDelegate>
{
    IBOutlet UIView *view_container;
}
@property(nonatomic,assign)IBOutlet FGCustomTextFieldView *ctf_mobile;
@property(nonatomic,assign)IBOutlet FGCustomTextFieldView *ctf_passwd;
@property(nonatomic,assign)IBOutlet FGCustomButton *cb_next;
@property(nonatomic,assign)IBOutlet FGCustomUnderlineButton *cub_loginnow;
@property(nonatomic,assign)IBOutlet UILabel *lb_hyperLink;
@end
