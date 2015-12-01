//
//  FGOTPageScrollView.h
//  DunkinDonuts
//
//  Created by Ryan Gong on 15/11/16.
//  Copyright © 2015年 Ryan Gong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "OTPageScrollView.h"
#import "OTPageView.h"

@protocol FGOTPageScrollViewDelegate <NSObject>
- (void)otPageScrollView:(OTPageScrollView *)pageScrollView didTapPageAtIndex:(NSInteger)index;

- (void)otPageScrollViewDidEndDecelerating:(UIScrollView *)scrollView atIndex:(NSInteger)index;
@end

/*这个scrollview 可以按照自定的宽度来'分页' */
@interface FGOTPageScrollView : OTPageView<OTPageScrollViewDataSource,OTPageScrollViewDelegate>
{
    UIPageControl *upc;
}
-(id)initWithFrame:(CGRect)frame views:(NSArray *)_arr_views;
@property(nonatomic,assign)NSArray *arr_views;
@property(nonatomic,assign)CGSize cellSize;
@property(nonatomic,assign)id<FGOTPageScrollViewDelegate> delegate;
@end
