//
//  FGInboxDetailViewController.h
//  DunkinDonuts
//
//  Created by Ryan Gong on 15/11/26.
//  Copyright © 2015年 Ryan Gong. All rights reserved.
//

#import "FGBaseViewController.h"

@interface FGInboxDetailViewController : FGBaseViewController
{
    
}
@property(nonatomic,assign)IBOutlet UIImageView *iv_topBanner;
@property(nonatomic,assign)IBOutlet UIView *view_separator;
@property(nonatomic,assign)IBOutlet UIImageView *iv_good;
@property(nonatomic,assign)IBOutlet UIImageView *iv_share;
@property(nonatomic,assign)IBOutlet UIButton *btn_good;
@property(nonatomic,assign)IBOutlet UIButton *btn_share;
@property(nonatomic,assign)IBOutlet UILabel *lb_counter;
@property(nonatomic,assign)IBOutlet UITextView *tv;
-(IBAction)buttonAction_good:(id)_sender;
-(IBAction)buttonAction_share:(id)_sender;
-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil newsid:(int)_newsid;
@end
