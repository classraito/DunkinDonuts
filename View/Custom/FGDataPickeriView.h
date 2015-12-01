//
//  FGDataPickeriew.h
//  DunkinDonuts
//
//  Created by Ryan Gong on 15/11/24.
//  Copyright © 2015年 Ryan Gong. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol FGDataPickerViewDelegate<NSObject>
-(void)didSelectData:(NSString *)_str_selected;
@end
@interface FGDataPickeriView : UIView<UIPickerViewDataSource,UIPickerViewDelegate>
{
    
}
@property(nonatomic,assign)IBOutlet UIPickerView *pv;
@property(nonatomic,assign)id<FGDataPickerViewDelegate>delegate;
-(IBAction)buttonAction_done:(id)_sender;
-(void)setupDatas:(NSArray*)_arr_datas;
@end
