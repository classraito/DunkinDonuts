
//  FGBaseViewController.m
//  DunkinDonuts
//
//  Created by Ryan Gong on 15/11/10.
//  Copyright © 2015年 Ryan Gong. All rights reserved.
//

#import "FGBaseViewController.h"
#import "Global.h"
#define DEFAULT_KEYBOARDHEIGHT_IPHONE5 253
#define DEFAULT_KEYBOARDHEIGHT_IPHONE6 258
#define DEFAULT_KEYBOARDHEIGHT_IPHONE6PLUS 271
@interface FGBaseViewController ()
{
    
}
@end

@implementation FGBaseViewController
@synthesize view_topPanel;
@synthesize view_contentView;
@synthesize iv_bg;
- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
        W = getScreenSize().width;
        H = getScreenSize().height;
        ratioW = W / 320.0f;
        ratioH = H / 568.0f;
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillShow:) name:UIKeyboardWillShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardDidShow:) name:UIKeyboardDidShowNotification object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
        
        //注册网络请求通知事件
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(receivedDataFromNetwork:) name:Notification_UpdateData object:nil];
        [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(requestFailedFromNetwork:) name:Notification_UpdateFailed object:nil];
        NSLog(@"(%f,%f)",W,H);
        isViewDidLayoutSubviewsShouldBeCall = YES;//默认是YES,当设为NO时 视图的位置发生变化时父类不会在-(void)viewDidLayoutSubviews中调用manullyFixSize 而是在-(void)viewWillAppear:(BOOL)animated中调用

    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
   
    /*
     在首页的最上方放置一个 scrollview（包括状态栏）。当程序运行，显示界面的时候，scrollview 会向下偏移20个像素。
     这是由于iOS7的UIViewController有个新特性
     @property(nonatomic,assign) BOOL automaticallyAdjustsScrollViewInsets NS_AVAILABLE_IOS(7_0); // Defaults to YES
     scrollview会自动偏移,要手动关掉
     */
    self.automaticallyAdjustsScrollViewInsets = NO;
    iv_bg = [[UIImageView alloc] init];
    [self.view addSubview:iv_bg];
    [self.view sendSubviewToBack:iv_bg];
    
    //初始化导航栏
    view_topPanel = (FGTopPanelView *)[[[NSBundle mainBundle] loadNibNamed:@"FGTopPanelView" owner:nil options:nil] objectAtIndex:0];
    [self.view addSubview:view_topPanel];
    [self.view bringSubviewToFront:view_topPanel];
    
    
    //注册导航栏按钮事件
    [view_topPanel.btn_back addTarget:self action:@selector(buttonAction_back:) forControlEvents:UIControlEventTouchUpInside];
    [view_topPanel.btn_settings addTarget:self action:@selector(buttonAction_settings:) forControlEvents:UIControlEventTouchUpInside];
    view_contentView.backgroundColor = [UIColor clearColor];

    currentKeyboardHeight = [self normalKeyboardHeight];
    
    
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    if(!isViewDidLayoutSubviewsShouldBeCall)
        [self manullyFixSize];
}

/*autolayout 会在viewWillAppear和viewDidAppear之间的那段时间为你分析约束、设置frame,所以不能在这两个方法中操作frame,因为你会在这viewDidAppear中得到不同结果，而且我发现他们会被调用多次
 而需要在viewDidLayoutSubviews中操作，因为这个方法是在autolayout布局完成之后执行
 在iOS5.0以后就有这个生命周期函数ViewDidLayoutSubViews这个方法基本可以代替ViewDidload使用，只不过差别在于前者是约束(autolayout)后，后者是约束前*/
-(void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    NSLog(@":::::>%s %d",__FUNCTION__,__LINE__);

    if(isViewDidLayoutSubviewsShouldBeCall)
    {
        //    [self.view layoutSubviews];//IOS7中必须用这个方法
        [self manullyFixSize];
    }
    
}

/*所有屏幕适配代码在子类的这个手工适配方法中实现*/
-(void)manullyFixSize
{
    NSLog(@":::::>%s %d",__FUNCTION__,__LINE__);
    view_topPanel.frame = CGRectMake(0, LAYOUT_STATUSBAR_HEIGHT, W, LAYOUT_TOPVIEW_HEIGHT);
    view_contentView.frame = CGRectMake(0, view_topPanel.frame.origin.y + view_topPanel.frame.size.height,
                                        W, H-view_topPanel.frame.origin.y-view_topPanel.frame.size.height - LAYOUT_BOTTOMVIEW_HEIGHT);
    iv_bg.frame = self.view.frame;
}

//返回按钮
-(void)buttonAction_back:(id)_sender;
{
    [nav_main popViewControllerAnimated:YES];
}

//设置按钮
-(void)buttonAction_settings:(id)_sender;
{
   
}

-(void)dealloc
{
    NSLog(@":::::>dealloc %s %d",__FUNCTION__,__LINE__);
    view_contentView = nil;
    view_topPanel = nil;
    iv_bg = nil;
}

-(void)go2HomeScreen
{
    FGControllerManager *manager = [FGControllerManager sharedManager];
    [manager pushControllerByName:@"FGHomePageViewController" inNavigation:nav_main];
}


#pragma mark - 网络通知
/*获得任何网络数据时会通知此方法 以便基类将数据分发给子类的updateData方法*/
-(void)receivedDataFromNetwork:(NSNotification *)_notification
{
    NSLog(@":::::>%s %d obj = %@",__FUNCTION__,__LINE__,_notification.object);
   
}

/*请求网络失败后的通知*/
-(void)requestFailedFromNetwork:(NSNotification *)_notification
{
   NSLog(@"::::::>%s  %d requestFailedFromNetwork obj = %@",__FUNCTION__,__LINE__,_notification.object);
    NSDictionary *_dic = _notification.object;

    NSString *_codeMsg = [[_dic objectForKey:@"result"] objectForKey:@"CodeMsg"];
    [self alert:multiLanguage(@"warnning") message:_codeMsg callback:nil];
    
}


#pragma mark - 控制keyboard展现后的行为
-(CGFloat)normalKeyboardHeight
{
    if(H<=568)
    {
        return DEFAULT_KEYBOARDHEIGHT_IPHONE5;
    }
    else if(H<=667)
    {
        return DEFAULT_KEYBOARDHEIGHT_IPHONE6;
    }
    else if(H<=960)
    {
        return DEFAULT_KEYBOARDHEIGHT_IPHONE6PLUS;
    }
    return DEFAULT_KEYBOARDHEIGHT_IPHONE5;
}

-(void)viewMoveUp:(CGFloat)_height
{
    if(!isNeedViewMoveUpWhenKeyboardShow)
        return;
    if(self.view.frame.origin.y<0)
        return;
    [UIView beginAnimations:nil context:nil];
    CGRect _frame = self.view.frame;
    _frame.origin.y = -_height;
    self.view.frame = _frame;
    [UIView commitAnimations];
    [[UIApplication sharedApplication] setStatusBarHidden:YES];
}

-(void)viewMoveDown
{
    if(!isNeedViewMoveUpWhenKeyboardShow)
        return;
    if(self.view.frame.origin.y>=0)
        return;
    [UIView beginAnimations:nil context:nil];
    CGRect _frame = self.view.frame;
    _frame.origin.y = 0;
    self.view.frame = _frame;
    [UIView commitAnimations];
    [[UIApplication sharedApplication] setStatusBarHidden:NO];
}

- (void)keyboardWillShow:(NSNotification *)notification
{
   NSLog(@":::::>%s %d",__FUNCTION__,__LINE__);
    NSDictionary *info = [notification userInfo];
    CGSize kbSize = [[info objectForKey:UIKeyboardFrameEndUserInfoKey] CGRectValue].size;
    currentKeyboardHeight = kbSize.height;
    
    if(currentKeyboardHeight < [self normalKeyboardHeight])
    {
        currentKeyboardHeight = [self normalKeyboardHeight];
    }
    
    [self viewMoveUp:heightNeedMoveWhenKeybaordShow];
}

-(void)keyboardDidShow:(NSNotification *)notification
{
    NSLog(@":::::>%s %d",__FUNCTION__,__LINE__);
    [self keyboardWillShow:notification];
}

-(void)keyboardWillHide:(NSNotification *)notification
{
    [self viewMoveDown];
}

#pragma mark - alert
-(BOOL)isTAlertAlreadyShowedInWindow
{
    UIWindow * window = (UIWindow *) [appDelegate performSelector:@selector(window)];
    for(UIView *_subview in window.subviews)
    {
        if([_subview isKindOfClass:[TAlertView class]])
        {
            return YES;
        }
    }
    return NO;
}

-(void)alert:(NSString *)_str_title message:(NSString *)_str_message callback:(void (^)(TAlertView *alertView, NSInteger buttonIndex))callBackBlock
{
    if([self isTAlertAlreadyShowedInWindow])
        return;
    NSArray * buttons = @[multiLanguage(@"OK")];
    TAlertView *alert = [[TAlertView alloc] initWithTitle:_str_title
                                                  message:_str_message
                                                  buttons:buttons
                                              andCallBack:callBackBlock];
    alert.messageColor = orangeColor;
    alert.buttonsTextColor = orangeColor;
    alert.titleFont = font(FONT_BOLD, 16);
    alert.messageFont = font(FONT_NORMAL, 16);
    alert.buttonsFont =  font(FONT_BOLD, 16);
    [alert show];
}
@end
