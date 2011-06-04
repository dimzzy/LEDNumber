//
//  LEDNumberAppDelegate.h
//  LEDNumber
//
//  Created by Dmitry Stadnik on 6/1/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>

@class LEDNumberViewController;

@interface LEDNumberAppDelegate : NSObject <UIApplicationDelegate> {

}

@property (nonatomic, retain) IBOutlet UIWindow *window;

@property (nonatomic, retain) IBOutlet LEDNumberViewController *viewController;

@end
