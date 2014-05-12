//
//  ViewController.m
//  TestApp
//
//  Created by TopTierLabs on 4/25/14.
//  Copyright (c) 2014 ___FULLUSERNAME___. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()

@end

@implementation ViewController

- (void)viewDidLoad
{
    [super viewDidLoad];
	// Do any additional setup after loading the view, typically from a nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(IBAction) appear{
    [helloWorld setText:@"Hello World!"];
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"http://facebook.com"]];
}

@end
