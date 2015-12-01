//
//  FGLocationsRouteSearchTypeView.h
//  DunkinDonuts
//
//  Created by Ryan Gong on 15/12/1.
//  Copyright © 2015年 Ryan Gong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FGLocationsRouteSearchTypeView : UIView
{
    
}
@property(nonatomic,assign)IBOutlet UIImageView *iv_bus;
@property(nonatomic,assign)IBOutlet UIImageView *iv_car;
@property(nonatomic,assign)IBOutlet UIImageView *iv_walk;
@property(nonatomic,assign)IBOutlet UIButton *btn_bus;
@property(nonatomic,assign)IBOutlet UIButton *btn_car;
@property(nonatomic,assign)IBOutlet UIButton *btn_walk;
@end
