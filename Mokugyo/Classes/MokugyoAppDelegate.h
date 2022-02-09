//
//  MokugyoAppDelegate.h
//  Mokugyo
//
//  Created by 陽一 岡本 on 12/10/09.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class TopViewController;

@interface MokugyoAppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

@property (strong, nonatomic) TopViewController *viewController;

@property (strong, nonatomic) UINavigationController *navigationController;

@end
