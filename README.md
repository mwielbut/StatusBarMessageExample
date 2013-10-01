StatusBarMessageExample
=======================

A example project for creating a secondary status bar on an IOS app for displaying user status messages.

The functionality is encapsulated within a single container view controller <code>StatusBarController</code> which is designed to be a simple **drop-in** wrapper for your root controller.

![Screenshot (Hidden)](/status_hidden.png "Hidden")

![Screenshot (Visible)](/status_showing.png "Visible")

## License

MIT License (MIT)


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

## Thanks 

 * Thanks to Tommy Sadler for the great [blurred backgrounds](http://dribbble.com/shots/1082688-15-Free-Blurred-Backgrounds-Bonus-Wallpapers)

 
