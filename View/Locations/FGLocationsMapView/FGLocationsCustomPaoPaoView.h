//
//  FGLocationsCustomPaoPaoView.h
//  DunkinDonuts
//
//  Created by Ryan Gong on 15/12/1.
//  Copyright © 2015年 Ryan Gong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FGCustomButton.h"
@interface FGLocationsCustomPaoPaoView : UIView
{
    
}
@property(nonatomic,assign)IBOutlet UIImageView *iv_bg;
@property(nonatomic,assign)IBOutlet UILabel *lb_storeName;
@property(nonatomic,assign)IBOutlet UILabel *lb_storeAddress;
@property(nonatomic,assign)IBOutlet UILabel *lb_storePhone;
@property(nonatomic,assign)IBOutlet UILabel *lb_storeOpenTime;
@property(nonatomic,assign)IBOutlet UIImageView *iv_thumbnail;
@property(nonatomic,assign)IBOutlet UILabel *lb_distance;
@property(nonatomic,assign)IBOutlet FGCustomButton *cb_getDirection;
@property(nonatomic,assign)IBOutlet UIImageView *iv_close;
@property(nonatomic,assign)IBOutlet UIButton *btn_close;
@end
