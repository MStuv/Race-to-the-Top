//
//  RTMountainPath.m
//  Race to the Top
//
//  Created by Mark Stuver on 12/1/13.
//  Copyright (c) 2013 Halo International Corp. All rights reserved.
//

#import "RTMountainPath.h"

@implementation RTMountainPath

/// Class Method will return an array of bezierPaths
+(NSArray *)mountainPathsForRect: (CGRect)rect
{
    /// Mutable Array instance
    NSMutableArray *variousPaths = [@[] mutableCopy];
    
    /// Instance of CGPoint
    CGPoint firstPoint = CGPointMake(rect.size.width * (1/6.0), CGRectGetMaxY(rect));
    
    /// Instance of CGPoint
    CGPoint secondPoint = CGPointMake(rect.size.width * (1/3.0), rect.size.height * (5/6.0));
    
    /// Create instance of UIBezierPath
    UIBezierPath *labyrinthPath = [UIBezierPath bezierPath];
    /// Set line width
    labyrinthPath.lineWidth = 4.0;
    /// Set moveToPoint to the value of firstPoint
    [labyrinthPath moveToPoint:firstPoint];
    /// add line to point to the value of secondPoint
    [labyrinthPath addLineToPoint:secondPoint];
    /// add the UIBezierPath instance to the array.
    [variousPaths addObject:labyrinthPath];
    /// return array
    return variousPaths;
    
}

@end
