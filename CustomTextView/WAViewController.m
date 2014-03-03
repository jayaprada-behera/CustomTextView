//
//  WAViewController.m
//  CustomTextView
//
//  Created by Jayaprada Behera on 25/02/14.
//  Copyright (c) 2014 Webileapps. All rights reserved.
//

#import "WAViewController.h"
#import <CoreText/CoreText.h>

#define FONT_SIZE    21.f
#define MINIMUM_FONT_SIZE  16.f

#define NSLineSeparatorCharacter           0x2028
@interface WAViewController ()<UITextViewDelegate>
{
    UITextView *textView_;
    float font;
}
@end

@implementation WAViewController
@synthesize textLbl;
- (void)viewDidLoad
{
    [super viewDidLoad];
    
    textView_ = [[UITextView alloc]initWithFrame:CGRectMake(20, 42, 200, 200)];
    textView_.delegate = self;
    textView_.autocorrectionType = UITextAutocorrectionTypeNo;
    textView_.font = [UIFont systemFontOfSize:FONT_SIZE];
    textView_.dataDetectorTypes = UIDataDetectorTypeAll;
    textView_.textContainer.maximumNumberOfLines = 9;
    textView_.backgroundColor = [UIColor greenColor];
    textView_.textContainer.lineBreakMode = NSLineBreakByWordWrapping;

    [self.view addSubview:textView_];
    
}

- (BOOL)textView:(UITextView *)textView shouldChangeTextInRange:(NSRange)range replacementText:(NSString *)text
{

    UITextPosition *beginning = textView.beginningOfDocument; //Error=: request for member 'beginningOfDocument' in something not a structure or union

    UITextPosition *start = [textView positionFromPosition:beginning offset:range.location];
    UITextPosition *end = [textView positionFromPosition:start offset:range.length];
    UITextRange *textRange = [textView textRangeFromPosition:start toPosition:end];
    
    CGPoint cursorPosition = [textView caretRectForPosition:textRange.start].origin;
    
    //    NSLog(@"x%f,y%f",cursorPosition.x,cursorPosition.y);
    
    if ([text isEqualToString:@""]) {
        //increase the font size  ,if deleting some text that come to certain posotion
        
        if (cursorPosition.x >170.f && cursorPosition.y > 100 && cursorPosition.y <160) {
            if (font < FONT_SIZE) {
                font = textView.font.pointSize +2;
                textView.font = [UIFont systemFontOfSize:font];
            }
        }
    }else{
        if (cursorPosition.x >170.f && cursorPosition.y > 150 ) {//at most end point of last line
            //decrease the font size  ,if deleting some text that come to certain posotion
            if (font < FONT_SIZE) {
                if (font < MINIMUM_FONT_SIZE && font >  0) {
                    return NO;
                }
                font = textView.font.pointSize - 2;
                textView.font = [UIFont systemFontOfSize:font];
            }
        }
    }
    return YES ;
    
}
-(IBAction)clearText:(id)sender{
    textView_.font = [UIFont systemFontOfSize:FONT_SIZE];
    textView_.text = @"";
}
- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
