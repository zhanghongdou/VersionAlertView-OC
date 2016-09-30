//
//  ViewController.m
//  VersionAlertView-OC
//
//  Created by 爱利是 on 16/9/30.
//  Copyright © 2016年 haohao. All rights reserved.
//

#import "ViewController.h"
#import "VersionAlertView.h"
@interface ViewController ()
@property (nonatomic, strong) VersionAlertView *alert;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.alert = [[VersionAlertView alloc]initWithUpdateDetailArray:@[@"1.这个版本到底更新了什么我不是很清楚",@"2.这个版本到底更新了什么我不是很清楚"] withIsForceUpdate:NO withVersionoStr:@"V5.0.2" withUpdateURLString:@"haha"];
}
- (IBAction)btnClick:(id)sender {
    [self.alert show];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
