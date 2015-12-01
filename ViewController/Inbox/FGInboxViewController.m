//
//  FGInboxViewController.m
//  DunkinDonuts
//
//  Created by Ryan Gong on 15/11/25.
//  Copyright © 2015年 Ryan Gong. All rights reserved.
//

#import "FGInboxViewController.h"
#import "Global.h"
#import "FGInboxTableViewCell.h"
#define DEFAULT_IMG_NEWS @"offers1.jpg"
@interface FGInboxViewController ()
{
    CGRect originalFrame_iv_topBanner;
    CGRect originalFrame_css_inboxFilter;
    NSMutableArray *arr_datas;
}
@end

@implementation FGInboxViewController
@synthesize css_inboxFilter;
@synthesize iv_topBanner;
@synthesize tb;
-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    if(self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])
    {
        [[NetworkManager sharedManager] postRequest_getNews:GetNewsType_All userinfo:nil];
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    self.view_topPanel.str_title = multiLanguage(@"Inbox");
    [self.iv_bg removeFromSuperview];
    self.iv_bg = nil;
    [self.view_contentView removeFromSuperview];
    self.view_contentView = nil;
    [self setOriginalFrame];
    
    tb.delegate = self;
    tb.dataSource = self;
    
    css_inboxFilter.delegate = self;
    [css_inboxFilter setupByTitles:@[multiLanguage(@"VIEW ALL"),multiLanguage(@"UN READ")] font:font(FONT_BOLD, 12) textColor:[UIColor whiteColor] lineColor:meihongColor lineHeight:8 spaceV:5];
    
    arr_datas = [NSMutableArray array];
}

-(void)setOriginalFrame
{
    originalFrame_css_inboxFilter = css_inboxFilter.frame;
    originalFrame_iv_topBanner = iv_topBanner.frame;
}

-(void)manullyFixSize
{
    [super manullyFixSize];
    css_inboxFilter.frame = [commond useDefaultRatioToScaleFrame:originalFrame_css_inboxFilter];
    iv_topBanner.frame = [commond useDefaultRatioToScaleFrame:originalFrame_iv_topBanner];
    CGRect _frame = tb.frame;
    _frame.size.width = W;
    _frame.origin.y = css_inboxFilter.frame.origin.y + css_inboxFilter.frame.size.height;
    _frame.size.height = H - _frame.origin.y;
    tb.frame = _frame;
}

-(void)bindDataToUI
{
    DataManager *dataManager = [DataManager sharedManager];
    NSMutableDictionary *_dic_datas = [dataManager getDataByUrl:HOST(URL_GetNews)];
    arr_datas = [_dic_datas objectForKey:@"List"];
    if(arr_datas)
    {
        [tb reloadData];
        [tb setNeedsDisplay];
    }
}


-(void)dealloc
{
    NSLog(@":::::>dealloc %s %d",__FUNCTION__,__LINE__);
}

#pragma mark - UITableViewDelegate
/*table cell高度*/
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath;
{
    return 220 * ratioH;
}


- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath;
{
    NSMutableDictionary *_dic_singleData = [arr_datas objectAtIndex:indexPath.row];
    int newsid = [[_dic_singleData objectForKey:@"NewsId"] intValue];
    FGControllerManager *manager = [FGControllerManager sharedManager];
    FGInboxDetailViewController *vc_inboxDetail = [[FGInboxDetailViewController alloc] initWithNibName:@"FGInboxDetailViewController" bundle:nil newsid:newsid];
    [manager pushController:vc_inboxDetail navigationController:nav_main];
    
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
    NSString *CellIdentifier = @"FGInboxTableViewCell";
    FGInboxTableViewCell *cell = (FGInboxTableViewCell *)[tableView dequeueReusableCellWithIdentifier:CellIdentifier];//从xib初始化tablecell
    if (cell == nil) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:CellIdentifier owner:self options:nil];
        cell = (FGInboxTableViewCell *)[nib objectAtIndex:0];
    }
    NSMutableDictionary *_dic_singleData = [arr_datas objectAtIndex:indexPath.row];
    NSString *_str_BigTitle = [_dic_singleData objectForKey:@"BigTitle"];
    NSString *_str_changeTime = [_dic_singleData objectForKey:@"ChangeTime"];
    NSString *_str_imgUrl = [_dic_singleData objectForKey:@"Img"];
    NSString *_str_smallTitle = [_dic_singleData objectForKey:@"SmallTitle"];
    BOOL newsFlag = [[_dic_singleData objectForKey:@"NewFlag"] boolValue];//NO 是读过  YES 是没读过
    
    cell.lb_title.text = _str_BigTitle;
    cell.lb_description.text = _str_smallTitle;
    [cell.iv_banner sd_setImageWithURL:[NSURL URLWithString:_str_imgUrl] placeholderImage:[UIImage imageNamed:DEFAULT_IMG_NEWS]];
    cell.lb_time.text = _str_changeTime;
    cell.iv_new.hidden = !newsFlag;
    return cell;
}

#pragma mark - FGCustomSegmentSelectViewDelegate
-(void)didSelectByIndex:(NSInteger)_index
{
    switch (_index) {
        case 0:
            [[NetworkManager sharedManager] postRequest_getNews:GetNewsType_All userinfo:nil];
            break;
            
        case 1:
            [[NetworkManager sharedManager] postRequest_getNews:GetNewsType_Unread userinfo:nil];
            break;
       
    }
}


#pragma mark - 网络事件通知
-(void)receivedDataFromNetwork:(NSNotification *)_notification
{
    [super receivedDataFromNetwork:_notification];
    NSMutableDictionary *_dic_requestInfo = _notification.object;
    NSString *_str_url = [_dic_requestInfo objectForKey:@"url"];
    
    if([HOST(URL_GetNews) isEqualToString:_str_url])
    {
        [self bindDataToUI];
    }
}
@end
