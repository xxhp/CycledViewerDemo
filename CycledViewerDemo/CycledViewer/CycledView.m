//
//  CycledView.m
//  CycledViewerDemo
//
//  Created by xiaohaibo on 12-12-23.
//  Copyright (c) 2012年 xiaohaibo. All rights reserved.
//

#import "CycledView.h"

@implementation CycledView
@synthesize title;
@synthesize controller;
@synthesize image;
@synthesize backgroundImage;
@synthesize titleLabel;

-(id)initWithTitle:(NSString *)atitle andImage:(UIImage *)img andDelegate:(id)aDelegate{
    self = [super initWithFrame:CGRectZero];
    if (self) {
        image = [img retain];
        title = [atitle retain];
        controller = aDelegate;
        [self setup];
    }
    return self;
}
/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect
{
    // Drawing code
}
*/
-(void)setup{
    self.backgroundColor = [UIColor blackColor];
    
    backgroundImage = [[UIImageView alloc] initWithFrame:self.bounds];
    backgroundImage.image = image;
    backgroundImage.backgroundColor = [UIColor clearColor];

    [self addSubview:backgroundImage];
    
    titleLabel = [[UILabel alloc] init];
    [titleLabel setFont:[UIFont boldSystemFontOfSize:20]];
    titleLabel.backgroundColor = [UIColor clearColor];
    [titleLabel setFrame:CGRectMake(0, self.frame.size.height - 30 , self.frame.size.width, 40)];
    titleLabel.textColor = [UIColor whiteColor];
    titleLabel.text = bottomTitle;
    titleLabel.textAlignment = NSTextAlignmentCenter;
    [self addSubview:titleLabel];
    
    
    panGuesture = [[UIPanGestureRecognizer alloc] initWithTarget:controller
                                                    action:@selector(handlePanGuesture:)];
    panGuesture.delegate = controller;
    
    [self addGestureRecognizer:panGuesture];
    
}
-(void)layoutSubviews
{
    backgroundImage.frame = self.bounds;
    backgroundImage.image = image;
    titleLabel.frame = CGRectMake(0, self.bounds.size.height - 40 , self.bounds.size.width, 40);
    titleLabel.text = title;
    
    [super layoutSubviews];
}
-(void)dealloc{
    [title release];
    [titleLabel release];
    [image release];
    [backgroundImage release];
    [super dealloc];
}
@end
