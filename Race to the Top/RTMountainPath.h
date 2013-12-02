//
//  RTMountainPath.h
//  Race to the Top
//
//  Created by Mark Stuver on 12/1/13.
//  Copyright (c) 2013 Halo International Corp. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface RTMountainPath : NSObject

/// Create Class Method
+(NSArray *)mountainPathsForRect: (CGRect)rect;

///
+(UIBezierPath *)tapTargetForPath:(UIBezierPath *)path;


@end
