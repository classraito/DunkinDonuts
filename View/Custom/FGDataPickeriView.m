//
//  FGDataPickeriew.m
//  DunkinDonuts
//
//  Created by Ryan Gong on 15/11/24.
//  Copyright © 2015年 Ryan Gong. All rights reserved.
//

#import "FGDataPickeriView.h"
#import "Global.h"
@interface FGDataPickeriView()
{
    NSArray *arr_datas;
    NSString *str_selected;
}
@end

@implementation FGDataPickeriView
@synthesize pv;
@synthesize delegate;
-(void)awakeFromNib
{
    [super awakeFromNib];
    pv.delegate = self;
    str_selected = multiLanguage(@"男");
}

-(void)setupDatas:(NSArray*)_arr_datas
{
    arr_datas = [_arr_datas copy];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
}

-(void)dealloc
{
    NSLog(@":::::>dealloc %s %d",__FUNCTION__,__LINE__);
    arr_datas = nil;
}

-(IBAction)buttonAction_done:(id)_sender
{
    if(delegate && [delegate respondsToSelector:@selector(didSelectedDate:)])
    {
        [delegate didSelectData:[str_selected copy]];
    }
}

#pragma mark -
#pragma mark PickerView delegate methods
- (NSString *)pickerView:(UIPickerView *)pickerView titleForRow:(NSInteger)row forComponent:(NSInteger)component
{
    return [arr_datas objectAtIndex:row];
}

- (void)pickerView:(UIPickerView *)pickerView didSelectRow:(NSInteger)row inComponent:(NSInteger)component
{
    str_selected = [arr_datas objectAtIndex:row];
}

- (CGFloat)pickerView:(UIPickerView *)pickerView rowHeightForComponent:(NSInteger)component
{
    return 30;
}

- (NSInteger)pickerView:(UIPickerView *)pickerView numberOfRowsInComponent:(NSInteger)component
{
    return [arr_datas count];
}

- (NSInteger)numberOfComponentsInPickerView:(UIPickerView *)pickerView
{
    return 1;
}
@end
