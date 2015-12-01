//
//  FGLoginUpdateProfileViewController.h
//  DunkinDonuts
//
//  Created by Ryan Gong on 15/11/24.
//  Copyright © 2015年 Ryan Gong. All rights reserved.
//

#import "FGRegisterStepViewController.h"
typedef enum {
    UserInfoBy_WeChat,
    UserInfoBy_Weibo
}UserInfoBy;

@interface FGLoginUpdateProfileViewController : FGRegisterStepViewController
{
    
}
-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil userInfoBy:(UserInfoBy)_userinfoBy;
@end
