//
//  CycledView.h
//  CycledViewerDemo
//
//  Created by xiaohaibo on 12-12-23.
//  Copyright (c) 2012年 xiaohaibo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CycledViewController.h"
@class CycledViewController;
@interface CycledView : UIView
{
    UILabel *titleLabel;
    UIImageView *backgroundImage;
    NSString *bottomTitle;
    CycledViewController *controller;
    UIPanGestureRecognizer *panGuesture;
    UIImage *image;
}
@property(nonatomic,retain)UIImage *image;
@property(nonatomic,assign)CycledViewController *controller;
@property(nonatomic,retain)NSString *title;
@property(nonatomic,retain)UILabel *titleLabel;
@property(nonatomic,retain) UIImageView *backgroundImage;

-(id)initWithTitle:(NSString *)title andImage:(UIImage *)img andDelegate:(id)aDelegate;
@end
