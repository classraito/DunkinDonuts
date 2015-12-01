//
//  FGDDPerksListView.m
//  DunkinDonuts
//
//  Created by Ryan Gong on 15/11/25.
//  Copyright © 2015年 Ryan Gong. All rights reserved.
//

#import "FGDDPerksListView.h"
#import "Global.h"
#import "FGDDPerksListViewTableCell.h"
#define DEFAULT_PERK_BGIMG @"offers1.jpg"
@interface FGDDPerksListView()
{
    NSMutableArray *arr_datas;
}
@end

@implementation FGDDPerksListView
@synthesize tb;
-(void)awakeFromNib
{
    [super awakeFromNib];
    tb.delegate = self;
    tb.dataSource = self;
    arr_datas = [NSMutableArray array];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
}

-(void)dealloc
{
    NSLog(@":::::>dealloc %s %d",__FUNCTION__,__LINE__);
}

-(void)bindDataToUI
{
    DataManager *dataManager = [DataManager sharedManager];
    NSMutableDictionary *_dic_datas = [dataManager getDataByUrl:HOST(URL_GetPerks)];
    arr_datas = [_dic_datas objectForKey:@"List"];
    if(arr_datas)
    {
        [tb reloadData];
        [tb setNeedsDisplay];
    }
    
}
#pragma mark - UITableViewDelegate
/*table cell高度*/
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    return 157 * ratioH;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
     NSMutableDictionary *_dic_singleData = [arr_datas objectAtIndex:indexPath.row];
    NSString *_str_perkId = [_dic_singleData objectForKey:@"PerkId"];
    
    
    FGControllerManager *manager = [FGControllerManager sharedManager];
    FGRedeemCouponViewController *vc_redeem = [[FGRedeemCouponViewController alloc] initWithNibName:@"FGRedeemCouponViewController" bundle:nil PerkId:_str_perkId];
    [manager pushController:vc_redeem navigationController:nav_main];
    
    
}
#pragma mark - UITableViewDatasource
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView;
{
    return 1;
}
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section;
{
    return [arr_datas count];
}
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    NSString *CellIdentifier = @"FGDDPerksListViewTableCell";
    FGDDPerksListViewTableCell *cell = (FGDDPerksListViewTableCell *)[tableView dequeueReusableCellWithIdentifier:@"DontNeedReuse"];//从xib初始化tablecell
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:CellIdentifier owner:self options:nil];
        cell = (FGDDPerksListViewTableCell *)[nib objectAtIndex:0];
    }
    
    //======================get single data=====================================
    NSMutableDictionary *_dic_singleData = [arr_datas objectAtIndex:indexPath.row];
    NSString *_str_url = [_dic_singleData objectForKey:@"SmallBgImg"];
    NSString *_str_content = [_dic_singleData objectForKey:@"Content"];
    NSString *_str_Name = [_dic_singleData objectForKey:@"Name"];
    int loveCount = [[_dic_singleData objectForKey:@"LoveCount"] intValue];
    BOOL loveFlag = [[_dic_singleData objectForKey:@"LoveFlag"] boolValue];
    BOOL favoriteFlag = [[_dic_singleData objectForKey:@"FavoriteFlag"] boolValue];
    NSString *_str_perkId = [_dic_singleData objectForKey:@"PerkId"];
    
    //=======================bind data to UI====================================
    [cell.iv_bg sd_setImageWithURL:[NSURL URLWithString:_str_url] placeholderImage:[UIImage imageNamed:DEFAULT_PERK_BGIMG]];
    [cell setupTitle:multiLanguage(@"Holiday Special")];
    cell.lb_description.text = _str_content;
    cell.lb_counter.text = [NSString stringWithFormat:@"%d",loveCount];
    cell.lb_title.text = _str_Name;
    cell.iv_favorite.highlighted = favoriteFlag;
    cell.iv_good.highlighted = loveFlag;
    cell.loveFlag = loveFlag;
    cell.favoriteFlag = favoriteFlag;
    cell.str_perkId = _str_perkId;
    return cell;
}
@end
