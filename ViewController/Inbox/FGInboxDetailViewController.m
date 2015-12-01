//
//  FGInboxDetailViewController.m
//  DunkinDonuts
//
//  Created by Ryan Gong on 15/11/26.
//  Copyright © 2015年 Ryan Gong. All rights reserved.
//
#define DEFAULT_IMG_NEWSDETAIL @"offers1a.jpg"

#import "FGInboxDetailViewController.h"
#import "Global.h"
@interface FGInboxDetailViewController ()
{
    CGRect originalFrame_iv_good;
    CGRect originalFrame_iv_share;
    CGRect originalFrame_iv_topBanner;
    CGRect originalFrame_lb_counter;
    CGRect originalFrame_btn_good;
    CGRect originalFrame_btn_share;
    CGRect originalFrame_view_separator;
    CGRect originalFrame_tv;
    
    int newsID;
    BOOL loveFlag;
}
@end

@implementation FGInboxDetailViewController
@synthesize iv_good;
@synthesize iv_share;
@synthesize iv_topBanner;
@synthesize lb_counter;
@synthesize btn_good;
@synthesize btn_share;
@synthesize view_separator;
@synthesize tv;
-(id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil newsid:(int)_newsid
{
    if([super initWithNibName:nibNameOrNil bundle:nibBundleOrNil])
    {
        newsID = _newsid;
        [[NetworkManager sharedManager] postRequest_getNewsInfo:_newsid userinfo:nil];
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
    lb_counter.font = font(FONT_BOLD, 10);
    tv.font = font(FONT_NORMAL, 14);
    view_separator.backgroundColor = meihongColor;
    
}

-(void)manullyFixSize
{
    [super manullyFixSize];
    
    btn_good.frame = [commond useDefaultRatioToScaleFrame:originalFrame_btn_good];
    btn_share.frame = [commond useDefaultRatioToScaleFrame:originalFrame_btn_share];
    iv_good.frame = [commond useDefaultRatioToScaleFrame:originalFrame_iv_good];
    iv_share.frame = [commond useDefaultRatioToScaleFrame:originalFrame_iv_share];
    iv_topBanner.frame = [commond useDefaultRatioToScaleFrame:originalFrame_iv_topBanner];
    lb_counter.frame = [commond useDefaultRatioToScaleFrame:originalFrame_lb_counter];
    tv.frame = [commond useDefaultRatioToScaleFrame:originalFrame_tv];
    view_separator.frame = [commond useDefaultRatioToScaleFrame:originalFrame_view_separator];
}

-(void)setOriginalFrame
{
    originalFrame_btn_good = btn_good.frame;
    originalFrame_btn_share = btn_share.frame;
    originalFrame_iv_good = iv_good.frame;
    originalFrame_iv_share = iv_share.frame;
    originalFrame_iv_topBanner = iv_topBanner.frame;
    originalFrame_lb_counter = lb_counter.frame;
    originalFrame_tv = tv.frame;
    originalFrame_view_separator = view_separator.frame;
}

-(void)dealloc
{
    NSLog(@":::::>dealloc %s %d",__FUNCTION__,__LINE__);
}

#pragma mark - buttonAction
-(IBAction)buttonAction_good:(id)_sender
{
    loveFlag = loveFlag ? NO : YES;
    iv_good.highlighted = loveFlag;
    int lovecount = [lb_counter.text intValue];
    if(loveFlag)
        lovecount += 1;
    else
    {
        lovecount = lovecount >0 ? lovecount - 1 : 0;
    }
    lb_counter.text = [NSString stringWithFormat:@"%d",lovecount];
    NSString *str_newsid = [NSString stringWithFormat:@"%d",newsID];
    [[NetworkManager sharedManager] postRequest_submitLove:LoveFavoriteType_News loveId:str_newsid loveflag:loveFlag userinfo:nil];

}

-(IBAction)buttonAction_share:(id)_sender
{
    
}

-(void)bindDataToUI
{
    DataManager *dataManager = [DataManager sharedManager];
    NSMutableDictionary *_dic_datas = [dataManager getDataByUrl:HOST(URL_GetNewsInfo)];
    NSMutableDictionary *_dic_singleData = [[_dic_datas objectForKey:@"List"] firstObject];
    NSString *_str_smallTitle = [_dic_singleData objectForKey:@"SmallTitle"];
    NSString *_str_ChangeTime = [_dic_singleData objectForKey:@"ChangeTime"];
    NSString *_str_BigTitle = [_dic_singleData objectForKey:@"BigTitle"];
    NSString *_str_Describe = [_dic_singleData objectForKey:@"Describe"];
    NSString *_str_imgUrl = [_dic_singleData objectForKey:@"Img"];
    int loveCount = [[_dic_singleData objectForKey:@"LoveCount"] intValue];
    loveFlag = [[_dic_singleData objectForKey:@"LoveFlag"] boolValue];
    lb_counter.text = [NSString stringWithFormat:@"%d",loveCount];
    iv_good.highlighted = loveFlag;
    tv.text = _str_Describe;
    
    [iv_topBanner sd_setImageWithURL:[NSURL URLWithString:_str_imgUrl] placeholderImage:[UIImage imageNamed:DEFAULT_IMG_NEWSDETAIL]];
    
}

#pragma mark - 网络事件通知
-(void)receivedDataFromNetwork:(NSNotification *)_notification
{
    [super receivedDataFromNetwork:_notification];
    NSMutableDictionary *_dic_requestInfo = _notification.object;
    NSString *_str_url = [_dic_requestInfo objectForKey:@"url"];
    
    if([HOST(URL_GetNewsInfo) isEqualToString:_str_url])
    {
        [self bindDataToUI];
    }
}


@end
