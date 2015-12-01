//
//  FGIntroCircleView.h
//  DunkinDonuts
//
//  Created by Ryan Gong on 15/11/16.
//  Copyright © 2015年 Ryan Gong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FGIntroCircleView : UIView
{
    IBOutlet UIImageView *iv_thumbnail;
    IBOutlet UILabel *lb_description;
    IBOutlet UIImageView *iv_circle;
}
-(void)formatString:(NSString *)_str_formatted thumbnail:(NSString *)_str_thumbnail;
@end
