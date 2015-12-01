//
//  FGLocationsMapSearchResultListView.m
//  DunkinDonuts
//
//  Created by Ryan Gong on 15/11/30.
//  Copyright © 2015年 Ryan Gong. All rights reserved.
//

#import "FGLocationsMapSearchResultListView.h"
#import "Global.h"
#import "FGLocationsMapSearchResultListViewTableViewCell.h"

@interface FGLocationsMapSearchResultListView()
{
    NSMutableArray *arr_datas;
}
@end

@implementation FGLocationsMapSearchResultListView
@synthesize tb;
@synthesize delegate;
-(void)awakeFromNib
{
    [super awakeFromNib];
    tb.delegate = self;
    tb.dataSource = self;
    tb.frame = self.bounds;
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    tb.frame = self.bounds;
}

-(void)dealloc
{
    NSLog(@":::::>dealloc %s %d",__FUNCTION__,__LINE__);
    delegate = nil;
}

-(void)bindDataToUI
{
    DataManager *dataManager = [DataManager sharedManager];
    NSMutableDictionary *dic_datas = [dataManager getDataByUrl:HOST(URL_GetStoresKeyword)];
    arr_datas = [dic_datas objectForKey:@"List"];
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
    return 44 * ratioH;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
    if(delegate && [delegate respondsToSelector:@selector(searchResultListView:didSelectRowAtIndexPath:)])
    {
        [delegate searchResultListView:self didSelectRowAtIndexPath:indexPath];
        NSMutableDictionary *_dic_singleData = [arr_datas objectAtIndex:indexPath.row];
        int storeId = [[_dic_singleData objectForKey:@"StoreId"] intValue];
        [[NetworkManager sharedManager] postRequest_getSotresByStoreId:storeId userinfo:nil];
    } 
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
    NSMutableDictionary *_dic_singleData = [arr_datas objectAtIndex:indexPath.row];
    
    NSString *CellIdentifier = @"FGLocationsMapSearchResultListViewTableViewCell";
    FGLocationsMapSearchResultListViewTableViewCell *cell = (FGLocationsMapSearchResultListViewTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];//从xib初始化tablecell
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:CellIdentifier owner:self options:nil];
        cell = (FGLocationsMapSearchResultListViewTableViewCell *)[nib objectAtIndex:0];
    }
    int distance = [[_dic_singleData objectForKey:@"Distance"] intValue];
    int storeId = [[_dic_singleData objectForKey:@"StoreId"] intValue];
    
    cell.lb_address.text = [_dic_singleData  objectForKey:@"Address"];
    cell.lb_distance.text = [commond meterToKMIfNeeded:distance];
    cell.storeId = storeId;
    return cell;
}
@end
