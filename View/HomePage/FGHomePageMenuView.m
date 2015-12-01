//
//  FGHomePageMenuView.m
//  DunkinDonuts
//
//  Created by Ryan Gong on 15/11/25.
//  Copyright © 2015年 Ryan Gong. All rights reserved.
//

#import "FGHomePageMenuView.h"
#import "Global.h"


@implementation FGHomePageMenuView
@synthesize cell_ddPerks;
@synthesize cell_findAStore;
@synthesize cell_inbox;
-(void)awakeFromNib
{
    [super awakeFromNib];
    self.view_content.backgroundColor = [UIColor clearColor];
    
    [self internalInitalDDperksView];
    [self internalInitalFindAStoreView];
    [self internalInitalInboxView];
}

-(void)internalInitalDDperksView
{
    cell_ddPerks.iv_thumbnail.image = [UIImage imageNamed:@"icon-table2.png"];
    cell_ddPerks.lb_title.text = multiLanguage(@"DD Perks");
    cell_ddPerks.lb_description.text = multiLanguage(@"-- offers");
    cell_ddPerks.lb_right.hidden = YES;
  
}

-(void)internalInitalFindAStoreView
{
     cell_findAStore.iv_thumbnail.image = [UIImage imageNamed:@"home_icon-location.png"];
    cell_findAStore.lb_title.text = multiLanguage(@"Find a Store");
    cell_findAStore.lb_description.text = multiLanguage(@"---------");
    cell_findAStore.lb_right.text = multiLanguage(@"--- m");

}

-(void)internalInitalInboxView
{
    cell_inbox.iv_thumbnail.image = [UIImage imageNamed:@"icon-message2.png"];
    cell_inbox.lb_title.text = multiLanguage(@"Inbox");
    cell_inbox.lb_description.text = multiLanguage(@"Sweet new donut treats and festive coffee favorites");
    cell_inbox.lb_right.hidden = YES;
    
}

-(void)bindDataToUI
{
    DataManager *dataManager = [DataManager sharedManager];
    NSMutableDictionary *_dic_data = [dataManager getDataByUrl:HOST(URL_GetHomeItem)];
    int offersCount = [[_dic_data objectForKey:@"OffersCount"] intValue];
    cell_ddPerks.lb_description.text = [NSString stringWithFormat:@"%d %@",offersCount,multiLanguage(@"offers")];
    
    NSString *_str_storeAddress = [_dic_data objectForKey:@"StoreAddress"];
    NSString *_str_openTime = [_dic_data objectForKey:@"OpenTime"];
    int distance = [[_dic_data objectForKey:@"Distance"] intValue];
    cell_findAStore.lb_description.text = [NSString stringWithFormat:@"%@\n%@",_str_storeAddress,_str_openTime] ;
    cell_findAStore.lb_right.text = [commond meterToKMIfNeeded:distance];
    
    
    
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    CGFloat margin = 10;
    CGFloat padding = 10;
    CGFloat realW = self.frame.size.width - margin ;
    CGFloat realH = self.frame.size.height - margin * 2 - padding * 2;
    
    CGFloat cellH = realH  / 3.0f;
    CGRect _frame = cell_ddPerks.frame;
    _frame.origin.y = margin;
    _frame.size.width = realW;
    _frame.size.height = cellH;
    cell_ddPerks.frame = _frame;
    cell_ddPerks.center = CGPointMake(self.frame.size.width / 2, cell_ddPerks.center.y);
    
    _frame = cell_findAStore.frame;
    _frame.origin.y = cell_ddPerks.frame.origin.y + cell_ddPerks.frame.size.height + padding;
    _frame.size = cell_ddPerks.frame.size;
    cell_findAStore.frame = _frame;
    cell_findAStore.center = CGPointMake(self.frame.size.width / 2, cell_findAStore.center.y);
    
    _frame = cell_inbox.frame;
    _frame.origin.y = cell_findAStore.frame.origin.y + cell_findAStore.frame.size.height + padding;
    _frame.size = cell_findAStore.frame.size;
    cell_inbox.frame = _frame;
    cell_inbox.center = CGPointMake(self.frame.size.width / 2, cell_inbox.center.y);
}



-(void)dealloc
{
    NSLog(@":::::>dealloc %s %d",__FUNCTION__,__LINE__);
}
@end
