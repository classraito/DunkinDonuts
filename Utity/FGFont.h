//
//  FGFont.h
//  Reebok
//
//  Created by rui.gong on 11-3-8.
//  Copyright 2011 fugumobile. All rights reserved.
//
//@作者:龚瑞 rui.gong
//@版本 V2011_0308
#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>

@interface FGFont : UIView {
	
}
/**
 返回一个测试用的字体显示视图
 _screenType:
 UIInterfaceOrientationLandscapeLeft,UIInterfaceOrientationPortrait等等
 */
+(FGFont *)sharedFontView:(int)_screenType;
/**从bundle中读取TTF格式的字体文件加入到本地字体库中 IOS 3.2以后支持*/
+(void)loadMyFonts;
/*内部实现了打印所有支持的字体到终端上，返回一个支持的字体的数组,内容时NSString类型的*/
+(NSMutableArray *)showSupportedFont;
@end
