//
//  RTPathView.m
//  Race to the Top
//
//  Created by Mark Stuver on 12/1/13.
//  Copyright (c) 2013 Halo International Corp. All rights reserved.
//

#import "RTPathView.h"
#import "RTMountainPath.h"

@implementation RTPathView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    /** enumerate through array that is returned from the RTMountainPath class method.
                • the views bounds (self.bounds) is being passed to the class method */
    for (UIBezierPath *path in [RTMountainPath mountainPathsForRect:self.bounds]) {
        
        /// As each UIBezierPath object from the array is passed, the stroke color is set to black and the stroke is created on the view.
        [[UIColor blackColor]setStroke];
        [path stroke];
    }
    
    
}


@end
