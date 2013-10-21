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

#import <UIKit/UIKit.h>

@class StatusBarController;

@protocol StatusBarControllerDelegate <NSObject>
@optional
- (void)statusBarController:(StatusBarController *)controller didShowStatusBar:(BOOL)visible animated:(BOOL)animated;
- (void)statusBarController:(StatusBarController *)controller willShowStatusBar:(BOOL)visible animated:(BOOL)animated;
@end



@interface StatusBarController : UIViewController

@property (nonatomic,readonly) BOOL visiblity;

/* overlayStyle
 * When set to YES, the new status bar will appear over the content, under the existing status bar.
 * Default is NO - the new status bar will push the existing content down.
 */
@property (nonatomic) BOOL overlayStyle;

@property (nonatomic) UIViewController * rootViewController;
@property (nonatomic, weak) id<StatusBarControllerDelegate> delegate;

- (id)initWithRootViewController:(UIViewController *)rootViewController;

- (void) setStatusMessage:(NSString *) text;

- (void) setVisibility:(BOOL) visible animated:(BOOL)animated;

- (void) setVisibility:(BOOL) visible withMessage:(NSString *) text animated:(BOOL)animated;

@end
