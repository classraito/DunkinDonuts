//
//  FGAgreementPanelView.m
//  DunkinDonuts
//
//  Created by Ryan Gong on 15/11/17.
//  Copyright © 2015年 Ryan Gong. All rights reserved.
//

#import "FGAgreementPanelView.h"
#import "Global.h"
@interface FGAgreementPanelView()
{
    NSArray *arr_links;
}
@end

@implementation FGAgreementPanelView
@synthesize tv_agreement;
-(void)awakeFromNib
{
    [super awakeFromNib];
}

-(void)layoutSubviews
{
    [super layoutSubviews];
    tv_agreement.frame = self.bounds;
}

-(void)setupByString:(NSString *)_str_formatted linkStr:(NSArray *)_arr_linkStr
{
    NSLog(@"_str_formatted = %@",_str_formatted);
    arr_links = _arr_linkStr;
    NSMutableAttributedString *attributedString = [[NSMutableAttributedString alloc] initWithString:_str_formatted];
    NSLog(@"[attributedString string] = %@",[attributedString string]);
    for(NSString *_str_link in _arr_linkStr)
    {
        NSLog(@"_str_link = %@",_str_link);
        [attributedString addAttribute:NSLinkAttributeName
                                 value:[NSString stringWithFormat:@"agreement://%@",_str_link]
                                 range:[[attributedString string] rangeOfString:_str_link]];
    }
    NSMutableParagraphStyle *paragraphStyle = [[NSMutableParagraphStyle alloc] init];
    [paragraphStyle setLineSpacing:4];//调整行间距
    paragraphStyle.alignment = NSTextAlignmentCenter;
    [attributedString addAttribute:NSParagraphStyleAttributeName value:paragraphStyle range:NSMakeRange(0, _str_formatted.length)];
    NSDictionary *linkAttributes = @{NSForegroundColorAttributeName: rgb(195, 134, 156)};
    // assume that textView is a UITextView previously created (either by code or Interface Builder)
    tv_agreement.linkTextAttributes = linkAttributes; // customizes the appearance of links
    tv_agreement.attributedText = attributedString;
    tv_agreement.delegate = self;
}

- (BOOL)textView:(UITextView *)textView shouldInteractWithURL:(NSURL *)URL inRange:(NSRange)characterRange {
    NSLog(@"[URL scheme] = %@",[URL scheme]);
    if ([[URL scheme] isEqualToString:[arr_links objectAtIndex:0]]) {
        NSString *username = [URL host];
        NSLog(@"username = %@",username);
        // do something with this username
        // ...
        return NO;
    }
    if ([[URL scheme] isEqualToString:[arr_links objectAtIndex:1]]) {
        NSString *username = [URL host];
        NSLog(@"username = %@",username);
        // do something with this username
        // ...
        return NO;
    }
    return YES; // let the system open this URL
}

-(void)dealloc
{
    NSLog(@":::::>dealloc %s %d",__FUNCTION__,__LINE__);
}

@end
