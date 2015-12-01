//
//  MyAnimatedAnnotationView.m
//  IphoneMapSdkDemo
//
//  Created by wzy on 14-11-27.
//  Copyright (c) 2014年 Baidu. All rights reserved.
//

#import "MyCustomAnnotationView.h"

@implementation MyCustomAnnotationView
@synthesize annotationImageView;
- (id)initWithAnnotation:(id<BMKAnnotation>)annotation reuseIdentifier:(NSString *)reuseIdentifier {
    self = [super initWithAnnotation:annotation reuseIdentifier:reuseIdentifier];
    if (self) {
        annotationImageView = [[UIImageView alloc] initWithFrame:self.bounds];
        annotationImageView.contentMode = UIViewContentModeScaleAspectFit;
        annotationImageView.userInteractionEnabled = YES;
        [self addSubview:annotationImageView];
    }
    return self;
}

-(void)setAnnotaionViewByImage:(UIImage *)_img highlightedImg:(UIImage *)_highlightedImg
{
    annotationImageView.image = _img;
    annotationImageView.highlightedImage = _highlightedImg;
    self.bounds = CGRectMake(0, 0, _img.size.width/3, _img.size.height/3);
    annotationImageView.bounds = self.bounds;
    annotationImageView.center = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
    annotationImageView.layer.shadowColor = [UIColor blackColor].CGColor;
    annotationImageView.layer.shadowOffset = CGSizeMake(-1, -1);
    annotationImageView.layer.shadowRadius = 2;
    annotationImageView.layer.shadowOpacity = 1;
}

-(void)dealloc
{
    annotationImageView = nil;
    NSLog(@":::::>dealloc %s %d",__FUNCTION__,__LINE__);
}
@end
