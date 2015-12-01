//
//  FGCustomSegmentSelectView.h
//  DunkinDonuts
//
//  Created by Ryan Gong on 15/11/25.
//  Copyright © 2015年 Ryan Gong. All rights reserved.
//

#import "FGCustomizableBaseView.h"
@protocol FGCustomSegmentSelectViewDelegate<NSObject>
-(void)didSelectByIndex:(NSInteger)_index;
@end

@interface FGCustomSegmentSelectView : FGCustomizableBaseView
{
    
}
@property(nonatomic,assign)id<FGCustomSegmentSelectViewDelegate>delegate;
-(void)setupByTitles:(NSArray *)_arr_titles font:(UIFont *)_font textColor:(UIColor *)_textColor lineColor:(UIColor *)_lineColor lineHeight:(CGFloat)_lineHeight spaceV:(CGFloat )_spaceV;
@end
