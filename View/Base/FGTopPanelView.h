//
//  FGTopPanelView.h
//  DunkinDonuts
//
//  Created by Ryan Gong on 15/11/16.
//  Copyright © 2015年 Ryan Gong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FGTopPanelView : UIView
{
    NSString *str_title;
}
@property(nonatomic,assign)IBOutlet UILabel *lb_title;
@property(nonatomic,assign,getter = getMyTitle,setter = setMyTitle:) NSString *str_title;
@property(nonatomic,assign)IBOutlet UIImageView *iv_back;
@property(nonatomic,assign)IBOutlet UIButton *btn_back;
@property(nonatomic,assign)IBOutlet UIImageView *iv_settings;
@property(nonatomic,assign)IBOutlet UIButton *btn_settings;
@end

