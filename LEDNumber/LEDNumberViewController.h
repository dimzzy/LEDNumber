//
//  LEDNumberViewController.h
//  LEDNumber
//
//  Created by Dmitry Stadnik on 6/1/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "LEDNumberView.h"

@interface LEDNumberViewController : UIViewController {
@private
	LEDNumberView *_dnView;
}

@property(nonatomic, retain) IBOutlet LEDNumberView *dnView;

@end
