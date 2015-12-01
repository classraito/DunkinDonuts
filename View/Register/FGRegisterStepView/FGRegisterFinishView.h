//
//  FGRegisterPhoneNumPasswdView.h
//  DunkinDonuts
//
//  Created by Ryan Gong on 15/11/19.
//  Copyright © 2015年 Ryan Gong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FGCustomButton.h"
#import "FGViewWithSepratorLineView.h"
@interface FGRegisterFinishView : UIView
{
    
}
@property(nonatomic,assign)IBOutlet FGCustomButton *cb_done;
@property(nonatomic,assign)IBOutlet UILabel *lb_title;
@property(nonatomic,assign)IBOutlet UILabel *lb_description;
@property(nonatomic,assign)IBOutlet FGViewWithSepratorLineView *vsl_sepator;
@end
