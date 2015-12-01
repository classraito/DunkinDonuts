//
//  FGCustomTextFieldView.h
//  DunkinDonuts
//
//  Created by Ryan Gong on 15/11/19.
//  Copyright © 2015年 Ryan Gong. All rights reserved.
//

#import "FGCustomizableBaseView.h"
@protocol FGCustomTextFieldViewDelegate
-(void)didBeginEditing:(UITextField *)_tf;
-(void)didClickDoneOnTextField:(UITextField *)_tf;
@end

@interface FGCustomTextFieldView : FGCustomizableBaseView<UITextFieldDelegate>
{
    
}
@property(nonatomic,assign)IBOutlet UITextField *tf;
@property(nonatomic,assign)id<FGCustomTextFieldViewDelegate>delegate;
@property  NSInteger maxInputLength;
@property  NSInteger minInputLength;
@end
