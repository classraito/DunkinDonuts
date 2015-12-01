//
//  FGCustomTextFieldView.m
//  DunkinDonuts
//
//  Created by Ryan Gong on 15/11/19.
//  Copyright © 2015年 Ryan Gong. All rights reserved.
//

#import "FGCustomTextFieldView.h"
#import "Global.h"
@interface FGCustomTextFieldView()
{
   
}
@end

@implementation FGCustomTextFieldView
@synthesize tf;
@synthesize delegate;
@synthesize maxInputLength;
@synthesize minInputLength;
-(void)awakeFromNib
{
    [super awakeFromNib];
    tf.font = font(FONT_NORMAL, 16);
    tf.delegate = self;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
}

-(void)dealloc
{
    NSLog(@":::::>dealloc %s %d",__FUNCTION__,__LINE__);
}

-(void)setupByMaxInputLength:(NSInteger)_maxInputLength
{
    maxInputLength = _maxInputLength;
}

#pragma mark - UITextFieldDelegate
- (void)textFieldDidBeginEditing:(UITextField *)textField;
{
    if(delegate && [(NSObject *)delegate respondsToSelector:@selector(didBeginEditing:)])
    {
        [delegate didBeginEditing:textField];
    }
}

- (BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string;
{
    NSUInteger newLength = [textField.text length] + [string length] - range.length;
    if(newLength > maxInputLength || newLength < minInputLength)
        return NO;
    
    return YES;
    
}

- (BOOL)textFieldShouldReturn:(UITextField *)textField;
{
    if(delegate && [(NSObject *)delegate respondsToSelector:@selector(didClickDoneOnTextField:)])
    {
        [delegate didClickDoneOnTextField:textField];
    }
    [textField resignFirstResponder];
    
    return YES;
}
@end
