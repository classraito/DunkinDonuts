//
//  FGLocationsMapListViewMetroTableCell.h
//  DunkinDonuts
//
//  Created by Ryan Gong on 15/11/26.
//  Copyright © 2015年 Ryan Gong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FGLocationsMapListViewMetroTableCell : UITableViewCell
{
    
}
@property(nonatomic,assign)IBOutlet UILabel *lb_key_metroline;
@property(nonatomic,assign)IBOutlet UILabel *lb_value_metroline;
@property(nonatomic,assign)IBOutlet UILabel *lb_key_station;
@property(nonatomic,assign)IBOutlet UILabel *lb_value_station;
@property(nonatomic,assign)IBOutlet UILabel *lb_key_exitno;
@property(nonatomic,assign)IBOutlet UILabel *lb_value_exitno;
@property(nonatomic,assign)IBOutlet UIView *view_line1;
@property(nonatomic,assign)IBOutlet UIView *view_line2;
@property(nonatomic,assign)IBOutlet UIImageView *iv_close;
@property(nonatomic,assign)IBOutlet UIButton *btn_close;
@property(nonatomic,assign)IBOutlet UIImageView *iv_triangle;
@property(nonatomic,assign)IBOutlet UIView *view_bg;
@property int storeId;
@property long lat;
@property long lng;
@end
