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
@property (nonatomic) UIButton * overlaySwitch;

@property (nonatomic) UILabel * label1;
@property (nonatomic) UILabel * label2;


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
    
    [_button1 addTarget:self action:@selector(show:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_button1];
    
    
    
    _button2 = [MyController generateButtonWithTitle:@"Hide"];
    
    [_button2 addTarget:self action:@selector(hide:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_button2];
    

    
    _button3 = [MyController generateButtonWithTitle:@"Toggle Animated"];
    
    [_button3 addTarget:self action:@selector(toggleAnimated:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_button3];
    
    
    
    _button4 = [MyController generateButtonWithTitle:@"Long Message"];
    
    [_button4 addTarget:self action:@selector(toggleLongMessage:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:_button4];
    
    
    
    _overlaySwitch = [MyController generateButtonWithTitle:@"Toggle Style"];
    
    [_overlaySwitch addTarget: self action: @selector(toggleOverlayStyle:) forControlEvents:UIControlEventTouchUpInside];

    [self.view addSubview:_overlaySwitch];
    
    
    _label1 = [UILabel new];
    
    [_label1 setFont:[UIFont fontWithName:@"Helvetica-Neue" size:10.0]];
    [_label1 setBackgroundColor:[UIColor clearColor]];
    [_label1 setTextColor:[UIColor whiteColor]];
    [_label1 setText:@"'Will' Delegate:"];
    [_label1 setNumberOfLines:2];
    [self.view addSubview:_label1];
    
    
    _label2 = [UILabel new];
    
    [_label2 setFont:[UIFont fontWithName:@"Helvetica-Neue" size:10.0]];
    [_label2 setBackgroundColor:[UIColor clearColor]];
    [_label2 setTextColor:[UIColor whiteColor]];
    [_label2 setText:@"'Did' Delegate:"];
    [_label2 setNumberOfLines:2];
    [self.view addSubview:_label2];
    
}

#pragma mark - Layout (called each time the view is redrawn)

- (void)viewWillLayoutSubviews
{
    CGFloat buttonWidth = 142;
    CGFloat buttonHeight = 40;
    CGFloat buttonX = (self.view.bounds.size.width/2) - (buttonWidth/2);
    
    _button1.frame = CGRectMake(buttonX, self.view.bounds.origin.y + 10, buttonWidth, buttonHeight);
    _button2.frame = CGRectMake(buttonX, self.view.bounds.origin.y + 60, buttonWidth, buttonHeight);
    _button3.frame = CGRectMake(buttonX, self.view.bounds.origin.y + 110, buttonWidth, buttonHeight);
    _button4.frame = CGRectMake(buttonX, self.view.bounds.origin.y + 160, buttonWidth, buttonHeight);
    _overlaySwitch.frame = CGRectMake(buttonX, self.view.bounds.origin.y + 210, buttonWidth, buttonHeight);
    
    _label1.frame = CGRectMake(5, self.view.bounds.origin.y + 260, self.view.bounds.size.width - 10, 40);
    _label2.frame = CGRectMake(5, self.view.bounds.origin.y + 310, self.view.bounds.size.width - 10, 40);
    
    
}



#pragma mark - Button Actions

- (IBAction)show: (id) sender
{
    [_statusBarController setStatusMessage:@"Simple Status"];
    [_statusBarController setVisibility:YES animated:NO];
}

- (IBAction)hide: (id) sender
{
    [_statusBarController setVisibility:NO animated:NO];
}

- (IBAction)toggleAnimated: (id) sender
{
    BOOL newVisibility = !_statusBarController.visiblity;
    [_statusBarController setVisibility:newVisibility withMessage:@"Animated Status" animated:YES];
}

- (IBAction)toggleLongMessage: (id) sender
{
    BOOL newVisibility = !_statusBarController.visiblity;
    [_statusBarController setVisibility:newVisibility withMessage:@"I am too long to fit in this space and may get cut off" animated:YES];
}

- (IBAction) toggleOverlayStyle: (id) sender
{
    _statusBarController.overlayStyle =  !_statusBarController.overlayStyle;
}


#pragma mark - Optional Delegate Methods

- (void)statusBarController:(StatusBarController *)controller willShowStatusBar:(BOOL)visible animated:(BOOL)animated
{
    [_label1 setText:[NSString stringWithFormat:@"'Will' Delegate - visible: %@ animated: %@", (visible ? @"visible" : @"hidden"), (animated ? @"animated" : @"not animated")]];
}

- (void)statusBarController:(StatusBarController *)controller didShowStatusBar:(BOOL)visible animated:(BOOL)animated
{
    [_label2 setText:[NSString stringWithFormat:@"'Did' Delegate - visible: %@ animated: %@", (visible ? @"visible" : @"hidden"), (animated ? @"animated" : @"not animated")]];
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
