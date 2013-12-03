//
//  RTMountainPath.h
//  Race to the Top
//
//  Created by Mark Stuver on 12/1/13.
//  Copyright (c) 2013 Halo International Corp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RTMountainPath : NSObject

// Class Methods - called on the class: [RTMountainPath mountainPathsForRect:CGRect object];
+(NSArray *)mountainPathsForRect: (CGRect)rect;
+(UIBezierPath *)tapTargetForPath:(UIBezierPath *)path;


@end
