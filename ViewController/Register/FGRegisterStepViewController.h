//
//  FGRegisterStepViewController.h
//  DunkinDonuts
//
//  Created by Ryan Gong on 15/11/19.
//  Copyright © 2015年 Ryan Gong. All rights reserved.
//

#import "FGBaseViewController.h"
@class FGProgressStepDotView;
@class FGRegisterPhoneNumPasswdView;
@class FGREgisterEnterCodeView;
@class FGRegisterProfileView;
@class FGRegisterFinishView;
@interface FGRegisterStepViewController : FGBaseViewController
{
    FGProgressStepDotView *view_progressDotView;
    FGRegisterPhoneNumPasswdView *view_phonNumPasswd;
    FGREgisterEnterCodeView *view_enterCode;
    FGRegisterProfileView *view_profile;
    FGRegisterFinishView *view_registerFinish;
}
-(void)internalInitalProfileView;
-(void)do_submitProfile;
@end
