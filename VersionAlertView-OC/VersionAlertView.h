//
//  VersionAlertView.h
//  VersionAlertView-OC
//
//  Created by haohao on 16/9/30.
//  Copyright © 2016年 haohao. All rights reserved.
//

#import <UIKit/UIKit.h>
@interface VersionAlertView : UIView
-(id)initWithUpdateDetailArray:(NSArray *)detailArray withIsForceUpdate:(BOOL)isForceUpdate withVersionoStr:(NSString *)versionStr withUpdateURLString:(NSString *)updateURLString;
-(void)show;
@end
