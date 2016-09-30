//
//  VersionAlertView.h
//  VersionAlertView-OC
//
//  Created by 爱利是 on 16/9/30.
//  Copyright © 2016年 haohao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "Masonry.h"
@interface VersionAlertView : UIView
-(id)initWithUpdateDetailArray:(NSArray *)detailArray withIsForceUpdate:(BOOL)isForceUpdate withVersionoStr:(NSString *)versionStr withUpdateURLString:(NSString *)updateURLString;
-(void)show;
@end
