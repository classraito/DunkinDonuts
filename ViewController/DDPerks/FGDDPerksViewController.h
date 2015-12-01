//
//  FGDDPerksViewController.h
//  DunkinDonuts
//
//  Created by Ryan Gong on 15/11/25.
//  Copyright © 2015年 Ryan Gong. All rights reserved.
//

#import "FGBaseViewController.h"
#import "FGCustomSegmentSelectView.h"
#import "FGDDPerksListView.h"
@interface FGDDPerksViewController : FGBaseViewController<FGCustomSegmentSelectViewDelegate>
{
    
}
@property(nonatomic,assign)IBOutlet UIImageView *iv_topBanner;
@property(nonatomic,assign)IBOutlet FGCustomSegmentSelectView *css_showMode;
@property(nonatomic,assign)IBOutlet FGDDPerksListView *view_listView;
@end
