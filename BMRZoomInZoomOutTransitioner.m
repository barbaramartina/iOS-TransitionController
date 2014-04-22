//
//  BMRZoomInZoomOutTransitioner.m
//  ProWatermarkMaker
//
//  Created by Barbara Rodeker on 4/22/14.
//  Copyright (c) 2014 Barbara Martina Rodeker. All rights reserved.
//
//  Licensed to the Apache Software Foundation (ASF) under one
//  or more contributor license agreements.  See the NOTICE file
//  distributed with this work for additional information
//  regarding copyright ownership.  The ASF licenses this file
//  to you under the Apache License, Version 2.0 (the "License"); you may not use this file except in compliance
//  with the License.  You may obtain a copy of the License at
//
//  http://www.apache.org/licenses/LICENSE-2.0
//
//  Unless required by applicable law or agreed to in writing,
//  software distributed under the License is distributed on an
//  "AS IS" BASIS, WITHOUT WARRANTIES OR CONDITIONS OF ANY
//  KIND, either express or implied.  See the License for the
//  specific language governing permissions and limitations
//  under the License.
//
#import "BMRZoomInZoomOutTransitioner.h"

/******************************************************************************************/
#pragma mark static values

static  CGFloat const kInitialZoomScaleFactor = 0.0f;
static  CGFloat const kFinalPortraitZoomScaleFactorX = 1.0f;
static  CGFloat const kFinalPortraitZoomScaleFactorY = 0.95f;
static  CGFloat const kFinalLandscapeZoomScaleFactorX = 1.0f;
static  CGFloat const kFinalLandscapeZoomScaleFactorY = 0.86f;


/******************************************************************************************/

@implementation BMRZoomInZoomOutTransitioner


- (void)executePresentationWithContext:(id<UIViewControllerContextTransitioning>)transitionContext
                              duration:(NSTimeInterval)duration
{
    UIViewController* toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController* fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIView *containerView = [transitionContext containerView];
    
    toViewController.view.transform = CGAffineTransformMakeScale(kInitialZoomScaleFactor, kInitialZoomScaleFactor);
    [containerView insertSubview:toViewController.view aboveSubview:fromViewController.view];
    
    [UIView animateWithDuration:duration
                     animations:^{
                         if (UIInterfaceOrientationIsLandscape(toViewController.interfaceOrientation)){
                             toViewController.view.transform = CGAffineTransformMakeScale(kFinalLandscapeZoomScaleFactorX, kFinalLandscapeZoomScaleFactorY);
                         } else {
                             toViewController.view.transform = CGAffineTransformMakeScale(kFinalPortraitZoomScaleFactorX, kFinalPortraitZoomScaleFactorY);
                         }
                     }
                     completion:^(BOOL finished) {
                         [transitionContext completeTransition:YES];
                     }
     ];
}

- (void)executeDismissalWithContext:(id<UIViewControllerContextTransitioning>)transitionContext
                           duration:(NSTimeInterval)duration
{
    UIViewController* toViewController = [transitionContext viewControllerForKey:UITransitionContextToViewControllerKey];
    UIViewController* fromViewController = [transitionContext viewControllerForKey:UITransitionContextFromViewControllerKey];
    UIView *containerView = [transitionContext containerView];
    
    [containerView insertSubview:toViewController.view belowSubview:fromViewController.view];
    
    [UIView animateWithDuration:duration
                     animations:^{
                         fromViewController.view.transform = CGAffineTransformMakeScale(kInitialZoomScaleFactor, kInitialZoomScaleFactor);
                     }
                     completion:^(BOOL finished){
                         [transitionContext completeTransition:YES];
                     }
     ];
}



@end
