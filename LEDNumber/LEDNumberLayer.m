/*
 Copyright 2011 Dmitry Stadnik. All rights reserved.
 
 Redistribution and use in source and binary forms, with or without modification, are
 permitted provided that the following conditions are met:
 
 1. Redistributions of source code must retain the above copyright notice, this list of
 conditions and the following disclaimer.
 
 2. Redistributions in binary form must reproduce the above copyright notice, this list
 of conditions and the following disclaimer in the documentation and/or other materials
 provided with the distribution.
 
 THIS SOFTWARE IS PROVIDED BY DMITRY STADNIK ``AS IS'' AND ANY EXPRESS OR IMPLIED
 WARRANTIES, INCLUDING, BUT NOT LIMITED TO, THE IMPLIED WARRANTIES OF MERCHANTABILITY AND
 FITNESS FOR A PARTICULAR PURPOSE ARE DISCLAIMED. IN NO EVENT SHALL DMITRY STADNIK OR
 CONTRIBUTORS BE LIABLE FOR ANY DIRECT, INDIRECT, INCIDENTAL, SPECIAL, EXEMPLARY, OR
 CONSEQUENTIAL DAMAGES (INCLUDING, BUT NOT LIMITED TO, PROCUREMENT OF SUBSTITUTE GOODS OR
 SERVICES; LOSS OF USE, DATA, OR PROFITS; OR BUSINESS INTERRUPTION) HOWEVER CAUSED AND ON
 ANY THEORY OF LIABILITY, WHETHER IN CONTRACT, STRICT LIABILITY, OR TORT (INCLUDING
 NEGLIGENCE OR OTHERWISE) ARISING IN ANY WAY OUT OF THE USE OF THIS SOFTWARE, EVEN IF
 ADVISED OF THE POSSIBILITY OF SUCH DAMAGE.
 
 The views and conclusions contained in the software and documentation are those of the
 authors and should not be interpreted as representing official policies, either expressed
 or implied, of Dmitry Stadnik.
*/

#import "LEDNumberLayer.h"

typedef enum {
	DigitSegmentTopRight,
	DigitSegmentBottomRight,
	DigitSegmentTopLeft,
	DigitSegmentBottomLeft,
	DigitSegmentTop,
	DigitSegmentBottom,
	DigitSegmentCenter
} DigitSegment;


@interface LEDNumberLayer (Private)

@property(nonatomic, readonly) UIImage *tickImage;
@property(nonatomic, readonly) UIImage *tickCenterImage;

@end


@implementation LEDNumberLayer

@synthesize number = _number;

- (id)initWithLayer:(id)layer {
	if ((self = [super initWithLayer:layer])) {
		LEDNumberLayer *numberLayer = (LEDNumberLayer *)layer;
		self.number = numberLayer.number;
	}
	return self;
}

- (void)dealloc {
	[_tickImage release];
	[_tickCenterImage release];
	[super dealloc];
}

- (UIImage *)tickImage {
	if (!_tickImage) {
		_tickImage = [[UIImage imageNamed:@"tick.png"] retain];
	}
	return _tickImage;
}

- (UIImage *)tickCenterImage {
	if (!_tickCenterImage) {
		_tickCenterImage = [[UIImage imageNamed:@"tickc.png"] retain];
	}
	return _tickCenterImage;
}

+ (BOOL)needsDisplayForKey:(NSString *)key {
    if ([key isEqualToString:@"number"]) {
        return YES;
    } else {
        return [super needsDisplayForKey:key];
    }
}

- (void)drawDigitSegment:(DigitSegment)segment inContext:(CGContextRef)ctx {
	switch (segment) {
		case DigitSegmentTopRight: {
			CGRect r = CGRectMake(kLEDDigitWidth - kLEDDigitTickWidth,
								  kLEDDigitSpacing,
								  kLEDDigitTickWidth, kLEDDigitTickHeight);
			CGContextDrawImage(ctx, r, self.tickImage.CGImage);
			break;
		}
		case DigitSegmentBottomRight: {
			CGRect r = CGRectMake(kLEDDigitWidth - kLEDDigitTickWidth,
								  kLEDDigitSpacing + kLEDDigitTickHeight + kLEDDigitSpacing,
								  kLEDDigitTickWidth, kLEDDigitTickHeight);
			CGContextDrawImage(ctx, r, self.tickImage.CGImage);
			break;
		}
		case DigitSegmentTopLeft: {
			CGContextScaleCTM(ctx, -1, 1);
			CGRect r = CGRectMake(-kLEDDigitTickWidth,
								  kLEDDigitSpacing,
								  kLEDDigitTickWidth, kLEDDigitTickHeight);
			CGContextDrawImage(ctx, r, self.tickImage.CGImage);
			CGContextScaleCTM(ctx, -1, 1);
			break;
		}
		case DigitSegmentBottomLeft: {
			CGContextScaleCTM(ctx, -1, 1);
			CGRect r = CGRectMake(-kLEDDigitTickWidth,
								  kLEDDigitSpacing + kLEDDigitTickHeight + kLEDDigitSpacing,
								  kLEDDigitTickWidth, kLEDDigitTickHeight);
			CGContextDrawImage(ctx, r, self.tickImage.CGImage);
			CGContextScaleCTM(ctx, -1, 1);
			break;
		}
		case DigitSegmentTop: {
			CGContextRotateCTM(ctx, -M_PI_2);
			CGRect r = CGRectMake(-kLEDDigitTickWidth,
								  kLEDDigitSpacing,
								  kLEDDigitTickWidth, kLEDDigitTickHeight);
			CGContextDrawImage(ctx, r, self.tickImage.CGImage);
			CGContextRotateCTM(ctx, M_PI_2);
			break;
		}
		case DigitSegmentBottom: {
			CGContextRotateCTM(ctx, M_PI_2);
			CGRect r = CGRectMake(kLEDDigitHeight - kLEDDigitTickWidth,
								  -(kLEDDigitSpacing + kLEDDigitTickHeight),
								  kLEDDigitTickWidth, kLEDDigitTickHeight);
			CGContextDrawImage(ctx, r, self.tickImage.CGImage);
			CGContextRotateCTM(ctx, -M_PI_2);
			break;
		}
		case DigitSegmentCenter: {
			CGRect r = CGRectMake(kLEDDigitSpacing,
								  kLEDDigitSpacing + kLEDDigitTickHeight - kLEDDigitTickWidth / 2,
								  kLEDDigitTickHeight, kLEDDigitTickWidth);
			CGContextDrawImage(ctx, r, self.tickCenterImage.CGImage);
			break;
		}
	}
}

- (void)drawDigit:(NSUInteger)digit inContext:(CGContextRef)ctx {
	switch (digit) {
		case 0: {
			[self drawDigitSegment:DigitSegmentTopRight inContext:ctx];
			[self drawDigitSegment:DigitSegmentBottomRight inContext:ctx];
			[self drawDigitSegment:DigitSegmentTopLeft inContext:ctx];
			[self drawDigitSegment:DigitSegmentBottomLeft inContext:ctx];
			[self drawDigitSegment:DigitSegmentTop inContext:ctx];
			[self drawDigitSegment:DigitSegmentBottom inContext:ctx];
			break;
		}
		case 1: {
			[self drawDigitSegment:DigitSegmentTopRight inContext:ctx];
			[self drawDigitSegment:DigitSegmentBottomRight inContext:ctx];
			break;
		}
		case 2: {
			[self drawDigitSegment:DigitSegmentTopRight inContext:ctx];
			[self drawDigitSegment:DigitSegmentBottomLeft inContext:ctx];
			[self drawDigitSegment:DigitSegmentTop inContext:ctx];
			[self drawDigitSegment:DigitSegmentBottom inContext:ctx];
			[self drawDigitSegment:DigitSegmentCenter inContext:ctx];
			break;
		}
		case 3: {
			[self drawDigitSegment:DigitSegmentTopRight inContext:ctx];
			[self drawDigitSegment:DigitSegmentBottomRight inContext:ctx];
			[self drawDigitSegment:DigitSegmentTop inContext:ctx];
			[self drawDigitSegment:DigitSegmentBottom inContext:ctx];
			[self drawDigitSegment:DigitSegmentCenter inContext:ctx];
			break;
		}
		case 4: {
			[self drawDigitSegment:DigitSegmentTopRight inContext:ctx];
			[self drawDigitSegment:DigitSegmentBottomRight inContext:ctx];
			[self drawDigitSegment:DigitSegmentTopLeft inContext:ctx];
			[self drawDigitSegment:DigitSegmentCenter inContext:ctx];
			break;
		}
		case 5: {
			[self drawDigitSegment:DigitSegmentBottomRight inContext:ctx];
			[self drawDigitSegment:DigitSegmentTopLeft inContext:ctx];
			[self drawDigitSegment:DigitSegmentTop inContext:ctx];
			[self drawDigitSegment:DigitSegmentBottom inContext:ctx];
			[self drawDigitSegment:DigitSegmentCenter inContext:ctx];
			break;
		}
		case 6: {
			[self drawDigitSegment:DigitSegmentTopRight inContext:ctx];
			[self drawDigitSegment:DigitSegmentBottomRight inContext:ctx];
			[self drawDigitSegment:DigitSegmentTop inContext:ctx];
			break;
		}
		case 7: {
			[self drawDigitSegment:DigitSegmentTopRight inContext:ctx];
			[self drawDigitSegment:DigitSegmentBottomRight inContext:ctx];
			[self drawDigitSegment:DigitSegmentTopLeft inContext:ctx];
			[self drawDigitSegment:DigitSegmentBottomLeft inContext:ctx];
			[self drawDigitSegment:DigitSegmentTop inContext:ctx];
			[self drawDigitSegment:DigitSegmentBottom inContext:ctx];
			break;
		}
		case 8: {
			[self drawDigitSegment:DigitSegmentTopRight inContext:ctx];
			[self drawDigitSegment:DigitSegmentBottomRight inContext:ctx];
			[self drawDigitSegment:DigitSegmentTopLeft inContext:ctx];
			[self drawDigitSegment:DigitSegmentBottomLeft inContext:ctx];
			[self drawDigitSegment:DigitSegmentTop inContext:ctx];
			[self drawDigitSegment:DigitSegmentBottom inContext:ctx];
			[self drawDigitSegment:DigitSegmentCenter inContext:ctx];
			break;
		}
		case 9: {
			[self drawDigitSegment:DigitSegmentTopRight inContext:ctx];
			[self drawDigitSegment:DigitSegmentBottomRight inContext:ctx];
			[self drawDigitSegment:DigitSegmentTopLeft inContext:ctx];
			[self drawDigitSegment:DigitSegmentTop inContext:ctx];
			[self drawDigitSegment:DigitSegmentBottom inContext:ctx];
			[self drawDigitSegment:DigitSegmentCenter inContext:ctx];
			break;
		}
	}
}

- (void)drawInContext:(CGContextRef)ctx {
	CGContextTranslateCTM(ctx, (kLEDNumberPower - 1) * (kLEDDigitWidth + kLEDNumberSpacing), 0);
	NSUInteger n = _number;
	for (int i = 0; i < kLEDNumberPower; i++) {
		[self drawDigit:(n % 10) inContext:ctx];
		n /= 10;
		CGContextTranslateCTM(ctx, -(kLEDDigitWidth + kLEDNumberSpacing), 0);
	}
}

@end
