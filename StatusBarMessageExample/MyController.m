/*
 The MIT License (MIT)
 
 Copyright (c) 2013 Matt Wielbut
 
 Permission is hereby granted, free of charge, to any person obtaining a copy
 of this software and associated documentation files (the "Software"), to deal
 in the Software without restriction, including without limitation the rights
 to use, copy, modify, merge, publish, distribute, sublicense, and/or sell
 copies of the Software, and to permit persons to whom the Software is
 furnished to do so, subject to the following conditions:
 
 The above copyright notice and this permission notice shall be included in
 all copies or substantial portions of the Software.
 
 THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND, EXPRESS OR
 IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES OF MERCHANTABILITY,
 FITNESS FOR A PARTICULAR PURPOSE AND NONINFRINGEMENT. IN NO EVENT SHALL THE
 AUTHORS OR COPYRIGHT HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER
 LIABILITY, WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING FROM,
 OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR OTHER DEALINGS IN
 THE SOFTWARE.
 
 */

#import "MyController.h"

@interface MyController ()

@property (nonatomic) UIButton * button1;
@property (nonatomic) UIButton * button2;
@property (nonatomic) UIButton * button3;
@property (nonatomic) UIButton * button4;

@end

@implementation MyController


#pragma mark - Initialization

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
	
    UIImageView *backgroundView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"background"]];
    backgroundView.frame = self.view.bounds;
    backgroundView.autoresizingMask = UIViewAutoresizingFlexibleWidth | UIViewAutoresizingFlexibleHeight;
    backgroundView.contentMode = UIViewContentModeScaleAspectFill;
    [self.view addSubview:backgroundView];
    [self.view sendSubviewToBack:backgroundView];
    
   
    _button1 = [MyController generateButtonWithTitle:@"Show"];
    
    [_button1 addTarget:self action:@selector(show) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_button1];
    
    
    _button2 = [MyController generateButtonWithTitle:@"Hide"];
    
    [_button2 addTarget:self action:@selector(hide) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_button2];
    

    _button3 = [MyController generateButtonWithTitle:@"Toggle Animated"];
    
    [_button3 addTarget:self action:@selector(toggleAnimated) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_button3];
    
    
    _button4 = [MyController generateButtonWithTitle:@"Long Message"];
    
    [_button4 addTarget:self action:@selector(toggleLongMessage) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_button4];
    
}

#pragma mark - Layout (called each time the view is redrawn)

- (void)viewWillLayoutSubviews
{
    CGFloat buttonWidth = 142;
    CGFloat buttonHeight = 40;
    CGFloat buttonX = (self.view.bounds.size.width/2) - (buttonWidth/2);
    
    _button1.frame = CGRectMake(buttonX, 50, buttonWidth, buttonHeight);
    _button2.frame = CGRectMake(buttonX, 100, buttonWidth, buttonHeight);
    _button3.frame = CGRectMake(buttonX, 150, buttonWidth, buttonHeight);
    _button4.frame = CGRectMake(buttonX, 200, buttonWidth, buttonHeight);
}



#pragma mark - Button Actions

- (void)show
{
    [_statusBarController setStatusMessage:@"Simple Status"];
    [_statusBarController setVisibility:YES animated:NO];
}

- (void)hide
{
    [_statusBarController setVisibility:NO animated:NO];
}

- (void)toggleAnimated
{
    BOOL newVisibility = !_statusBarController.visiblity;
    [_statusBarController setVisibility:newVisibility withMessage:@"Animated Status" animated:YES];
}

- (void)toggleLongMessage
{
    BOOL newVisibility = !_statusBarController.visiblity;
    [_statusBarController setVisibility:newVisibility withMessage:@"I am too long to fit in this space and will get cut off" animated:YES];
}


#pragma mark - Private Methods

+ (UIButton *)generateButtonWithTitle:(NSString *)title
{
    UIImage *buttonImage = [[UIImage imageNamed:@"button"]
                            resizableImageWithCapInsets:UIEdgeInsetsMake(18, 18, 18, 18)];
    UIImage *buttonImageHighlight = [[UIImage imageNamed:@"buttonHighlight"]
                                     resizableImageWithCapInsets:UIEdgeInsetsMake(18, 18, 18, 18)];
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];

    [button setBackgroundImage:buttonImage forState:UIControlStateNormal];
    [button setBackgroundImage:buttonImageHighlight forState:UIControlStateHighlighted];
    
    [button setTitle:title forState:UIControlStateNormal];
    [button.titleLabel setFont:[UIFont fontWithName:@"Helvetica-Bold" size:13.0]];

    return button;
}

#pragma mark - Misc

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end
