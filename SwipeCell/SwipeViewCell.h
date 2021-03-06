//
//  SwipeViewCell.h
//  SwipeCell
//
//  Created by Karl Grogan on 13/09/2014.
//  Copyright (c) 2014 Karl Grogan. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface SwipeViewCell : UITableViewCell

@property UIView *swipeContentView;
@property UIPanGestureRecognizer *panRecognizer;
@property UILabel *numberView;
@property int amount;

@end
