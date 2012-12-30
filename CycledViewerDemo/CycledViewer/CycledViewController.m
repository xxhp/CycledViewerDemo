//
//  CycledViewController.m
//  CycledViewerDemo
//
//  Created by xiao haibo on 12-12-23.
//  Copyright (c) 2012年 xiaohaibo. All rights reserved.
//
//
//  github:https://github.com/xxhp/CycledViewerDemo
//  Email:xiao_hb@qq.com

//  Permission is hereby granted, free of charge, to any person
//  obtaining a copy of this software and associated documentation
//  files (the "Software"), to deal in the Software without
//  restriction, including without limitation the rights to use,
//  copy, modify, merge, publish, distribute, sublicense, and/or sell
//  copies of the Software, and to permit persons to whom the
//  Software is furnished to do so, subject to the following
//  conditions:
//
//  The above copyright notice and this permission notice shall be
//  included in all copies or substantial portions of the Software.
//
//  THE SOFTWARE IS PROVIDED "AS IS", WITHOUT WARRANTY OF ANY KIND,
//  EXPRESS OR IMPLIED, INCLUDING BUT NOT LIMITED TO THE WARRANTIES
//  OF MERCHANTABILITY, FITNESS FOR A PARTICULAR PURPOSE AND
//  NONINFRINGEMENT. IN NO EVENT SHALL THE AUTHORS OR COPYRIGHT
//  HOLDERS BE LIABLE FOR ANY CLAIM, DAMAGES OR OTHER LIABILITY,
//  WHETHER IN AN ACTION OF CONTRACT, TORT OR OTHERWISE, ARISING
//  FROM, OUT OF OR IN CONNECTION WITH THE SOFTWARE OR THE USE OR
//  OTHER DEALINGS IN THE SOFTWARE.
//

#define defaultItmesNumber 5
#define defaultHeight 400
#define defaultWideth 700
#define kScaleFactor (1.0/(numberOfItems-1))
#import "CycledViewController.h"
#import <QuartzCore/QuartzCore.h>

@implementation CycledViewController

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        numberOfItems = defaultItmesNumber;
        itemViews= [[NSMutableArray alloc]initWithCapacity:1];
        centers = [[NSMutableArray alloc]initWithCapacity:1];
        [self setup];
    }
    return self;
}
-(void)dealloc{
    [itemViews release];
    [centers release];
    [super dealloc];
}
-(void)setup{
    
    for (int i = 0;i< numberOfItems ;i++) {
        CycledView *item=[[CycledView alloc] initWithTitle:[NSString stringWithFormat:@"Image %d",i] andImage:[UIImage imageNamed:[NSString stringWithFormat:@"%d.png",i+1]] andDelegate:self];
        
        [itemViews addObject:item];
        [item release];
    }
    [self caculateInitState];
    
}

-(void)caculateInitState{
   
    CGPoint center = CGPointMake(self.bounds.size.width/2, self.bounds.size.height/2);
    for (NSInteger itemIndex = 0; itemIndex < numberOfItems; itemIndex++) {
    
        CycledView *item = [itemViews objectAtIndex:itemIndex];
        item.frame = CGRectMake(0, 0, defaultWideth, defaultHeight);;
        item.center = center;
        item.controller = self;
        [UIView setAnimationsEnabled:NO];
        item.transform = CGAffineTransformScale(CGAffineTransformIdentity, kScaleFactor+0.25*itemIndex,kScaleFactor+0.25*itemIndex);
        center.y -= 45;
        [UIView setAnimationsEnabled:YES];
        [self addSubview:item];
        item.userInteractionEnabled = FALSE;
        if (itemIndex==numberOfItems-1) {
            item.userInteractionEnabled = TRUE;
        }

        
    }
    for (CycledView *item in itemViews) {
        [centers addObject:[NSValue valueWithCGPoint:item.center]];
    }
    [self slideUp];
    
}
-(void)reloadViews{
    CGPoint center = CGPointZero;
    for (NSInteger itemIndex = 0; itemIndex < numberOfItems; itemIndex++) {
        center = [[centers objectAtIndex:itemIndex] CGPointValue];
        CycledView *item = [itemViews objectAtIndex:itemIndex];
        if (YES) {
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
            [UIView setAnimationDelay:0.3];
            item.center = center;
            item.controller = self;
            [UIView commitAnimations];
            
        }
        item.userInteractionEnabled = NO;
        if (itemIndex==numberOfItems-1) {
            item.userInteractionEnabled = YES;
        }
        [self addSubview:item];
        item.hidden = NO;
        
    }
}


- (void)animationDidStop:(CAAnimation *)theAnimation finished:(BOOL)flag{
    NSString* value = [theAnimation valueForKey:@"position"];
    if ([value isEqualToString:@"slideup"])
    {
        
        CycledView *item  = [[itemViews lastObject] retain];
        item.hidden = YES;
        [item removeFromSuperview];
        
        //temporarily disable animation
        [UIView setAnimationsEnabled:NO];
        item.transform = CGAffineTransformMakeScale( 0.10, 0.10);
        item.center = CGPointMake([[centers objectAtIndex:0] CGPointValue].x, [[centers objectAtIndex:0] CGPointValue].y-20);
        [UIView setAnimationsEnabled:YES];
      

        for (NSInteger itemIndex = 0; itemIndex < numberOfItems-1; itemIndex++) {
            CycledView *item= [itemViews objectAtIndex:itemIndex];
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
            [UIView setAnimationDelay:0.3];
            item.transform = CGAffineTransformScale(CGAffineTransformIdentity, kScaleFactor+0.15*itemIndex,kScaleFactor+0.15*itemIndex);
            [UIView commitAnimations];
        }
    
        
        [itemViews removeObject:item];
        [itemViews insertObject:item atIndex:0];
        [item release];
        [self reloadViews];
        return;
        
    }
    
    
    if ([value isEqualToString:@"slidedown"])
    {
       
        for (NSInteger itemIndex = 0; itemIndex < numberOfItems-1; itemIndex++) {
            
             CycledView *item = [itemViews objectAtIndex:itemIndex];
            [UIView beginAnimations:nil context:nil];
            [UIView setAnimationCurve:UIViewAnimationCurveEaseInOut];
            [UIView setAnimationDelay:0.3];
            item.transform = CGAffineTransformScale(CGAffineTransformIdentity, kScaleFactor+0.15*itemIndex-0.15,kScaleFactor+0.15*itemIndex-0.15);
            [UIView commitAnimations];
        }
        
        [self reloadViews];
        
        return;
    }

}
- (void)slideDown{
   
    CycledView *fistItem  = [[itemViews objectAtIndex:0] retain];
    [itemViews removeObjectAtIndex:0];
    [fistItem removeFromSuperview];
    fistItem.hidden = NO;
    [itemViews addObject:fistItem];
    [fistItem release];
    //temporarily disable animation 
    [UIView setAnimationsEnabled:NO];
    CycledView *lastItem  = [itemViews lastObject];
    CGPoint ce = [[centers lastObject] CGPointValue];
    lastItem.transform = CGAffineTransformScale(CGAffineTransformIdentity, kScaleFactor+0.15*(numberOfItems-2),kScaleFactor+0.15*(numberOfItems - 2));
    lastItem.center = CGPointMake(ce.x,ce.y-self.bounds.size.height);
    [UIView setAnimationsEnabled:YES];
    
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
    [animation setValue:@"slidedown" forKey:@"position"];
    animation.fromValue = [NSValue valueWithCGPoint:CGPointMake(ce.x,ce.y-self.bounds.size.height)];
    animation.toValue = [NSValue valueWithCGPoint:ce];
    animation.timingFunction =  [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.duration = 0.5;
    [animation setDelegate:self];
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = NO;
    [lastItem.layer addAnimation:animation forKey:@"position"];
    
}
- (void)slideUp{
    
    CycledView *item  = [itemViews lastObject];
    CABasicAnimation *animation = [CABasicAnimation animationWithKeyPath:@"position"];
    [animation setValue:@"slideup" forKey:@"position"];
    animation.fromValue = [NSValue valueWithCGPoint:item.center];
    animation.toValue = [NSValue valueWithCGPoint:CGPointMake(item.center.x,item.center.y-self.bounds.size.height)];
    animation.timingFunction =  [CAMediaTimingFunction functionWithName:kCAMediaTimingFunctionEaseInEaseOut];
    animation.duration = 0.5;
    [animation setDelegate:self];
    animation.fillMode = kCAFillModeForwards;
    animation.removedOnCompletion = NO;
    [item.layer addAnimation:animation forKey:@"position"];
    
    
    
}
#pragma mark -
#pragma mark UIPanGestureRecognizer
- (void)handlePanGuesture:(UIPanGestureRecognizer *)sender {
	
    CycledView *panItem = (CycledView *)sender.view;
    if (sender.state ==  UIGestureRecognizerStateChanged) {
        CGPoint position = [sender translationInView:self];
        CGPoint center = CGPointMake(sender.view.center.x , sender.view.center.y+position.y);
       
        if (center.y  < self.bounds.size.height/2 + panItem.frame.size.height/2-20 &&  center.y > 0) {
            sender.view.center = center;
            [sender setTranslation:CGPointZero inView:self];
        }
    }
    else if (sender.state == UIGestureRecognizerStateEnded) {
        
        CGFloat toggleCenter = CGRectGetMidY(panItem.frame);
        if (toggleCenter<20) {
            [self slideUp];
        }
        else if(toggleCenter>460){
            [self slideDown];
        }
        else{
            panItem.center = [[centers objectAtIndex:numberOfItems-1] CGPointValue];
        }
        
    }
    
}


@end

