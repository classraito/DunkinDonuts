//
//  Font.h
//  MyStock
//
//  Created by Ryan Gong on 15/9/11.
//  Copyright (c) 2015年 Ryan Gong. All rights reserved.
//

#define FONT_NORMAL @"SourceHanSansCN-Light"
#define FONT_BOLD @"SourceHanSansCN-Bold"
#define FONT_BUTTON @"SourceHanSansCN-Heavy"
//#define FONT_BUTTON @"SourceHanSansCN-Bold"
#define FONT_NUMERIC @"DINOT-Medium"


#define font(fontname,fSize)        [UIFont fontWithName:fontname size:fSize]    //fSize是磅值(pt) 像素磅值转换公式:px=pt*dpi/72   pt=px*72/dpi 美工如果给的是px(像素) 那么他必须给dpi 不然无法推算出 pt
