//
//  FGHomePageMenuView.h
//  DunkinDonuts
//
//  Created by Ryan Gong on 15/11/25.
//  Copyright © 2015年 Ryan Gong. All rights reserved.
//

#import "FGCustomizableBaseView.h"
#import "FGHomePageMenuViewCell.h"
@interface FGHomePageMenuView : FGCustomizableBaseView
{
    
}
@property(nonatomic,assign)IBOutlet FGHomePageMenuViewCell *cell_ddPerks;
@property(nonatomic,assign)IBOutlet FGHomePageMenuViewCell *cell_findAStore;
@property(nonatomic,assign)IBOutlet FGHomePageMenuViewCell *cell_inbox;
-(void)bindDataToUI;
@end
