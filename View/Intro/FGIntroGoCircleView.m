//
//  FGIntroGoCircleView.m
//  DunkinDonuts
//
//  Created by Ryan Gong on 15/11/17.
//  Copyright © 2015年 Ryan Gong. All rights reserved.
//

#import "FGIntroGoCircleView.h"
#import "Global.h"
@implementation FGIntroGoCircleView
@synthesize customButton;
-(void)awakeFromNib
{
    [super awakeFromNib];
    self.backgroundColor = [UIColor clearColor];
    
    lb_description.font = font(FONT_NORMAL, 17);
    lb_description.textColor = [UIColor whiteColor];
    lb_description.text = @"Lets get started!";
    
    customButton.center = CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2 + 30);
    [customButton setFrame:customButton.frame title:@"GO" arrimg:[UIImage imageNamed:@"arr-1.png"] borderColor:[UIColor whiteColor] textColor:[UIColor whiteColor] bgColor:[UIColor clearColor]];
    
    [self addSubview:customButton];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
}

-(void)dealloc
{
    NSLog(@":::::>dealloc %s %d",__FUNCTION__,__LINE__);
    customButton = nil;
}
@end
