//
//  YLImageGif.h
//  YLGIFImageDemo
//
//  Created by v_ljiayili(李嘉艺) on 2017/10/20.
//  Copyright © 2017年 Yong Li. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BSGIFImage : UIImage
///-----------------------
/// @name Image Attributes
///-----------------------

/**
 A C array containing the frame durations.
 
 The number of frames is defined by the count of the `images` array property.
 */
@property (nonatomic, readonly) NSTimeInterval *frameDurations;

/**
 Total duration of the animated image.
 */
@property (nonatomic, readonly) NSTimeInterval totalDuration;

/**
 Number of loops the image can do before it stops
 */
@property (nonatomic, readonly) NSUInteger loopCount;

- (UIImage*)getFrameWithIndex:(NSUInteger)idx;
@end
