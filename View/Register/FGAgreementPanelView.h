//
//  FGAgreementPanelView.h
//  DunkinDonuts
//
//  Created by Ryan Gong on 15/11/17.
//  Copyright © 2015年 Ryan Gong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FGAgreementPanelView : UIView<UITextViewDelegate>
{
    
}
@property(nonatomic,assign)IBOutlet UITextView *tv_agreement;
-(void)setupByString:(NSString *)_str_formatted linkStr:(NSArray *)_arr_linkStr;
@end
