//
//  FGRegisterPhoneNumPasswdView.h
//  DunkinDonuts
//
//  Created by Ryan Gong on 15/11/19.
//  Copyright © 2015年 Ryan Gong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FGCustomButton.h"
#import "FGCustomTextFieldView.h"
#import "FGDatePickerView.h"
#import "FGDataPickeriView.h"
@interface FGRegisterProfileView : UIView<FGCustomTextFieldViewDelegate,FGDatePickerViewDelegate,FGDataPickerViewDelegate>
{
    FGDatePickerView *view_daypick;
    FGDataPickeriView *view_datapicker;
}
@property(nonatomic,assign)IBOutlet FGCustomTextFieldView *ctf_name;
@property(nonatomic,assign)IBOutlet FGCustomButton *cb_gender;
@property(nonatomic,assign)IBOutlet FGCustomButton *cb_birthday;
@property(nonatomic,assign)IBOutlet FGCustomTextFieldView *ctf_mobile;
@property(nonatomic,assign)IBOutlet FGCustomTextFieldView *ctf_email;
@property(nonatomic,assign)IBOutlet FGCustomButton *cb_submit;
@end
