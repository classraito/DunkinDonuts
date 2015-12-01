//
//  MyAnimatedAnnotationView.h
//  IphoneMapSdkDemo
//
//  Created by wzy on 14-11-27.
//  Copyright (c) 2014年 Baidu. All rights reserved.
//

#import <BaiduMapAPI_Map/BMKMapComponent.h>

@interface MyCustomAnnotationView : BMKPinAnnotationView
{
    
}
@property (nonatomic, strong) UIImageView *annotationImageView;
-(void)setAnnotaionViewByImage:(UIImage *)_img highlightedImg:(UIImage *)_highlightedImg;
@end
