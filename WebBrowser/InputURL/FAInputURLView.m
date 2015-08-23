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
    

    CGRect frame= self.frame;
    self.errorLabel.alpha = 0;
    frame.size.height = kHeight;
    frame.size.width = kWidth;
    
    self.frame = frame;
    self.backgroundView.frame = frame;
    if (self.window != nil) {
        [self.inputURLField becomeFirstResponder];
    }
}

-(BOOL) validateURL {


    BOOL correct = [self validateUrlWithString:self.inputURLField.text];
    if (!correct) {
        [self displayError];
    } else {
        correct = YES;
        if (![self.inputURLField.text containsString:@"http://"] ||
            ![self.inputURLField.text containsString:@"http://"]) {
            self.inputURLField.text = [NSString stringWithFormat:@"http://%@",self.inputURLField.text];
        }
        
    }
    
    return correct;

}

- (BOOL)validateUrlWithString:(NSString *)candidate {
    NSString *urlRegEx = @"^(http(s)?://)?((www)?\\.)?[\\w]+\\.[\\w]+";

    NSPredicate *urlTest = [NSPredicate predicateWithFormat:@"SELF MATCHES %@", urlRegEx];
    return [urlTest evaluateWithObject:candidate];
}


-(void) displayError {
    [UIView animateWithDuration:0.75 delay:0.0 options:nil
                     animations:^{
                         
                         self.errorLabel.alpha = 1;
                     }
                     completion:^(BOOL finish)
     {
     }
     ];
}



- (IBAction)goClicked:(id)sender {
    if ([self validateURL]) {
        if (self.goBlock) {
            self.goBlock(self.inputURLField.text);
        }
    }
    
}
- (IBAction)cancelClicked:(id)sender {
    if (self.cancelBlock) {
        self.cancelBlock();
    }
}

@end
