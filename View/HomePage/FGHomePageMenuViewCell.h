//
//  FGHomePageMenuViewCell.h
//  DunkinDonuts
//
//  Created by Ryan Gong on 15/11/25.
//  Copyright © 2015年 Ryan Gong. All rights reserved.
//

#import "FGCustomizableBaseView.h"

@interface FGHomePageMenuViewCell : FGCustomizableBaseView
{
    
}
@property(nonatomic,assign)IBOutlet UIView *view_background;
@property(nonatomic,assign)IBOutlet UIImageView *iv_thumbnail;
@property(nonatomic,assign)IBOutlet UIView *view_seporator;
@property(nonatomic,assign)IBOutlet UILabel *lb_title;
@property(nonatomic,assign)IBOutlet UILabel *lb_description;
@property(nonatomic,assign)IBOutlet UILabel *lb_right;
@property(nonatomic,assign)IBOutlet UIButton *btn;
@end
