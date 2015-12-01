//
//  FGDatePickerView.m
//  DunkinDonuts
//
//  Created by Ryan Gong on 15/11/23.
//  Copyright © 2015年 Ryan Gong. All rights reserved.
//

#import "FGDatePickerView.h"
#import "Global.h"
@implementation FGDatePickerView
@synthesize dp_birthday;
@synthesize str_year;
@synthesize delegate;
-(void)awakeFromNib
{
    [super awakeFromNib];
    NSDate *minDate = [commond dateFromString:@"1940-01-01"];
    NSDate *defaultDate = [commond dateFromString:@"1984-06-20"];
    NSDate* maxDate = [NSDate date];
    dp_birthday.minimumDate = minDate;
    dp_birthday.maximumDate = maxDate;
    [dp_birthday setDate:defaultDate animated:YES];
    
}

-(void)layoutSubviews
{
    [super layoutSubviews];
}

-(void)dealloc
{
    NSLog(@":::::>dealloc %s %d",__FUNCTION__,__LINE__);
    
}

-(IBAction)buttonAction_birthday_done:(id)_sender
{
    if(delegate && [delegate respondsToSelector:@selector(didSelectedDate:)])
    {
        NSDateFormatter* dateFormatter=[[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy 年 MM 月 dd 日"];
        str_year = [dateFormatter stringFromDate:dp_birthday.date];
        [delegate didSelectedDate:[str_year copy]];
    }
}
@end
