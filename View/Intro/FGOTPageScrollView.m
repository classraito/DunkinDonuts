//
//  FGOTPageScrollView.m
//  DunkinDonuts
//
//  Created by Ryan Gong on 15/11/16.
//  Copyright © 2015年 Ryan Gong. All rights reserved.
//

#import "FGOTPageScrollView.h"
#import "Global.h"
@implementation FGOTPageScrollView
@synthesize arr_views;
@synthesize cellSize;
@synthesize delegate;
-(id)initWithFrame:(CGRect)frame views:(NSArray *)_arr_views
{
    if(self = [super initWithFrame:frame])
    {
        arr_views = _arr_views;
        UIView *firstView = [arr_views objectAtIndex:0];
        cellSize = firstView.frame.size;
        self.pageScrollView.dataSource = self;
        self.pageScrollView.delegate = self;
        self.pageScrollView.padding =(self.frame.size.width - cellSize.width)/4;
        self.pageScrollView.leftRightOffset = 0;
        CGSize size = CGSizeMake(cellSize.width+self.pageScrollView.padding, cellSize.height);
        self.pageScrollView.frame = CGRectMake((self.frame.size.width-size.width)/2, (self.frame.size.height-size.height)/2,size.width, size.height);
        [self.pageScrollView reloadData];
        
        upc = [[UIPageControl alloc] initWithFrame:CGRectMake(0, frame.size.height-10, self.frame.size.width, 20)];
        upc.numberOfPages = [_arr_views count];
        upc.currentPage = 0;
        upc.pageIndicatorTintColor = [UIColor lightGrayColor];
        upc.currentPageIndicatorTintColor = [UIColor darkGrayColor];
        [self addSubview:upc];
    }
    return self;
}

- (NSInteger)numberOfPageInPageScrollView:(OTPageScrollView*)pageScrollView{
    return [arr_views count];
}

- (UIView*)pageScrollView:(OTPageScrollView*)pageScrollView viewForRowAtIndex:(int)index{

    return [arr_views objectAtIndex:index];
}

- (CGSize)sizeCellForPageScrollView:(OTPageScrollView*)pageScrollView
{
    return cellSize;
}

- (void)pageScrollView:(OTPageScrollView *)pageScrollView didTapPageAtIndex:(NSInteger)index{
    NSLog(@"click cell at %ld",index);
    if(delegate && [delegate respondsToSelector:@selector(otPageScrollView:didTapPageAtIndex:)])
    {
        [delegate otPageScrollView:pageScrollView didTapPageAtIndex:index];
    }
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    NSInteger index = scrollView.contentOffset.x / scrollView.frame.size.width;
    upc.currentPage = index;
    if(delegate && [delegate respondsToSelector:@selector(otPageScrollViewDidEndDecelerating:atIndex:)])
    {
        [delegate otPageScrollViewDidEndDecelerating:scrollView atIndex:index];
    }
}

-(void)dealloc
{
    NSLog(@":::::>dealloc %s %d",__FUNCTION__,__LINE__);
}
@end
