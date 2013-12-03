//
//  RTViewController.m
//  Race to the Top
//
//  Created by Mark Stuver on 11/30/13.
//  Copyright (c) 2013 Halo International Corp. All rights reserved.
//


#import "RTViewController.h"
#import "RTPathView.h"
#import "RTMountainPath.h"

@interface RTViewController ()

/// Private IBOutlet from Storyboard - this allows for the IBOutlet to not be available to other classes)]
@property (strong, nonatomic) IBOutlet RTPathView *pathView;
@end

@implementation RTViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

#pragma mark TAP - GestureRecognizer
    /// Create instance of TapGestureRecognizer
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc]
                                             /// set currentVC as the target
                                             initWithTarget:self
                                             /// set 'tapDetected:' as the action method
                                             action:@selector(tapDetected:)];
    
    /// Optional: Set the number of taps that the user needs to make before the gesture will be recognized.
    //tapRecognizer.numberOfTapsRequired = 2;
    
    /// Method to add the tapRecongnizer to the pathView IBOutlet
    [self.pathView addGestureRecognizer:tapRecognizer];

#pragma mark PAN - GestureRecognizer
    /// Create instance of PanGestureRecognizer
    UIPanGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panDetected:)];
    
    /// Add panRecognizer to the pathView IBOutlet
    [self.pathView addGestureRecognizer:panRecognizer];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Gesture Recognizer Action Methods

///TAP GESTURE ACTION METHOD - is called when the user taps the view
-(void)tapDetected:(UITapGestureRecognizer *)tapRecognizer
{
    NSLog(@"Tapped!");
    
    /// Create instance of CGPoint that is equal to value created when the locationInView: method is called.
    /// This method will return the location of the UITapGestureRecongnizer
    CGPoint tapLocation = [tapRecognizer locationInView:self.pathView];
    
    /// Log out the value of the CGPoint instance at the .x & .y properties
    NSLog(@"Tap location is at (%f, %f)", tapLocation.x, tapLocation.y);
}


///PAN GESTURE ACTION METHOD - is called when the user pans the view (continually touches view)
-(void)panDetected:(UIPanGestureRecognizer *)panRecognizer
{
    // Using the method locationInView to determine where in the coordinate system the touch is occuring
    /// Location of the user's current finger location on the pathView
    CGPoint fingerLocation = [panRecognizer locationInView:self.pathView];
    NSLog(@"I'm at (%f, %f)", fingerLocation.x, fingerLocation.y);
    
    /// To get all the path objects in the array that is returned from the RTMountainPath's 'mountainPathsForRect:' method.
    for (UIBezierPath *path in [RTMountainPath mountainPathsForRect:self.pathView.bounds]) {
        
        /// once we have a usable bezierPath, we create an instance of UIBezierPath that is given the value that is returned from the RTMountainPath's 'tapTargetForPath:' method
        UIBezierPath *tapTarget = [RTMountainPath tapTargetForPath:path];
        
        /// If the tapTarget contains the point that are in the fingerLocation (user's finger location)
        if ([tapTarget containsPoint:fingerLocation]) {
            /// log that the user hit the wall.
            NSLog(@"You Hit the wall");
        }
    }
}


@end
