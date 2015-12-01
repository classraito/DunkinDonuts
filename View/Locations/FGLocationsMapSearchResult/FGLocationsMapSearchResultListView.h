//
//  FGLocationsMapSearchResultListView.h
//  DunkinDonuts
//
//  Created by Ryan Gong on 15/11/30.
//  Copyright © 2015年 Ryan Gong. All rights reserved.
//
@class FGLocationsMapSearchResultListView;
@protocol FGLocationsMapSearchResultListViewDelegate <NSObject>
- (void)searchResultListView:(FGLocationsMapSearchResultListView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
@end

@interface FGLocationsMapSearchResultListView : UIView<UITableViewDataSource,UITableViewDelegate>
{
    
}
@property(nonatomic,assign)IBOutlet UITableView *tb;
@property(nonatomic,assign)id<FGLocationsMapSearchResultListViewDelegate>delegate;
-(void)bindDataToUI;
@end
