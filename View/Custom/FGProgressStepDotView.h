//
//  FGProgressStepDotView.h
//  DunkinDonuts
//
//  Created by Ryan Gong on 15/11/19.
//  Copyright © 2015年 Ryan Gong. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface FGProgressStepDotView : UIView
{
    
}
@property(nonatomic,assign)IBOutlet UIButton *btn1;
@property(nonatomic,assign)IBOutlet UIButton *btn2;
@property(nonatomic,assign)IBOutlet UIButton *btn3;
@property(nonatomic,assign)IBOutlet UILabel *lb1;
@property(nonatomic,assign)IBOutlet UILabel *lb2;
@property(nonatomic,assign)IBOutlet UILabel *lb3;
-(void)highlightedByIndex:(NSInteger)_index;
@end
