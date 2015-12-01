//
//  FGInboxViewController.h
//  DunkinDonuts
//
//  Created by Ryan Gong on 15/11/25.
//  Copyright © 2015年 Ryan Gong. All rights reserved.
//

#import "FGBaseViewController.h"
#import "FGCustomSegmentSelectView.h"
@interface FGInboxViewController : FGBaseViewController<UITableViewDataSource,UITableViewDelegate,FGCustomSegmentSelectViewDelegate>
{
    
}
@property(nonatomic,assign)IBOutlet UIImageView *iv_topBanner;
@property(nonatomic,assign)IBOutlet FGCustomSegmentSelectView *css_inboxFilter;
@property(nonatomic,assign)IBOutlet UITableView *tb;
@end
