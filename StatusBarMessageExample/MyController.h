//
//  MyController.h
//  StatusBarMessageExample
//
//  Created by Matt Wielbut on 9/30/13.
//  Copyright (c) 2013 Matt Wielbut. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "StatusBarController.h"

@interface MyController : UIViewController<StatusBarControllerDelegate>

@property (nonatomic, weak) StatusBarController * statusBarController;

@end
