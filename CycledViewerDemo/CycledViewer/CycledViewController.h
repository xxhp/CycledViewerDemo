//
//  CycledViewController.h
//  CycledViewerDemo
//
//  Created by xiaohaibo on 12-12-23.
//  Copyright (c) 2012年 xiaohaibo. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "CycledView.h"

@interface CycledViewController : UIView<UIGestureRecognizerDelegate>
{
    NSInteger numberOfItems;
    NSMutableArray *itemViews;  //views
    NSMutableArray *centers;    //center point for each item view;
}

@end
