//
//  FAInputURLView.m
//  Web2App
//
//  Created by Cong Nguyen on 8/20/15.
//  Copyright (c) 2015 HUT. All rights reserved.
//

#import "FAInputURLView.h"
#import <QuartzCore/QuartzCore.h>
 #define kHeight  [UIScreen mainScreen].bounds.size.height
 #define kWidth  [UIScreen mainScreen].bounds.size.width
@interface FAInputURLView () <UITextFieldDelegate>
@end

@implementation FAInputURLView

-(void) awakeFromNib {
    self.inputURLField.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.inputURLField.layer.borderWidth = 0.5f;
    self.goButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.cancelButton.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.goButton.layer.borderWidth = 0.5f;
    self.cancelButton.layer.borderWidth = 0.5f;
    
    [self.inputURLField becomeFirstResponder];
    CGRect frame= self.frame;
    
    frame.size.height = kHeight;
    frame.size.width = kWidth;
    
    self.frame = frame;
    self.backgroundView.frame = frame;
    
}




- (IBAction)goClicked:(id)sender {
    if (self.goBlock) {
        self.goBlock(self.inputURLField.text);
    }
}
- (IBAction)cancelClicked:(id)sender {
    if (self.cancelBlock) {
        self.cancelBlock();
    }
}

@end
