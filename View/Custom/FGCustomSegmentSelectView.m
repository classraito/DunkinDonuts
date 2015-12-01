//
//  FGCustomSegmentSelectView.m
//  DunkinDonuts
//
//  Created by Ryan Gong on 15/11/25.
//  Copyright © 2015年 Ryan Gong. All rights reserved.
//

#import "FGCustomSegmentSelectView.h"
#import "Global.h"
@interface FGCustomSegmentSelectView()
{
    UIView *view_line;
    CGFloat cellWidth;
    CGFloat lineHeight;
    CGFloat spaceV;
    NSInteger total;
}
@end

@implementation FGCustomSegmentSelectView
@synthesize delegate;
-(void)awakeFromNib
{
    [super awakeFromNib];
    self.view_content.backgroundColor = [UIColor clearColor];
    self.layer.shadowColor = [UIColor blackColor].CGColor;
    self.layer.shadowOffset = CGSizeMake(2, 2);
    self.layer.shadowRadius = 2;
    self.layer.shadowOpacity = 1;
}

-(void)setupByTitles:(NSArray *)_arr_titles font:(UIFont *)_font textColor:(UIColor *)_textColor lineColor:(UIColor *)_lineColor lineHeight:(CGFloat)_lineHeight spaceV:(CGFloat )_spaceV
{
    total = [_arr_titles count];
    lineHeight = _lineHeight;
    spaceV = _spaceV;
    
   
  
    view_line = [[UIView alloc] init];
    [self addSubview:view_line];
    view_line.backgroundColor = _lineColor;
    
    
    int i = 0;
    for(NSString *_str_title in _arr_titles)
    {
        UILabel *lb_title = [[UILabel alloc] init];
        lb_title.tag = i+1;
        lb_title.text = _str_title;
        lb_title.font = _font;
        lb_title.textColor = _textColor;
        lb_title.textAlignment = NSTextAlignmentCenter;
        lb_title.backgroundColor = [UIColor clearColor];
        [self addSubview:lb_title];
        
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.tag = i+1;
        btn.backgroundColor = [UIColor clearColor];
        [self addSubview:btn];
        [btn addTarget:self action:@selector(buttonAction_selected:) forControlEvents:UIControlEventTouchUpInside];
        i++;
    }

}

-(void)layoutSubviews
{
    [super layoutSubviews];
    cellWidth = self.frame.size.width / total;
    CGFloat titleHeight = self.frame.size.height - lineHeight - spaceV;
    view_line.frame = CGRectMake(0, self.frame.size.height - lineHeight, cellWidth, lineHeight);
    
    for(UIView *subView in self.subviews)
    {
        if([subView isKindOfClass:[UILabel class]])
        {
            NSInteger index = subView.tag-1;
            UILabel *lb_title = (UILabel *)subView;
            lb_title.frame = CGRectMake(index*cellWidth, 0, cellWidth, titleHeight);
        }
        if([subView isKindOfClass:[UIButton class]])
        {
            NSInteger index = subView.tag - 1;
            UIButton *btn = (UIButton *)subView;
            btn.frame = CGRectMake(index*cellWidth, 0, cellWidth, self.frame.size.height);
        }
    }
    
}

-(void)buttonAction_selected:(UIButton *)_btn
{
    NSInteger index = _btn.tag - 1;
    [UIView beginAnimations:nil context:nil];
    CGRect _frame = view_line.frame;
    _frame.origin.x = index * cellWidth;
    view_line.frame = _frame;
    [UIView commitAnimations];
    
    if(delegate && [delegate respondsToSelector:@selector(didSelectByIndex:)])
    {
        [delegate didSelectByIndex:index];
    }
    
}

-(void)dealloc
{
    NSLog(@":::::>dealloc %s %d",__FUNCTION__,__LINE__);
}
@end
