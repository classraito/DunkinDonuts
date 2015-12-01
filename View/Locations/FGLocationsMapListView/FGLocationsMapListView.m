//
//  FGLocationsMapListView.m
//  DunkinDonuts
//
//  Created by Ryan Gong on 15/11/26.
//  Copyright © 2015年 Ryan Gong. All rights reserved.
//

#import "FGLocationsMapListView.h"
#import "Global.h"
#import "FGLocationsMapListViewTableCell.h"
#import "FGLocationsMapListViewMetroTableCell.h"
@interface FGLocationsMapListView()
{
    NSMutableArray *arr_datas;
}
@end

@implementation FGLocationsMapListView
@synthesize tb;
-(void)awakeFromNib
{
    [super awakeFromNib];
    tb.delegate = self;
    tb.dataSource = self;
    self.view_content.backgroundColor = [UIColor clearColor];
    self.backgroundColor = [UIColor clearColor];
    tb.backgroundColor = rgb(241,235,228);
    
}

-(void)layoutSubviews
{
    [super layoutSubviews];
}

-(void)dealloc
{
    NSLog(@":::::>dealloc %s %d",__FUNCTION__,__LINE__);
    arr_datas = nil;
}

-(void)bindDataToUI
{
    DataManager *dataManager = [DataManager sharedManager];
    NSMutableDictionary *dic_datas = [dataManager getDataByUrl:HOST(URL_GetStores)];
    arr_datas = [[dic_datas objectForKey:@"List"] mutableCopy];
    
    for(NSMutableDictionary *_dic_singleData in arr_datas)
    {
        [_dic_singleData setObject:[NSNumber numberWithBool:NO] forKey:@"isCellExpanded"];
    }
    
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
    return 134 * ratioH;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
    
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
    if([[_dic_singleData allKeys] containsObject:@"isMetroCell"])
    {
        NSMutableDictionary *_dic_metroData = [arr_datas  objectAtIndex:indexPath.row - 1];//注意，新增的metro数据是在前一条数据中
        int storeId = [[_dic_metroData objectForKey:@"StoreId"] intValue];
        
        NSString *CellIdentifier = @"FGLocationsMapListViewMetroTableCell";
        FGLocationsMapListViewMetroTableCell *cell_metro = (FGLocationsMapListViewMetroTableCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];//从xib初始化tablecell
        if (cell_metro == nil) {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:CellIdentifier owner:self options:nil];
            cell_metro = (FGLocationsMapListViewMetroTableCell *)[nib objectAtIndex:0];
            [cell_metro.btn_close addTarget:self action:@selector(buttonAction_closeMetro:) forControlEvents:UIControlEventTouchUpInside];
            
        }
        cell_metro.btn_close.tag = storeId;//将storeid作为参数 传递给按钮事件
        NSString *_str_station = [_dic_metroData objectForKey:@"Station"];
        int exitNo = [[_dic_metroData objectForKey:@"ExitNo"] intValue];
        long lat = [[_dic_metroData objectForKey:@"Lat"] longValue];
        long lng = [[_dic_metroData objectForKey:@"Lng"] longValue];
        NSString *_str_metroLine = [_dic_metroData objectForKey:@"MetroLine"];
        
        
        cell_metro.lb_value_exitno.text = [NSString stringWithFormat:@"%d",exitNo];
        cell_metro.lb_value_metroline.text = _str_metroLine;
        cell_metro.lb_value_station.text = _str_station;
        cell_metro.storeId = storeId;
        cell_metro.lat = lat;
        cell_metro.lng = lng;
        cell_metro.iv_triangle.hidden = NO;
        return cell_metro;
    }
    else
    {
        int storeId = [[_dic_singleData objectForKey:@"StoreId"] intValue];
        
        NSString *CellIdentifier = @"FGLocationsMapListViewTableCell";
        FGLocationsMapListViewTableCell *cell = (FGLocationsMapListViewTableCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];//从xib初始化tablecell
        if (cell == nil) {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:CellIdentifier owner:self options:nil];
            cell = (FGLocationsMapListViewTableCell *)[nib objectAtIndex:0];
            [cell.btn_metro addTarget:self action:@selector(buttonAction_metro:) forControlEvents:UIControlEventTouchUpInside];
            
        }
        BOOL isCellExpanded = [[_dic_singleData objectForKey:@"isCellExpanded"] boolValue];
        if(isCellExpanded)
            [cell hideBgShadow];
        else
            [cell showBgShadow];
        cell.btn_metro.tag =storeId;//将storeid作为参数 传递给按钮事件
        
        NSString *_str_address = [_dic_singleData objectForKey:@"Address"];
        int distance = [[_dic_singleData objectForKey:@"Distance"] intValue];
        NSString *_str_storeHours = [_dic_singleData objectForKey:@"StoreHours"];
        NSString *_str_name = [_dic_singleData objectForKey:@"Name"];
        NSString *_str_phone = [_dic_singleData objectForKey:@"Phone"];
       
        cell.lb_storename.text = _str_name;
        cell.lb_address.text = _str_address;
        cell.lb_phone.text = _str_phone;
        cell.lb_openTime.text = _str_storeHours;
        cell.lb_distance.text = [commond meterToKMIfNeeded:distance];
        cell.storeid = storeId;
        [cell setNeedsLayout];
        return cell;
    }
}

/*根据数据arr_datas中的storeid获得 数据的下标*/
-(NSInteger)getDataRowByStoreId:(NSInteger)_storeid
{
    if(!arr_datas)
        return -1;
    if([arr_datas count]<=0)
        return -1;
    NSInteger row = 0;
    int index = 0;
    for(NSMutableDictionary *_dic_singleData in arr_datas)
    {
        if([[_dic_singleData allKeys] containsObject:@"StoreId"])
        {
            int storeId = [[_dic_singleData objectForKey:@"StoreId"] intValue];
            if(storeId == _storeid)
            {
                row = index;
                return row;
            }
        }
        
        
        index++;
    }
    return -1;
}

#pragma mark - buttonAction
-(void)buttonAction_metro:(UIButton *)_sender
{
    NSInteger storeId = _sender.tag;//获得新增行的母行
    NSInteger expendFromRow = [self getDataRowByStoreId:storeId];//从第几行插入
    
    NSMutableDictionary *_dic_datainfo = [arr_datas objectAtIndex:expendFromRow];
    if([[_dic_datainfo allKeys] containsObject:@"isCellExpanded"])
    {
        BOOL isCellExpanded = [[_dic_datainfo objectForKey:@"isCellExpanded"] boolValue];
        if(isCellExpanded)
            return;//母行已经展开过 就不展开了
    }
    [_dic_datainfo setObject:[NSNumber numberWithBool:YES] forKey:@"isCellExpanded"];
    
    FGLocationsMapListViewTableCell *cell = [tb cellForRowAtIndexPath:[NSIndexPath indexPathForRow:expendFromRow inSection:0]];
    [cell hideBgShadow];
    
    NSInteger rowShouldInsert = expendFromRow + 1;//在按钮所在cell行的下一行插入一个cell
    NSMutableDictionary *_dic_singleData = [NSMutableDictionary dictionary];
    [_dic_singleData setObject:@"YES" forKey:@"isMetroCell"];//自定义添加一个key 用于标记数据是否属于地铁界面
    [arr_datas insertObject:_dic_singleData atIndex:rowShouldInsert];
    
     [tb beginUpdates];
     NSArray *arrInsertRows = [NSArray arrayWithObject:[NSIndexPath indexPathForRow:rowShouldInsert inSection:0]];
     [tb insertRowsAtIndexPaths:arrInsertRows withRowAnimation:UITableViewRowAnimationBottom];
     [tb endUpdates];
     
    
}

-(void)buttonAction_closeMetro:(UIButton *)_sender
{
    NSInteger storeId = _sender.tag; //获得新增行的母行
    NSInteger expendFromRow = [self getDataRowByStoreId:storeId];
    
     FGLocationsMapListViewTableCell *cell = [tb cellForRowAtIndexPath:[NSIndexPath indexPathForRow:expendFromRow inSection:0]];
    [cell showBgShadow];
    
    NSMutableDictionary *_dic_datainfo = [arr_datas objectAtIndex:expendFromRow];
    [_dic_datainfo setObject:[NSNumber numberWithBool:NO] forKey:@"isCellExpanded"];
    
   
    NSInteger rowShouldDelete = expendFromRow + 1;//删除关闭按钮所在行
    [arr_datas removeObjectAtIndex:rowShouldDelete];
    
    FGLocationsMapListViewMetroTableCell *cell_metro = [tb cellForRowAtIndexPath:[NSIndexPath indexPathForRow:rowShouldDelete inSection:0]];
    cell_metro.iv_triangle.hidden = YES;
    
    [tb beginUpdates];
    NSArray *arrInsertRows = [NSArray arrayWithObject:[NSIndexPath indexPathForRow:rowShouldDelete inSection:0]];
    [tb deleteRowsAtIndexPaths:arrInsertRows withRowAnimation:UITableViewRowAnimationBottom];
    [tb endUpdates];
    

}
@end
