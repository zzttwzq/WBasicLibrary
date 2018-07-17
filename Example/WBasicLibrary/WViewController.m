//
//  WViewController.m
//  WBasicLibrary
//
//  Created by zzttwzq on 07/06/2018.
//  Copyright (c) 2018 zzttwzq. All rights reserved.
//

#import "WViewController.h"
#import <WBasicLibrary/WBasicHeader.h>
#import "wang.h"

@interface WViewController ()

@end

@implementation WViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.

    UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
    btn.frame = CGRectMake(100, 100, 50, 40);
    btn.backgroundColor = [UIColor redColor];
    [btn addTarget:self action:@selector(click) forControlEvents:UIControlEventTouchUpInside];
    [self.view addSubview:btn];
}

-(void)click
{
//    UIView *view = VIEW_WITH_RECT(100, 100, 100, 100);
//    view.backgroundColor = [UIColor orangeColor];
//    [self.view addSubview:view];

//    [view drawDashLineWithPosition:CGPointMake(0, 0) lineHeight:1 lineWidth:view.width shortLineLength:2 lineSpacing:5 lineColor:[UIColor redColor] isVertical:NO];



    UIViewController *view = [UIViewController new];
    view.showLeftBtn = YES;

    UINavigationController *nav = [[UINavigationController alloc] initWithRootViewController:view];

    [self presentViewController:nav animated:YES completion:nil];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
