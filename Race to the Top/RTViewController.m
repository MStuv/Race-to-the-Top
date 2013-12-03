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

// Defines for making easy changes if needed
#define RTMAP_STARTING_SCORE 15000
#define RTMAP_SCORE_DECREMENT_AMOUNT 100
#define RTTIMER_INTERVAL 0.1
#define RTWALL_PENALTY 500

@interface RTViewController ()

#pragma mark - Private Properties
// Private Properties - Not available to other classes to access
//Private IBOutlet from Storyboard view connected to RTPathView
@property (strong, nonatomic) IBOutlet RTPathView *pathView;

// Private NSTimer property
@property (strong, nonatomic) NSTimer *timer;


@end

@implementation RTViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

#pragma mark TAP - GestureRecognizer
    // Create instance of TapGestureRecognizer
    UITapGestureRecognizer *tapRecognizer = [[UITapGestureRecognizer alloc]
                                             // set currentVC as the target
                                             initWithTarget:self
                                             // set 'tapDetected:' as the action method
                                             action:@selector(tapDetected:)];
    
    // Optional: Set the number of taps that the user needs to make before the gesture will be recognized.
    //tapRecognizer.numberOfTapsRequired = 2;
    
    // Method to add the tapRecongnizer to the pathView IBOutlet
    [self.pathView addGestureRecognizer:tapRecognizer];

#pragma mark PAN - GestureRecognizer
    // Create instance of PanGestureRecognizer
    UIPanGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panDetected:)];

    // Add panRecognizer to the pathView IBOutlet
    [self.pathView addGestureRecognizer:panRecognizer];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


#pragma mark - Gesture Recognizer Action Methods

//TAP GESTURE ACTION METHOD - is called when the user taps the view
-(void)tapDetected:(UITapGestureRecognizer *)tapRecognizer
{
    NSLog(@"Tapped!");
    
    // Create instance of CGPoint that is equal to value created when the locationInView: method is called.
    // This method will return the location of the UITapGestureRecongnizer
    CGPoint tapLocation = [tapRecognizer locationInView:self.pathView];
    
    // Log out the value of the CGPoint instance at the .x & .y properties
    NSLog(@"Tap location is at (%f, %f)", tapLocation.x, tapLocation.y);
}


//PAN GESTURE ACTION METHOD - is called when the user pans the view (continually touches view)
-(void)panDetected:(UIPanGestureRecognizer *)panRecognizer
{
    // Using the method locationInView to determine where in the coordinate system the touch is occuring
    // Location of the user's current finger location on the pathView
    CGPoint fingerLocation = [panRecognizer locationInView:self.pathView];
    
    /// if the pan state is began and the fingerlocation is at the start of the trail
    if (panRecognizer.state == UIGestureRecognizerStateBegan && fingerLocation.y < 750)
    {
        // set the value of the NSTimer property.
        self.timer = [NSTimer
                      // 1 second intervals
                      scheduledTimerWithTimeInterval:RTTIMER_INTERVAL
                      // target is the currentVC
                      target:self
                      // set selector to the action method: 'timerFired'
                      selector:@selector(timerFired)
                      userInfo:nil
                      // have timer continue to repeat
                      repeats:YES];
        // Setting starting score
        self.scoreLabel.text = [NSString stringWithFormat:@"Score: %i", RTMAP_STARTING_SCORE];
    }
    else if (panRecognizer.state == UIGestureRecognizerStateChanged)
    {
        // To get all the path objects in the array that is returned from the RTMountainPath's 'mountainPathsForRect:' method.
        for (UIBezierPath *path in [RTMountainPath mountainPathsForRect:self.pathView.bounds]) {
            
            // once we have a usable bezierPath, we create an instance of UIBezierPath that is given the value that is returned from the RTMountainPath's 'tapTargetForPath:' method
            UIBezierPath *tapTarget = [RTMountainPath tapTargetForPath:path];
            
            // If the tapTarget contains the point that are in the fingerLocation (user's finger location)
            if ([tapTarget containsPoint:fingerLocation]) {
                
                // If user touches wall of path, the following method will be called to update score with a penalty
                [self decrementScoreByAmount:RTWALL_PENALTY];
            }
        }
    }
    else if (panRecognizer.state ==UIGestureRecognizerStateEnded && fingerLocation.y <= 165)
    {
        [self.timer invalidate];
        self.timer = nil;
    }
    else {
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"Error" message:@"Make sure to start at the bottom of the path, hold your finger down and finish at the top of the path!" delegate:nil cancelButtonTitle:@"Ok" otherButtonTitles:nil];
        [alert show];
        
        [self.timer invalidate];
        self.timer = nil;
    }
    
}

#pragma mark - Timer Action Method

// Timer Action Method for
-(void)timerFired
{
    // Everytime the timerFired method is called, call the decrementScoreByAmount: method to update the score
    [self decrementScoreByAmount:RTMAP_SCORE_DECREMENT_AMOUNT];
}

#pragma mark - Changing Score Method

-(void)decrementScoreByAmount:(int)amount
{
    // NSString Instance that is set the lastObject of the score string
        /* componentsSeparatedByString: method will seperate the string into objects based by the string that is passed into the method. For example, the following seperates the string into components based on @" " spaces between words. */
    NSString *scoreText = [[self.scoreLabel.text componentsSeparatedByString:@" "] lastObject];
    
    // The lastObject of the previous line of code is the current score. Need to convert the string version of the score into an int so that it can be calculated.
    int score = [scoreText intValue];
    
    // subtract the amount (which was passed when the method was called) from the score.
    score = score - amount;
    
    // set the scoreLabel to reflect the current score. Converting it to a string using stringWithFormat
    self.scoreLabel.text = [NSString stringWithFormat:@"Score: %i", score];
}

@end
