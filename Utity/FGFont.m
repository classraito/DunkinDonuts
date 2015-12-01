//
//  FGFont.m
//  Reebok
//
//  Created by rui.gong on 11-3-8.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "FGFont.h"
#import <dlfcn.h>
#ifndef CurrentVersionNewThan
	#define CurrentVersionNewThan(a) ([[[UIDevice currentDevice]systemVersion]floatValue]>=a?YES:NO)
#endif
@implementation FGFont
static FGFont *view_font;
static UIScrollView *sv_font;
static UILabel *lb_fontsize;
+(FGFont *)sharedFontView:(int)_screenType
{
	@synchronized(self)     {
		if(!view_font)
		{
			if(_screenType==UIInterfaceOrientationLandscapeLeft||_screenType==UIInterfaceOrientationLandscapeRight)
				view_font=[[FGFont alloc]initWithFrame:CGRectMake(0, 0, 480, 320)];
			if(_screenType==UIInterfaceOrientationPortrait||_screenType==UIInterfaceOrientationPortraitUpsideDown)
				view_font=[[FGFont alloc]initWithFrame:CGRectMake(0, 0, 320, 480)];
			
			if(CurrentVersionNewThan(3.2))
				[FGFont loadMyFonts];
			UISlider *slider=[[UISlider alloc]initWithFrame:CGRectMake(view_font.frame.size.width/2-250/2, view_font.frame.size.height-40, 250, 30)];
			[slider addTarget:view_font action:@selector(sizeChangeAction:) forControlEvents:UIControlEventValueChanged];
			slider.value=0.16;
			lb_fontsize=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, 40, 40)];
			lb_fontsize.center=CGPointMake(20, slider.center.y);
			lb_fontsize.textColor=[UIColor redColor];
			lb_fontsize.backgroundColor=[UIColor clearColor];
			CGRect _frame=view_font.frame;
			_frame.size.height=view_font.frame.size.height-50;
			sv_font=[[UIScrollView alloc]initWithFrame:_frame];
			NSArray *arr_fontname=[FGFont showSupportedFont];
			float nextHeight;
			float maxWidth=0;
			for(NSString *str_fontname in arr_fontname)
			{
				UIFont *font=[UIFont fontWithName:str_fontname size:slider.value*100];
				lb_fontsize.text=[NSString stringWithFormat:@"%1.0f",slider.value*100];
				CGSize _size=[str_fontname sizeWithFont:font];
				if(_size.width>maxWidth)
					maxWidth=_size.width;
				UILabel *lb=[[UILabel alloc]initWithFrame:CGRectMake(0, nextHeight, _size.width, _size.height)];
				lb.backgroundColor=[UIColor clearColor];
				lb.textColor=[UIColor whiteColor];
				lb.font=font;
				nextHeight+=lb.frame.size.height+5;
				lb.text=str_fontname;
				[sv_font addSubview:lb];
				[lb release];
			}
			sv_font.contentSize=CGSizeMake(maxWidth, nextHeight);
			[view_font addSubview:sv_font];
			[view_font addSubview:slider];
			[view_font addSubview:lb_fontsize];
			view_font.backgroundColor=[UIColor blackColor];
			[sv_font release];
			[slider release];
			[lb_fontsize release];
		}
	}
	return view_font;
}

-(void)sizeChangeAction:(UISlider *)_slider
{
	if(_slider.value>=0.01)
	{
		float nextHeight=0;
		float maxWidth=0;
		for (UIView *_view in [sv_font subviews]) {
			NSAutoreleasePool *pool=[[NSAutoreleasePool alloc]init];
			if([_view isKindOfClass:[UILabel class]])
			{
				UILabel *_lb=(UILabel *)_view;
				UIFont *font=[UIFont fontWithName:_lb.font.fontName size:_slider.value*100];
				lb_fontsize.text=[NSString stringWithFormat:@"%1.0f",_slider.value*100];
				CGSize _size=[_lb.font.fontName sizeWithFont:font];
				if(_size.width>maxWidth)
					maxWidth=_size.width;
				_lb.frame=CGRectMake(0, 0+nextHeight, _size.width, _size.height);
				_lb.font=font;
				nextHeight+=_lb.frame.size.height+5;
			}
			[pool release];
		}
		sv_font.contentSize=CGSizeMake(maxWidth, nextHeight);
	}
}


+(id)alloc
{
	@synchronized(self)     {
		NSAssert(view_font == nil, @"企圖創singleton模式下的第二个对象");
		return [super alloc];
	}
	return nil;
}

+(void)loadMyFonts
{
		NSString* frameworkName = @"com.apple.GraphicsServices";
		NSBundle* frameworkBundle = [NSBundle bundleWithIdentifier:frameworkName];
		if (frameworkBundle)
		{
			const char* frameworkPath = [[frameworkBundle executablePath] UTF8String];
			if (frameworkPath)
			{
				void* graphicsServices = dlopen(frameworkPath, RTLD_NOLOAD | RTLD_LAZY);
				if (graphicsServices)
				{
					BOOL (*GSFontAddFromFile)(const char*) = dlsym(graphicsServices,
															   "GSFontAddFromFile");
					if (GSFontAddFromFile)
					{
						NSArray* files = [[NSBundle mainBundle] pathsForResourcesOfType:@"TTF"
																		inDirectory:nil];
                        
						for (NSString* fontFile in files)
						{
							GSFontAddFromFile([fontFile UTF8String]);
						}
					
					}
				}
			}
		}
}


+(NSMutableArray *)showSupportedFont
{
	int index=0;
	NSMutableArray *arr_supportedFonts=[[NSMutableArray alloc]init];
	NSArray *familyNames =	[UIFont familyNames];
	for(int i=0;i<[familyNames count];i++)
	{
		NSString *familyName=[familyNames objectAtIndex:i];
		NSArray *fontNames=[UIFont fontNamesForFamilyName:familyName];
		for(int i=0;i<[fontNames count];i++)
		{
			NSString *fontName=[fontNames objectAtIndex:i];
			[arr_supportedFonts addObject:fontName];
			NSLog(@"%d,fontName:%@ family:%@",index,fontName,familyName);
			index++;
		}
	}
	return [arr_supportedFonts autorelease];
}

-(void)dealloc
{
	[[view_font subviews] makeObjectsPerformSelector:@selector(removeFromSuperView)];
	[super dealloc];
}
@end
