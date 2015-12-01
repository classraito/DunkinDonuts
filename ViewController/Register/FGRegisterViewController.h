//
//  FGRegisterViewController.h
//  DunkinDonuts
//
//  Created by Ryan Gong on 15/11/17.
//  Copyright © 2015年 Ryan Gong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FGBaseViewController.h"
#import "FGRegisterHomeView.h"
#import "FGAgreementPanelView.h"
#import "WXApiWrapper.h"
#import "WBApiWrapper.h"
@interface FGRegisterViewController : FGBaseViewController<WXApiWrapperDelegate,WBApiWrapperDelegate>
{
    
}
@property(nonatomic,assign) FGRegisterHomeView *view_registerHome;
@property(nonatomic,assign) FGAgreementPanelView *view_agreement;
@end
