//
//  FGTopPanelView.m
//  DunkinDonuts
//
//  Created by Ryan Gong on 15/11/16.
//  Copyright © 2015年 Ryan Gong. All rights reserved.
//

#import "FGTopPanelView.h"
#import "Global.h"

@implementation FGTopPanelView
@synthesize lb_title;
@synthesize iv_back;
@synthesize btn_back;
@synthesize iv_settings;
@synthesize btn_settings;
-(void)awakeFromNib
{
    [super awakeFromNib];
    self.backgroundColor = [UIColor clearColor];
    self.str_title = nil;
    lb_title.text = @"";
    lb_title.textColor = [UIColor whiteColor];
    lb_title.font = font(FONT_BOLD, 20);
    
}
/*容器尺寸发生变化后 会自动调用这个方法 使容器内的子视图做相应的变化*/
- (void)layoutSubviews
{
    
    btn_back.center = CGPointMake(btn_back.center.x, self.frame.size.height / 2);
    iv_back.center = btn_back.center;
    
    btn_settings.center =  CGPointMake(btn_settings.center.x, self.frame.size.height / 2);
    iv_settings.center = btn_settings.center;
    
    lb_title.center = CGPointMake(W/2, self.frame.size.height/2);
}

-(NSString *)getMyTitle
{
    return self.str_title;
}

-(void)setMyTitle:(NSString *)__str_title
{
    lb_title.text = __str_title;
    //[lb_title sizeToFit];
    str_title = __str_title;
    lb_title.center = CGPointMake(self.frame.size.width/2, lb_title.center.y);
    
}

-(void)dealloc
{
    NSLog(@":::::>dealloc %s %d",__FUNCTION__,__LINE__);
}

@end
