//
//  ViewController.m
//  VersionAlertView-OC
//
//  Created by haohao on 16/9/30.
//  Copyright © 2016年 haohao. All rights reserved.
//

#import "ViewController.h"
#import "VersionAlertView.h"
@interface ViewController ()
{
    BOOL _needToUpdate;
}
@property (nonatomic, copy) NSString *serveNewVersion;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    self.serveNewVersion = @"1.0.3";
    NSString *currentVersion = [[NSBundle mainBundle] objectForInfoDictionaryKey:@"CFBundleShortVersionString"];
    _needToUpdate = [self compareVersionUpdate:self.serveNewVersion withCurrentVersion:currentVersion];
}

-(BOOL)compareVersionUpdate:(NSString *)serNewVersion withCurrentVersion: (NSString *)currentVersion
{
    NSArray *serVersionArr = [serNewVersion componentsSeparatedByString:@"."];
    NSArray *currentVersionArr = [currentVersion componentsSeparatedByString:@"."];
    
    NSInteger serVersionCount = [[serVersionArr componentsJoinedByString:@""] integerValue];
    NSInteger currentVersionCount = [[currentVersionArr componentsJoinedByString:@""] integerValue];
    if (serVersionArr.count > currentVersionArr.count) {
        currentVersionCount = currentVersionCount * pow(10, serVersionArr.count - currentVersionArr.count);
    }else{
        serVersionCount = serVersionCount * pow(10, currentVersionArr.count - serVersionArr.count);
    }
    if (serVersionCount > currentVersionCount) {
        return YES;
    }else{
        return NO;
    }
}

- (IBAction)btnClick:(id)sender {
    if (_needToUpdate) {
        VersionAlertView *alert = [[VersionAlertView alloc]initWithUpdateDetailArray:@[@"1.这个版本到底更新了什么我不是很清楚",@"2.这个版本到底更新了什么我不是很清楚"] withIsForceUpdate:NO withVersionoStr:[NSString stringWithFormat:@"V%@", self.serveNewVersion] withUpdateURLString:@"haha"];
        [alert show];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
