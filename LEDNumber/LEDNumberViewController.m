//
//  LEDNumberViewController.m
//  LEDNumber
//
//  Created by Dmitry Stadnik on 6/1/11.
//  Copyright 2011 __MyCompanyName__. All rights reserved.
//

#import "LEDNumberViewController.h"

@implementation LEDNumberViewController

@synthesize dnView = _dnView;

- (void)viewDidLoad {
    [super viewDidLoad];
	
	CABasicAnimation *dna = [CABasicAnimation animationWithKeyPath:@"number"];
	dna.fromValue = [NSNumber numberWithInt:0];
	dna.toValue = [NSNumber numberWithInt:218];
	dna.duration = 5;
	dna.fillMode = kCAFillModeRemoved;
	[self.dnView.numberLayer addAnimation:dna forKey:@"numberFlip"];
	self.dnView.numberLayer.number = 218;
}

- (void)dealloc {
	[_dnView release];
    [super dealloc];
}

@end
