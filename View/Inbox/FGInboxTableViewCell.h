//
//  FGInboxTableViewCell.h
//  DunkinDonuts
//
//  Created by Ryan Gong on 15/11/26.
//  Copyright © 2015年 Ryan Gong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FGInboxTableViewCell : UITableViewCell
{
    
}
@property(nonatomic,assign)IBOutlet UIImageView *iv_banner;
@property(nonatomic,assign)IBOutlet UIImageView *iv_new;
@property(nonatomic,assign)IBOutlet UILabel *lb_time;
@property(nonatomic,assign)IBOutlet UILabel *lb_title;
@property(nonatomic,assign)IBOutlet UILabel *lb_description;
@end
