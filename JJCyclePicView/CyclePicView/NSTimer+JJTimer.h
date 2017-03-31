//
//  NSTimer+JJTimer.h
//  JJCyclePicView
//
//  Created by 罗文琦 on 2017/3/31.
//  Copyright © 2017年 罗文琦. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface NSTimer (JJTimer)

- (void)pauseTimer;
- (void)resumeTimer;
- (void)resumeTimerAfterTimeInterval:(NSTimeInterval)interval;

@end
