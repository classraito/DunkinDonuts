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
@interface FGREgisterEnterCodeView : UIView<FGCustomTextFieldViewDelegate>
{
    
}
@property(nonatomic,assign)IBOutlet FGCustomTextFieldView *ct_enterCode;
@property(nonatomic,assign)IBOutlet UILabel *lb_description;
@property(nonatomic,assign)IBOutlet FGCustomUnderlineButton *cub_resendCode;
@property(nonatomic,assign)IBOutlet FGCustomButton *cb_next;
@property(nonatomic,assign)IBOutlet UIView *view_container;
@property(nonatomic,assign)IBOutlet FGCustomUnderlineButton *cub_loginNow;
@property(nonatomic,assign)IBOutlet UILabel *lb_hyperlink;
@end
