iOS-TransitionController
========================

A framework to handle custom transitions for iOS7
-------------------------------------------------

Forget to write code to implement **UIViewControllerAnimatedTransitioning** and **UIViewControllerTransitioningDelegate** and start focusing on writing your own transitions only by inheriting from **BMRTransitioner**

Here is a basic diagram about how this solution works
    1. UML Class Basic Diagram
![UML Class Diagram](https://raw.githubusercontent.com/barbaramartina/iOS-TransitionController/master/resources/UML-Diagram.png)


You just need to provide a configuration file, similar to the property list attached to this repo and write your own transitions method:

    1. - (void)executePresentationWithContext:(id<UIViewControllerContextTransitioning>)transitionContext
                              duration:(NSTimeInterval)duration;
    2. - (void)executeDismissalWithContext:(id<UIViewControllerContextTransitioning>)transitionContext
                           duration:(NSTimeInterval)duration;
