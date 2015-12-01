//
//  FGLocationsMapSearchResultListViewTableViewCell.m
//  DunkinDonuts
//
//  Created by Ryan Gong on 15/11/30.
//  Copyright © 2015年 Ryan Gong. All rights reserved.
//

#import "FGLocationsMapSearchResultListViewTableViewCell.h"
#import "Global.h"
@interface FGLocationsMapSearchResultListViewTableViewCell()
{
    CGRect originalFrame_lb_distance;
    CGRect originalFrame_lb_address;
}
@end

@implementation FGLocationsMapSearchResultListViewTableViewCell
@synthesize lb_address;
@synthesize lb_distance;
@synthesize storeId;
- (void)awakeFromNib {
    // Initialization code
    lb_distance.font = font(FONT_NORMAL, 12);
    lb_address.font = font(FONT_NORMAL, 12);
    [self setOriginalFrame];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void)setOriginalFrame
{
    originalFrame_lb_address = lb_address.frame;
    originalFrame_lb_distance = lb_distance.frame;
    
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    lb_address.frame = [commond useDefaultRatioToScaleFrame:originalFrame_lb_address];
    lb_distance.frame = [commond useDefaultRatioToScaleFrame:originalFrame_lb_distance];
}

-(void)dealloc
{
    NSLog(@":::::>dealloc %s %d",__FUNCTION__,__LINE__);
}
@end
