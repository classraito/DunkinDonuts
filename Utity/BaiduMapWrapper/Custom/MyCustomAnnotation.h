//
//  MyCustomAnnotation.h
//  DunkinDonuts
//
//  Created by Ryan Gong on 15/12/1.
//  Copyright © 2015年 Ryan Gong. All rights reserved.
//

#import <BaiduMapAPI_Map/BMKMapComponent.h>//引入地图功能所有的头文件

@interface MyCustomAnnotation : BMKPointAnnotation
{
    
}
@property(nonatomic,assign)NSMutableDictionary *dic_annotationInfo;
@end
