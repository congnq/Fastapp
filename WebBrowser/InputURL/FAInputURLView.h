//
//  FAInputURLView.h
//  Web2App
//
//  Created by Cong Nguyen on 8/20/15.
//  Copyright (c) 2015 HUT. All rights reserved.
//

#import <UIKit/UIKit.h>



@interface FAInputURLView : UIView
@property (weak, nonatomic) IBOutlet UITextField *inputURLField;
@property (weak, nonatomic) IBOutlet UIButton *goButton;
@property (weak, nonatomic) IBOutlet UIButton *cancelButton;
@property (weak, nonatomic) IBOutlet UIView *backgroundView;
@property (weak, nonatomic) IBOutlet UILabel *errorLabel;
@property (nonatomic, copy) void (^goBlock)(id value);

@property (nonatomic, copy) void (^cancelBlock)();
@end
