//
//  FGHomePageMenuViewCell.m
//  DunkinDonuts
//
//  Created by Ryan Gong on 15/11/25.
//  Copyright © 2015年 Ryan Gong. All rights reserved.
//

#import "FGHomePageMenuViewCell.h"
#import "Global.h"
@interface FGHomePageMenuViewCell()
{
    CGRect originalFrame_seporator;
    CGRect originalFrame_title;
    CGRect originalFrame_description;
    CGRect originalFrame_right;
}
@end

@implementation FGHomePageMenuViewCell
@synthesize iv_thumbnail;
@synthesize view_seporator;
@synthesize lb_title;
@synthesize lb_description;
@synthesize lb_right;
@synthesize view_background;
@synthesize btn;
-(void)awakeFromNib
{
    [super awakeFromNib];
    self.view_content.backgroundColor = [UIColor clearColor];
    lb_title.font = font(FONT_BOLD, 18);
    lb_description.font = font(FONT_NORMAL, 13);
    lb_title.textColor = meihongColor;
    lb_right.font = font(FONT_NORMAL, 12);
    lb_description.textColor = [UIColor darkGrayColor];
    view_background.layer.cornerRadius = 6;
    view_background.layer.masksToBounds = YES;
    [self setOriginalFrame];
    self.layer.shadowColor = [UIColor blackColor].CGColor;
    self.layer.shadowOffset = CGSizeMake(2, 2);
    self.layer.shadowRadius = 2;
    self.layer.shadowOpacity = 1;
}

-(void)setOriginalFrame
{
    originalFrame_seporator = view_seporator.frame;
    originalFrame_title = lb_title.frame;
    originalFrame_description = lb_description.frame;
    originalFrame_right = lb_right.frame;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    CGRect _frame = iv_thumbnail.frame;
    _frame.origin.x = 20 * ratioW;
    _frame.size.width = iv_thumbnail.image.size.width / 3 * ratioW;
    _frame.size.height = iv_thumbnail.image.size.height / 3 * ratioH;
    iv_thumbnail.frame = _frame;
    iv_thumbnail.center = CGPointMake(iv_thumbnail.center.x, self.frame.size.height / 2);
    
    _frame = view_seporator.frame;
    _frame.origin.x = originalFrame_seporator.origin.x * ratioW;
    _frame.size.height = originalFrame_seporator.size.height * ratioH;
    view_seporator.frame = _frame;
    view_seporator.center = CGPointMake(view_seporator.center.x, self.frame.size.height / 2);
    
    _frame = lb_title.frame;
    _frame.origin.x = originalFrame_title.origin.x * ratioW;
    _frame.size.width = originalFrame_title.size.width * ratioW;
    _frame.size.height = originalFrame_title.size.height * ratioH;
    _frame.origin.y = originalFrame_title.origin.y * ratioH;
    lb_title.frame = _frame;
    
    _frame = lb_description.frame;
    _frame.origin.x = originalFrame_description.origin.x * ratioW;
    _frame.origin.y = originalFrame_description.origin.y * ratioH;
    _frame.size.width = originalFrame_description.size.width * ratioW;
    _frame.size.height = originalFrame_description.size.height * ratioH;
    lb_description.frame = _frame;
    
    
    _frame = lb_right.frame;
    _frame.origin.x = originalFrame_right.origin.x * ratioW;
    _frame.origin.y = originalFrame_right.origin.y * ratioH;
    _frame.size.width = originalFrame_right.size.width * ratioW;
    _frame.size.height = originalFrame_right.size.height * ratioH;
    lb_right.frame = _frame;
}

-(void)dealloc
{
    NSLog(@":::::>dealloc %s %d",__FUNCTION__,__LINE__);
}
@end
