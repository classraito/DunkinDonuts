//
//  FGIntroCircleView.m
//  DunkinDonuts
//
//  Created by Ryan Gong on 15/11/16.
//  Copyright © 2015年 Ryan Gong. All rights reserved.
//

#import "FGIntroCircleView.h"
#import "Global.h"
@implementation FGIntroCircleView
-(void)awakeFromNib
{
    [super awakeFromNib];
    self.backgroundColor = [UIColor clearColor];
}

-(void)layoutSubviews
{
    iv_circle.center = CGPointMake(self.frame.size.width / 2, self.frame.size.height / 2);
    
    CGRect _frame = lb_description.frame;
    _frame.origin.y = iv_circle.center.y;
    lb_description.frame = _frame;
    lb_description.center = CGPointMake(iv_circle.center.x, lb_description.center.y);
    
    _frame = iv_thumbnail.frame;
    _frame.origin.y = lb_description.frame.origin.y  - iv_thumbnail.frame.size.height - 20;
    _frame.size.width = iv_thumbnail.image.size.width / 3;
    _frame.size.height = iv_thumbnail.image.size.height / 3;
    iv_thumbnail.frame = _frame;
    
    iv_thumbnail.center = CGPointMake(iv_circle.center.x, iv_thumbnail.center.y);
}

-(void)formatString:(NSString *)_str_formatted thumbnail:(NSString *)_str_thumbnail
{
    iv_thumbnail.image = [UIImage imageNamed:_str_thumbnail];
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:_str_formatted];
    NSArray *arr_breaked  = [_str_formatted componentsSeparatedByString:@"\n"];
    lb_description.numberOfLines = [arr_breaked count];//根据\n个数设置行数
    //======第一行 白色 粗体 行间距较宽=================
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:6];//调整行间距
    paragraphStyle.alignment = NSTextAlignmentCenter;
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:[_str_formatted rangeOfString:[arr_breaked objectAtIndex:0]]];
    [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:[_str_formatted rangeOfString:[arr_breaked objectAtIndex:0]]];
    [attributedString addAttribute:NSFontAttributeName value:font(FONT_BOLD, 17) range:[_str_formatted rangeOfString:[arr_breaked objectAtIndex:0]]];
    
    //=========其他行间距较小 字体较小==================
    for(int i=1;i<[arr_breaked count];i++)
    {
        [attributedString addAttribute:NSForegroundColorAttributeName value:[UIColor whiteColor] range:[_str_formatted rangeOfString:[arr_breaked objectAtIndex:i]]];
        [attributedString addAttribute:NSFontAttributeName value:font(FONT_NORMAL, 15) range:[_str_formatted rangeOfString:[arr_breaked objectAtIndex:i]]];
    }
    
    lb_description.attributedText = attributedString;
    [lb_description sizeToFit];
    
    [self setNeedsLayout];
}

-(void)dealloc
{
    NSLog(@":::::>dealloc %s %d",__FUNCTION__,__LINE__);
}
@end
