//
//  FGLocationsMapListView.h
//  DunkinDonuts
//
//  Created by Ryan Gong on 15/11/26.
//  Copyright © 2015年 Ryan Gong. All rights reserved.
//

#import "FGCustomizableBaseView.h"

@interface FGLocationsMapListView : FGCustomizableBaseView<UITableViewDataSource,UITableViewDelegate>
{
    
}
@property(nonatomic,assign)IBOutlet UITableView *tb;
-(void)bindDataToUI;
@end
