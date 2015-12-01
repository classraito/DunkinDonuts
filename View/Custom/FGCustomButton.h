//
//  FGCustomButton.h
//  DunkinDonuts
//
//  Created by Ryan Gong on 15/11/17.
//  Copyright © 2015年 Ryan Gong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FGCustomizableBaseView.h"
@interface FGCustomButton : FGCustomizableBaseView
{
    CGFloat padding;
}
@property(nonatomic,assign)IBOutlet UILabel *lb_title;
@property(nonatomic,assign)IBOutlet UIImageView *iv_arr;
@property(nonatomic,assign)IBOutlet UIButton *button;
@property(nonatomic,assign)IBOutlet UIImageView *iv_thumbnail;
-(void)setFrame:(CGRect)frame title:(NSString *)_str_title arrimg:(UIImage *)_img borderColor:(UIColor *)_borderColor textColor:(UIColor*)_textColor bgColor:(UIColor *)_bgColor;
-(void)setFrame:(CGRect)frame title:(NSString *)_str_title arrimg:(UIImage *)_img borderColor:(UIColor *)_borderColor textColor:(UIColor*)_textColor bgColor:(UIColor *)_bgColor  needTitleLeftAligment:(BOOL)_needTitleLeftAligment;
-(void)setFrame:(CGRect)frame title:(NSString *)_str_title arrimg:(UIImage *)_img thumb:(UIImage *)_thumb borderColor:(UIColor *)_borderColor textColor:(UIColor*)_textColor bgColor:(UIColor *)_bgColor padding:(CGFloat)_padding font:(UIFont *)_font needTitleLeftAligment:(BOOL)_needTitleLeftAligment;
-(void)setFrame:(CGRect)frame title:(NSString *)_str_title arrimg:(UIImage *)_img thumb:(UIImage *)_thumb borderColor:(UIColor *)_borderColor textColor:(UIColor*)_textColor bgColor:(UIColor *)_bgColor padding:(CGFloat)_padding  needTitleLeftAligment:(BOOL)_needTitleLeftAligment;
@end
