//
//  FGDDPerksListViewTableCell.h
//  DunkinDonuts
//
//  Created by Ryan Gong on 15/11/25.
//  Copyright © 2015年 Ryan Gong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FGViewWithSepratorLineView.h"
@interface FGDDPerksListViewTableCell : UITableViewCell
{
    
}
@property(nonatomic,strong) UILabel *lb_title;
@property(nonatomic,assign)IBOutlet FGViewWithSepratorLineView *vsl_title;
@property(nonatomic,assign)IBOutlet UILabel *lb_description;
@property(nonatomic,assign)IBOutlet UIImageView *iv_good;
@property(nonatomic,assign)IBOutlet UIImageView *iv_favorite;
@property(nonatomic,assign)IBOutlet UIButton *btn_good;
@property(nonatomic,assign)IBOutlet UIButton *btn_favorite;
@property(nonatomic,assign)IBOutlet UIImageView *iv_bg;
@property(nonatomic,assign)IBOutlet UILabel *lb_counter;
@property(nonatomic,assign)NSString *str_perkId;
@property BOOL loveFlag;
@property BOOL favoriteFlag;
-(void)setupTitle:(NSString *)_str_title;
-(IBAction)buttonAction_favorite:(id)_sender;
-(IBAction)buttonAction_good:(id)_sender;
@end
