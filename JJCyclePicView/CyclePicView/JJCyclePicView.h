//
//  JJCyclePicView.h
//  JJCyclePicView
//
//  Created by 罗文琦 on 2017/3/31.
//  Copyright © 2017年 罗文琦. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface JJCyclePicView : UIView

- (void)setAnimationDuration:(NSTimeInterval)newVar;

- (instancetype)initWithMinFrame:(CGRect)frame;

- (void)initializationUIWithDataArray:(NSArray *)dataArray;

@end
