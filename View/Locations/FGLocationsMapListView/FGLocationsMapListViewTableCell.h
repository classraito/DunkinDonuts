//
//  FGLocationsMapListViewTableCell.h
//  DunkinDonuts
//
//  Created by Ryan Gong on 15/11/26.
//  Copyright © 2015年 Ryan Gong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FGLocationsMapListViewTableCell : UITableViewCell
{
    
}
@property(nonatomic,assign)IBOutlet UILabel *lb_storename;
@property(nonatomic,assign)IBOutlet UILabel *lb_address;
@property(nonatomic,assign)IBOutlet UILabel *lb_phone;
@property(nonatomic,assign)IBOutlet UILabel *lb_openTime;
@property(nonatomic,assign)IBOutlet UILabel *lb_distance;
@property(nonatomic,assign)IBOutlet UIView *view_separatorLine;
@property(nonatomic,assign)IBOutlet UIButton *btn_pin;
@property(nonatomic,assign)IBOutlet UIButton *btn_metro;
@property(nonatomic,assign)IBOutlet UIButton *btn_call;
@property(nonatomic,assign)IBOutlet UIImageView *iv_pin;
@property(nonatomic,assign)IBOutlet UIImageView *iv_metro;
@property(nonatomic,assign)IBOutlet UIImageView *iv_call;
@property(nonatomic,assign)IBOutlet UIView *view_bg;
@property BOOL isHideBgShadow;
@property int storeid;
-(void)hideBgShadow;
-(void)showBgShadow;
@end
