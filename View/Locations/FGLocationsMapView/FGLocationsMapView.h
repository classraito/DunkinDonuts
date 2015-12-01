//
//  FGLocationsMapView.h
//  DunkinDonuts
//
//  Created by Ryan Gong on 15/12/1.
//  Copyright © 2015年 Ryan Gong. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BaiduMapWrapperView.h"
@interface FGLocationsMapView : UIView
{
    
}
@property(nonatomic,strong) BaiduMapWrapperView *view_baiduMapWrapper;
-(void)bindDataToUI;
@end
