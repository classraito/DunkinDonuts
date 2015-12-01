//
//  FGIntroGoCircleView.h
//  DunkinDonuts
//
//  Created by Ryan Gong on 15/11/17.
//  Copyright © 2015年 Ryan Gong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FGCustomButton.h"
@interface FGIntroGoCircleView : UIView
{
    FGCustomButton *customButton;
    IBOutlet UILabel *lb_description;
    IBOutlet UIImageView *iv_circle;
}
@property(nonatomic,strong)IBOutlet FGCustomButton *customButton;
@end
