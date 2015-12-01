//
//  FGHomePageCircleScrollView.h
//  DunkinDonuts
//
//  Created by Ryan Gong on 15/11/25.
//  Copyright © 2015年 Ryan Gong. All rights reserved.
//

#import "FGCustomizableBaseView.h"
#import "CycleScrollView.h"
@interface FGHomePageCircleScrollView : FGCustomizableBaseView
{
    NSMutableArray *arr_data_list;
    
}
@property(nonatomic,strong)CycleScrollView *mainScorllView;
@property(nonatomic,strong)NSMutableArray *arr_views;
-(void)bindDataToUI;
@end
