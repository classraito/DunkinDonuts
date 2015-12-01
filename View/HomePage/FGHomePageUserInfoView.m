//
//  FGHomePageUserInfoView.m
//  DunkinDonuts
//
//  Created by Ryan Gong on 15/11/25.
//  Copyright © 2015年 Ryan Gong. All rights reserved.
//

#import "FGHomePageUserInfoView.h"
#import "Global.h"
CGFloat padding = 4;
@implementation FGHomePageUserInfoView
@synthesize iv_thumbnail;
@synthesize lb_title;
@synthesize lb_username;
-(void)awakeFromNib
{
    [super awakeFromNib];
    lb_title.font = font(FONT_NORMAL, 14);
    lb_username.font = font(FONT_NORMAL, 14);
    lb_title.textColor = [UIColor lightGrayColor];
    lb_username.textColor = [UIColor whiteColor];
    self.view_content.backgroundColor = [UIColor clearColor];
    iv_thumbnail.layer.borderColor = [UIColor whiteColor].CGColor;
    iv_thumbnail.layer.borderWidth = 2;
    iv_thumbnail.layer.cornerRadius = iv_thumbnail.frame.size.width / 2;
    iv_thumbnail.layer.masksToBounds = YES;
    
    lb_title.text = multiLanguage(@"欢迎");
    lb_username.text = multiLanguage(@"张小红");
    iv_thumbnail.image = [UIImage imageNamed:@"user.png"];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    iv_thumbnail.center = CGPointMake(iv_thumbnail.center.x, self.frame.size.height / 2);
    CGRect _frame = lb_title.frame;
    _frame.origin.x = iv_thumbnail.frame.origin.x + iv_thumbnail.frame.size.width + padding;
    _frame.origin.y = 0;
    _frame.size.height = self.frame.size.height / 3;
    _frame.size.width = self.frame.size.width - _frame.origin.x;
    lb_title.frame = _frame;
    
    _frame = lb_username.frame;
    _frame.origin.x = lb_title.frame.origin.x;
    _frame.size = lb_title.frame.size;
    _frame.origin.y = lb_title.frame.origin.y + lb_title.frame.size.height;
    lb_username.frame = _frame;

}

-(void)dealloc
{
    NSLog(@":::::>dealloc %s %d",__FUNCTION__,__LINE__);
}
@end
