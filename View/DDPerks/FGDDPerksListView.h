//
//  FGDDPerksListView.h
//  DunkinDonuts
//
//  Created by Ryan Gong on 15/11/25.
//  Copyright © 2015年 Ryan Gong. All rights reserved.
//

#import "FGCustomizableBaseView.h"

@interface FGDDPerksListView : FGCustomizableBaseView<UITableViewDataSource,UITableViewDelegate>
{
    
}
@property(nonatomic,assign)IBOutlet UITableView *tb;
-(void)bindDataToUI;
@end
