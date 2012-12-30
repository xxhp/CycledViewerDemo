//
//  ViewController.m
//  CycledViewerDemo
//
//  Created by xiaohaibo on 12-12-23.
//  Copyright (c) 2012年 xiaohaibo. All rights reserved.
//
#import "CycledViewController.h"
#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
    CycledViewController *vie = [[CycledViewController alloc] initWithFrame:CGRectMake(30, 50, 700, 700)];
    vie.backgroundColor = [UIColor blackColor];
    [self.view addSubview:vie];
    [vie release];
    self.view.backgroundColor = [UIColor darkGrayColor];
    
    UITextView* text = [[UITextView alloc] init];
    [text setFont:[UIFont boldSystemFontOfSize:20]];
    text.backgroundColor = [UIColor clearColor];
    [text setFrame:CGRectMake(220, 500 , 350, 80)];
    text.textColor = [UIColor whiteColor];
    text.editable = NO;
    
    text.text = @"Pan up to see the next image\n Pan down to see the last one";
    text.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:text];
    [text release];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
