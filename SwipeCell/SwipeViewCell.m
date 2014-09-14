//
//  SwipeViewCell.m
//  SwipeCell
//
//  Created by Karl Grogan on 13/09/2014.
//  Copyright (c) 2014 Karl Grogan. All rights reserved.
//

#import "SwipeViewCell.h"

@implementation SwipeViewCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
        
        // Add a subView to hold our content that will be swiped.
        // Create a UIView that is the same width, height, and origin as the cell's content view
        self.swipeContentView = [[UIView alloc] initWithFrame:self.contentView.frame];
        [self.contentView addSubview:self.swipeContentView];
        
        // Some logging output
        // Adding color to the content view to make the layers distinguishable.
        [self.contentView setBackgroundColor:[UIColor blueColor]];
        // Add color to the swipe content view.
        [self.swipeContentView setBackgroundColor:[UIColor redColor]];
        
        // Initialize the pan gesture recognizer.
        // This initializes a UIPanGestureRecognizer where the target is this cell instance where
        // the panning action is handled with the panThisCell method
        UIPanGestureRecognizer *panRecognizer = [[UIPanGestureRecognizer alloc] initWithTarget:self action:@selector(panThisCell:)];
        // Set the recognizer delegate to this cell's instance
        panRecognizer.delegate = self;
        // Adding the recognizer to our swipeContentView
        [self.swipeContentView addGestureRecognizer:panRecognizer];

    }
    return self;
}

- (void)awakeFromNib
{
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

// This method is the handler for the pan gesture we added to the swipeContentView.
// It takes, as a parameter, the instance of the pan gesture recognizer.
- (void)panThisCell:(UIPanGestureRecognizer *)recognizer
{
    // This point represents where the position of the user's finger is relative to where the pan began.
    CGPoint panPoint = [recognizer translationInView:self.swipeContentView];
    NSLog(@"Pan position relative to it's start point: %@", NSStringFromCGPoint(panPoint));
    
    // Here we handle the three states we are looking for.
    switch (recognizer.state) {
        case UIGestureRecognizerStateBegan:{
            NSLog(@"Pan Gesture began.");
            CGPoint translation = [recognizer translationInView:self.swipeContentView];
            // Since we have added the recognizer to the swipContentView above, we can access the view from the recognizer
            // via it's view property.
            recognizer.view.center = CGPointMake(recognizer.view.center.x + translation.x, recognizer.view.center.y);
            // This line resets the translation of the recognizer every time the Began state is triggered.
            [recognizer setTranslation:CGPointMake(0, 0) inView:self.swipeContentView];
        }
            break;
        case UIGestureRecognizerStateChanged:{
            NSLog(@"Pan Gesture changed.");
            CGPoint translation = [recognizer translationInView:self.swipeContentView];
            // Since we have added the recognizer to the swipContentView above, we can access the view from the recognizer
            // via it's view property.
            recognizer.view.center = CGPointMake(recognizer.view.center.x + translation.x, recognizer.view.center.y);
            // This line resets the translation of the recognizer every time the Changed state is triggered.
            [recognizer setTranslation:CGPointMake(0, 0) inView:self.swipeContentView];
        }
            break;
        case UIGestureRecognizerStateEnded:
            NSLog(@"Pan gesture ended.");
            break;
        default:
            NSLog(@"Pan gesture unknown behaviour");
            break;
    }
}

@end
