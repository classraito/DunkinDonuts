//
//  FGHomePageCircleScrollView.m
//  DunkinDonuts
//
//  Created by Ryan Gong on 15/11/25.
//  Copyright © 2015年 Ryan Gong. All rights reserved.
//

#import "FGHomePageCircleScrollView.h"
#import "Global.h"
#import "FGHomePageCouponInfoView.h"
#define DEFAULTIMG @"bg3.jpg"
@interface FGHomePageCircleScrollView()
{
   
}
@end


@implementation FGHomePageCircleScrollView
@synthesize mainScorllView;
@synthesize arr_views;
-(void)awakeFromNib
{
    [super awakeFromNib];
    self.backgroundColor = [UIColor clearColor];
    self.view_content.backgroundColor = [UIColor clearColor];
    
    arr_views = [NSMutableArray array];
}

-(void)internalInitalScrollView
{
    NSInteger totalCount = [arr_data_list count];
    for(int i=0;i<totalCount;i++)
    {
        UIImageView *iv_bg = [[UIImageView alloc] init];
        iv_bg.frame = CGRectMake(0, 0, W, H);
        iv_bg.userInteractionEnabled = YES;
        NSLog(@"1.iv_bg = %@",NSStringFromCGRect(iv_bg.frame));
        FGHomePageCouponInfoView *view_couponinfo = (FGHomePageCouponInfoView *)[[[NSBundle mainBundle] loadNibNamed:@"FGHomePageCouponInfoView" owner:nil options:nil] objectAtIndex:0];
        view_couponinfo.lb_title.text = multiLanguage(@"¥5 Off");
        view_couponinfo.lb_description.text = multiLanguage(@"A Dozen Donuts");
        CGRect _frame = view_couponinfo.frame;
        _frame.size.width = W;
        _frame.size.height = H/2 - LAYOUT_STATUSBAR_HEIGHT - LAYOUT_TOPVIEW_HEIGHT;
        _frame.origin.y = H/2 - _frame.size.height;
        view_couponinfo.frame = _frame;
        [iv_bg addSubview:view_couponinfo];
        [arr_views addObject:iv_bg];
        NSLog(@"2.iv_bg = %@",NSStringFromCGRect(iv_bg.frame));
    }
    
    self.mainScorllView = [[CycleScrollView alloc] initWithFrame:CGRectMake(0, 0, W, H) animationDuration:0];
    self.mainScorllView.backgroundColor = [UIColor clearColor];
     __unsafe_unretained typeof(self) weakSelf = self;
    self.mainScorllView.fetchContentViewAtIndex = ^UIView *(NSInteger pageIndex){
       
        return weakSelf.arr_views[pageIndex];
    };
    self.mainScorllView.totalPagesCount = ^NSInteger(void){
        return totalCount;
    };
    self.mainScorllView.TapActionBlock = ^(NSInteger pageIndex){
        NSLog(@"点击了第%ld个",pageIndex);
        
        
    };
    [self addSubview:self.mainScorllView];
}

-(void)bindDataToUI{
    DataManager *dataManager = [DataManager sharedManager];
    NSMutableDictionary *_dic_data = [dataManager getDataByUrl:HOST(URL_GetHomeItem)];
    arr_data_list = [_dic_data objectForKey:@"List"];
    int index = 0;
    
    [self internalInitalScrollView];//需要知道有多少条数据才能初始化界面
    
    for(UIView *subview in  arr_views)
    {
        if([subview isKindOfClass:[UIImageView class]])
        {
            NSMutableDictionary *_dic_singleData = [arr_data_list objectAtIndex:index];
            UIImageView *iv_couponBg = (UIImageView *)subview;
            NSString *_str_bgImg = [_dic_singleData objectForKey:@"BgImg"];
            [iv_couponBg sd_setImageWithURL:[NSURL URLWithString:_str_bgImg] placeholderImage:[UIImage imageNamed:DEFAULTIMG]];
            NSLog(@"iv_couponBg.frame = %@",NSStringFromCGRect(iv_couponBg.frame));
            FGHomePageCouponInfoView *view_couponInfo = (FGHomePageCouponInfoView *)[[iv_couponBg subviews] firstObject];
            view_couponInfo.lb_title.text = [_dic_singleData objectForKey:@"Name" ];
            view_couponInfo.lb_description.text = [_dic_singleData objectForKey:@"Content"];
            view_couponInfo.str_perkId = [_dic_singleData objectForKey:@"PerkId"];
            view_couponInfo.couponType = [[_dic_singleData objectForKey:@"Type"] intValue];
            index++;
        }
    }
}

-(void)layoutSubviews
{
    [super layoutSubviews];
}

-(void)dealloc
{
    NSLog(@":::::>dealloc %s %d",__FUNCTION__,__LINE__);
    arr_views = nil;
}
@end
