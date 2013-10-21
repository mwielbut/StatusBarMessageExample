StatusBarMessageExample
=======================

An example project for creating a secondary status bar on an IOS app for displaying custom app status messages.

The additional status bar can be controlled to show/hide when required and appears directly underneath the existing one. We find it very useful for displaying network status notifications in our App.

This is an alternative to  overlaying a custom status bar on top of the existing one.
* [kgstatusbar](http://www.cocoacontrols.com/controls/kgstatusbar)
* [twstatus](http://www.cocoacontrols.com/controls/twstatus)


Side note: If you happen to have a status bar message that is too long to fit, I recommend taking a look at Charles Powell's [Marquee Label](https://github.com/cbpowell/MarqueeLabel) which will scroll any label text that is too long (similar to a ticker tape). It's very easy to drop-in.


## Overview

The functionality is encapsulated within a single container view controller <code>StatusBarController</code> which is designed to be a simple **drop-in** wrapper for your root controller.
Supports multiple orientations.

![Screenshot (Hidden)](/status_hidden.png "Hidden")

![Screenshot (Visible)](/status_showing.png "Visible")



## Usage

1. Copy <code>StatusBarController.h</code> and <code>StatusBarController.m</code> into your project. 
1. Instantiate the StatusBarController class within your AppDelegate class, passing in your existing root controller:

        - (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
        {
            [[UIApplication sharedApplication]setStatusBarStyle:UIStatusBarStyleBlackOpaque];
            
            self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
            
            // your existing root controller
            MyController *myController = [[MyController alloc] init];
            
            // create an instance of the status container controller, passing in your root controller
            StatusBarController * statusBarController = [[StatusBarController alloc] initWithRootViewController:myController];
            
            // (optional) if you need your root controller to be notified of changes to the status bar, set the delgate
            statusBarController.delegate = myController;
            
            // (optional) pass the status bar controller into the root controller so we can pass status messages
            // an alternative would be to use the singleton pattern or notification center which our outside the
            // scope of this example
            myController.statusBarController = statusBarController;
            
            // set the status bar controller as the root window controller
            [_window setRootViewController:statusBarController];
            
            [self.window makeKeyAndVisible];
            
            return YES;
        }
1. Use the controller methods to set the message and show/hide the status bar

        - (void) setStatusMessage:(NSString *) text;
        - (void) setVisibility:(BOOL) visible animated:(BOOL)animated;
        - (void) setVisibility:(BOOL) visible withMessage:(NSString *) text animated:(BOOL)animated;

1. Styles

The controller comes in 2 styles, controlled by the <code>overlayStyle</code> property: 
 * The default value is NO and will cause the new status bar to insert itself between the existing status bar and the app content, forcing the app content view to shrink in size by the same amount.
 * By setting it to YES, the new status bar will appar ON TOP of the app content.

## Thanks 

 * Thanks to Tommy Sadler for the great [blurred backgrounds](http://dribbble.com/shots/1082688-15-Free-Blurred-Backgrounds-Bonus-Wallpapers)

## License

MIT License (MIT)

## Disclaimer

This code is provided with very limited testing on a single device (iPhone 5 running IOS 6). Feel free to customize to support other status colors or locations. 


## Changes

 * Oct 21, 2013 - Added optional functionality for the status bar to appear ON TOP of the app content view rather than pushing it down.
 




