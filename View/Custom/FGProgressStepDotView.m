//
//  FGProgressStepDotView.m
//  DunkinDonuts
//
//  Created by Ryan Gong on 15/11/19.
//  Copyright © 2015年 Ryan Gong. All rights reserved.
//

#import "FGProgressStepDotView.h"
#import "Global.h"
@implementation FGProgressStepDotView
@synthesize btn1;
@synthesize btn2;
@synthesize btn3;
@synthesize lb1;
@synthesize lb2;
@synthesize lb3;
-(void)awakeFromNib
{
    [super awakeFromNib];
    self.backgroundColor = [UIColor clearColor];
    btn1.titleLabel.font = font(FONT_BOLD, 15);
    btn2.titleLabel.font = font(FONT_BOLD, 15);
    btn3.titleLabel.font = font(FONT_BOLD, 15);
    lb1.font = font(FONT_NORMAL, 12);
    lb2.font = font(FONT_NORMAL, 12);
    lb3.font = font(FONT_NORMAL, 12);
    
    lb1.text = multiLanguage(@"Create Password");
    lb2.text = multiLanguage(@"Verify Mobile No");
    lb3.text = multiLanguage(@"Submit Profile");
    [self clearAllHighlight];
    [self highlightedByIndex:0];
}

-(void)clearAllHighlight
{
    [btn1 setBackgroundImage:[UIImage imageNamed:@"dot2.png"] forState:UIControlStateNormal];
    [btn2 setBackgroundImage:[UIImage imageNamed:@"dot2.png"] forState:UIControlStateNormal];
    [btn3 setBackgroundImage:[UIImage imageNamed:@"dot2.png"] forState:UIControlStateNormal];
    [btn1 setTitleColor:meihongColor forState:UIControlStateNormal];
    [btn2 setTitleColor:meihongColor forState:UIControlStateNormal];
    [btn3 setTitleColor:meihongColor forState:UIControlStateNormal];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    CGRect _frame = self.frame;
    _frame.size.height = lb1.frame.origin.y + lb1.frame.size.height;
    self.frame = _frame;
}

-(void)highlightedByIndex:(NSInteger)_index
{
    [self clearAllHighlight];
    UIButton *selectedButton;
    switch (_index) {
        case 0:
            selectedButton = btn1;
            break;
            
        case 1:
            selectedButton = btn2;
            break;
            
        case 2:
            selectedButton = btn3;
            break;
    }
    
    [selectedButton setBackgroundImage:[UIImage imageNamed:@"dot1.png"] forState:UIControlStateNormal];
    [selectedButton setTitleColor:[UIColor whiteColor] forState:UIControlStateNormal];
}

-(void)dealloc
{
    NSLog(@":::::>dealloc %s %d",__FUNCTION__,__LINE__);
}
@end
