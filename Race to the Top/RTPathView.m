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


/// This init is not used when using the storyboard, but in case there is a situation where the storyboard is not used, the initWithFrame is coded to initilize using the 'setup' method.
- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        /// call setup method
        [self setup];
    }
    return self;
}

/// initWithFrame: is not called when using a storyboard. Instead we actually 'unarchiving' or 'unserializing' it from our storyboard. So to assure that the background is set to clear, we call the method in initWithCoder.
-(id)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        /// call setup method
        [self setup];
    }
    return self;
}

/// Method to set the background color of the view to clear
-(void)setup
{
    self.backgroundColor = [UIColor clearColor];
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
