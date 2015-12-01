//
//  FGBaseViewController.h
//  DunkinDonuts
//
//  Created by Ryan Gong on 15/11/10.
//  Copyright © 2015年 Ryan Gong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "FGTopPanelView.h"
#import "TAlertView.h"

@interface FGBaseViewController : UIViewController
{
    CGFloat currentKeyboardHeight;
    BOOL isViewDidLayoutSubviewsShouldBeCall;//默认是YES,当设为NO时 视图的位置发生变化时父类不会在-(void)viewDidLayoutSubviews中调用manullyFixSize 而是在-(void)viewWillAppear:(BOOL)animated中调用
}
@property(nonatomic,assign)FGTopPanelView *view_topPanel;
@property(nonatomic,assign)IBOutlet UIView *view_contentView;
@property(nonatomic,strong)UIImageView *iv_bg;
-(void)manullyFixSize;
-(CGFloat)normalKeyboardHeight;
/*获得任何网络数据时会通知此方法 以便基类将数据分发给子类的updateData方法*/
-(void)receivedDataFromNetwork:(NSNotification *)_notification;
/*请求网络失败后的通知*/
-(void)requestFailedFromNetwork:(NSNotification *)_notification;
-(void)viewMoveUp:(CGFloat)_height;
-(void)alert:(NSString *)_str_title message:(NSString *)_str_message callback:(void (^)(TAlertView *alertView, NSInteger buttonIndex))callBackBlock;
-(void)go2HomeScreen;
-(BOOL)isTAlertAlreadyShowedInWindow;
-(void)buttonAction_back:(id)_sender;
-(void)buttonAction_settings:(id)_sender;
@end
