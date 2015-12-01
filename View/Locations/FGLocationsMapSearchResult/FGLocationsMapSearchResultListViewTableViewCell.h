//
//  FGLocationsMapSearchResultListViewTableViewCell.h
//  DunkinDonuts
//
//  Created by Ryan Gong on 15/11/30.
//  Copyright © 2015年 Ryan Gong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FGLocationsMapSearchResultListViewTableViewCell : UITableViewCell
{
    
}
@property(nonatomic,assign)IBOutlet UILabel *lb_address;
@property(nonatomic,assign)IBOutlet UILabel *lb_distance;
@property int storeId;
@end
