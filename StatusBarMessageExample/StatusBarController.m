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

#import "StatusBarController.h"

#define STATUS_BAR_HEIGHT 20

@interface StatusBarController ()

@property (nonatomic) UIView * statusBar;
@property (nonatomic) UILabel * statusBarLabel;

@end

@implementation StatusBarController


#pragma mark - Initialization

- (id) init
{
    if ((self=[super init]))
    {
        _statusBar = [UIView new];
        _statusBarLabel = [UILabel new];
        
        _visiblity = NO;
    }
    
    return self;
}

- (id)initWithRootViewController:(UIViewController *)rootViewController
{
    if ((self=[self init]))
    {
        _rootViewController = rootViewController;
    }
    return self;
}

- (void)loadView
{
    [super loadView];
    
    self.view = [UIView new];
    [self.view addSubview:_rootViewController.view];    
    [self.view addSubview:_statusBar];
}

- (void)viewDidLoad
{
    [super viewDidLoad];

    _statusBar.clipsToBounds = YES;
    _statusBar.backgroundColor = [UIColor blackColor];
    
    _statusBarLabel.textColor = [self colorForStatusLabelText];
    _statusBarLabel.font = [UIFont boldSystemFontOfSize:14.0];
    _statusBarLabel.backgroundColor = [UIColor clearColor];
    _statusBarLabel.textAlignment = NSTextAlignmentCenter;
    _statusBarLabel.numberOfLines = 0;
    _statusBarLabel.lineBreakMode = NSLineBreakByTruncatingTail;

    [_statusBar addSubview:_statusBarLabel];
}

- (void)viewWillLayoutSubviews
{
    [super viewWillLayoutSubviews];
    
    _rootViewController.view.frame = [self frameForRootController];
    _statusBar.frame = [self frameForStatusBar];
    _statusBarLabel.frame = [self frameForStatusBarLabel];
}

- (void)viewDidLayoutSubviews
{
    [super viewDidLayoutSubviews];
    // no addition configuration
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    // no addition configuration
}

- (void)viewDidAppear:(BOOL)animated
{
    [super viewDidAppear:animated];
    // no addition configuration
}

- (void)viewDidDisappear:(BOOL)animated
{
    [super viewDidDisappear:animated];
    // no addition configuration
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    _statusBar = nil;
    _statusBarLabel = nil;
    _rootViewController = nil;
}


#pragma mark - Public methods

- (void) setStatusMessage:(NSString *) text
{
    _statusBarLabel.text = text;
    _statusBarLabel.frame = [self frameForStatusBarLabel];
}

- (void) setVisibility:(BOOL) visible animated:(BOOL)animated
{
    _visiblity = visible;
    [self resizeViewsAnimated:animated];
}

- (void) setVisibility:(BOOL) visible withMessage:(NSString *) text animated:(BOOL)animated
{
    [self setStatusMessage:text];
    [self setVisibility:visible animated:animated];
}




#pragma mark - Private methods

- (UIColor *) colorForStatusLabelText
{
    return [UIColor colorWithRed:191.0/255.0 green:191.0/255.0 blue:191.0/255.0 alpha:1.0];
}

- (CGRect) frameForRootController
{
    CGRect frame = self.view.bounds;
    
    if(_visiblity)
    {
        frame.size.height -= STATUS_BAR_HEIGHT;
        frame.origin.y += STATUS_BAR_HEIGHT;
    }
    
    return frame;
}

- (CGRect) frameForStatusBar
{
    
    CGRect frame = CGRectMake(0, 0, self.view.bounds.size.width, 0);
    
    if(_visiblity)
    {
        frame.size.height = STATUS_BAR_HEIGHT;
    }
    
    return frame;
}

- (CGRect) frameForStatusBarLabel
{
    CGSize sizeNeededForText = [_statusBarLabel.text sizeWithFont:_statusBarLabel.font];
    
    CGFloat width = MIN(sizeNeededForText.width, _statusBar.bounds.size.width);
    CGFloat height = MIN(sizeNeededForText.height, _statusBar.bounds.size.height);
    CGFloat x = (_statusBar.bounds.size.width / 2) - (width / 2);
    
    return CGRectMake(x, 0, width, height);
}


- (void) resizeViewsAnimated:(BOOL)animated
{
    
    if([_delegate respondsToSelector:@selector(statusBarController:willShowStatusBar:animated:)])
    {
        [_delegate statusBarController:self willShowStatusBar:_visiblity animated:animated];
    }
    
    [UIView animateWithDuration:animated ? 0.3 : 0 animations:^{
        
        [self viewWillLayoutSubviews];
        
    } completion:^(BOOL finished){
        
        if([_delegate respondsToSelector:@selector(statusBarController:didShowStatusBar:animated:)])
        {
            [_delegate statusBarController:self didShowStatusBar:_visiblity animated:animated];
        }
        
    }];
}

@end
