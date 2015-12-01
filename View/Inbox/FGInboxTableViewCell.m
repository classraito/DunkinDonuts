//
//  FGInboxTableViewCell.m
//  DunkinDonuts
//
//  Created by Ryan Gong on 15/11/26.
//  Copyright © 2015年 Ryan Gong. All rights reserved.
//

#import "FGInboxTableViewCell.h"
#import "Global.h"
@interface FGInboxTableViewCell()
{
    CGRect originalFrame_iv_banner;
    CGRect originalFrame_iv_new;
    CGRect originalFrame_lb_description;
    CGRect originalFrame_lb_time;
    CGRect originalFrame_lb_title;
}
@end

@implementation FGInboxTableViewCell
@synthesize iv_banner;
@synthesize iv_new;
@synthesize lb_description;
@synthesize lb_time;
@synthesize lb_title;

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
    [self setOriginalFrame];
    
    lb_time.font = font(FONT_NORMAL, 11);
    lb_title.font = font(FONT_NORMAL, 12);
    lb_description.font = font(FONT_NORMAL, 12);
    lb_time.textColor = rgb(69, 69, 69);
    lb_description.textColor = rgb(69, 69, 69);
    lb_title.textColor = [UIColor blackColor];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    iv_banner.frame = [commond useDefaultRatioToScaleFrame:originalFrame_iv_banner];
    iv_new.frame = [commond useDefaultRatioToScaleFrame:originalFrame_iv_new];
    lb_description.frame = [commond useDefaultRatioToScaleFrame:originalFrame_lb_description];
    lb_time.frame = [commond useDefaultRatioToScaleFrame:originalFrame_lb_time];
    lb_title.frame = [commond useDefaultRatioToScaleFrame:originalFrame_lb_title];
    
    [lb_description sizeToFit];
    CGRect _frame = lb_description.frame;
    _frame.origin.y = lb_title.frame.origin.y + lb_title.frame.size.height + 2;
    lb_description.frame = _frame;
}

-(void)setOriginalFrame
{
    originalFrame_iv_banner = iv_banner.frame;
    originalFrame_iv_new = iv_new.frame;
    originalFrame_lb_description = lb_description.frame;
    originalFrame_lb_time = lb_time.frame;
    originalFrame_lb_title = lb_title.frame;
}

-(void)dealloc
{
    NSLog(@":::::>dealloc %s %d",__FUNCTION__,__LINE__);
}
@end
