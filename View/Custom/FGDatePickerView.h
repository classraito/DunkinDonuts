//
//  FGDatePickerView.h
//  DunkinDonuts
//
//  Created by Ryan Gong on 15/11/23.
//  Copyright © 2015年 Ryan Gong. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol FGDatePickerViewDelegate <NSObject>
-(void)didSelectedDate:(NSString *)_str_date;
@end

@interface FGDatePickerView : UIView
{
    
}
@property(nonatomic,assign) IBOutlet UIDatePicker *dp_birthday;
@property(nonatomic,assign)id<FGDatePickerViewDelegate>delegate;
@property(nonatomic,strong)NSString *str_year;
@end
