//
//  FGCustomUnderlineButton.m
//
//
//  Created by Ryan Gong on 15/11/20.
//  Copyright © 2015年 Ryan Gong. All rights reserved.
//

#import "FGCustomUnderlineButton.h"
#import "Global.h"
@implementation FGCustomUnderlineButton
@synthesize btn;
@synthesize view_line;
-(void)awakeFromNib
{
    [super awakeFromNib];
    self.view_content.backgroundColor = [UIColor clearColor];
    btn.titleLabel.font = font(FONT_NORMAL, 14);
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
    [btn setTitleColor:[UIColor whiteColor] forState:UIControlStateHighlighted];
    view_line.backgroundColor = [UIColor whiteColor];
    
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    btn.center = CGPointMake(self.frame.size.width/2, self.frame.size.height/2);
    CGRect _frame = view_line.frame;
    _frame.origin.y = self.frame.size.height - 4;
    _frame.size.width = btn.frame.size.width;
    view_line.frame = _frame;
    view_line.center = CGPointMake(btn.center.x, view_line.center.y);
    
}

-(void)dealloc
{
    NSLog(@"::::>dealloc %s %d",__FUNCTION__,__LINE__);
}
@end
