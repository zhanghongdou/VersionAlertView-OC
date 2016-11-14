//
//  VersionAlertView.m
//  VersionAlertView-OC
//
//  Created by haohao on 16/9/30.
//  Copyright © 2016年 haohao. All rights reserved.
//

#import "VersionAlertView.h"
@interface VersionAlertView ()
{
    //是否强制更新
    BOOL _isforce;
    NSArray *_detailLabelTextArray;
    NSString *_versionLabelText;
    NSString *_updateStringPath;
}
//头部图片
@property (nonatomic, strong) UIImageView *topImageView;
//立即更新的按钮
@property (nonatomic, strong) UIButton *bottomBtn;
//取消按钮
@property (nonatomic, strong) UIButton *cancelBtn;
//标题
@property (nonatomic, strong) UILabel *titleLabel;
@property (nonatomic, strong) UIView *backView;
@property (nonatomic, strong) UIView *versionView;
//版本号
@property (nonatomic, strong) UILabel *versionLabel;
@property (nonatomic, strong) NSMutableArray *allLabelArray;

@end
@implementation VersionAlertView
-(NSMutableArray *)allLabelArray
{
    if (!_allLabelArray) {
        _allLabelArray = [NSMutableArray array];
    }
    return _allLabelArray;
}

-(UIImageView *)topImageView
{
    if (!_topImageView) {
        _topImageView = [[UIImageView alloc]init];
        _topImageView.image = [UIImage imageNamed:@"wf_appupdate_bg"];
    }
    return _topImageView;
}

-(UIButton *)bottomBtn
{
    if (!_bottomBtn) {
        _bottomBtn = [[UIButton alloc]init];
        [_bottomBtn setBackgroundImage:[UIImage imageNamed:@"wf_appupdate_u"] forState:UIControlStateNormal];
    }
    return _bottomBtn;
}

-(UIButton *)cancelBtn
{
    if (!_cancelBtn) {
        _cancelBtn = [[UIButton alloc]init];
        [_cancelBtn setBackgroundImage:[UIImage imageNamed:@"组-2"] forState:UIControlStateNormal];
    }
    return _cancelBtn;
}
-(UILabel *)titleLabel
{
    if (!_titleLabel) {
        _titleLabel = [[UILabel alloc]init];
        _titleLabel.font = [UIFont systemFontOfSize:17];
        _titleLabel.textAlignment = NSTextAlignmentCenter;
        _titleLabel.text = @"版本更新说明";
    }
    return _titleLabel;
}

-(UIView*)backView
{
    if (!_backView) {
        _backView = [[UIView alloc]initWithFrame:[UIScreen mainScreen].bounds];
        _backView.backgroundColor = [UIColor blackColor];
        _backView.alpha = 0.2;
    }
    return _backView;
}

-(UIView *)versionView
{
    if (!_versionView) {
        _versionView = [[UIView alloc]init];
        _versionView.backgroundColor = [UIColor whiteColor];
        _versionView.clipsToBounds = YES;
        _versionView.layer.cornerRadius = 5.0;
    }
    return _versionView;
}

-(UILabel *)versionLabel
{
    if (!_versionLabel) {
        _versionLabel = [[UILabel alloc]init];
        _versionLabel.backgroundColor = [UIColor clearColor];
        _versionLabel.textAlignment = NSTextAlignmentCenter;
        _versionLabel.textColor = [UIColor whiteColor];
    }
    return _versionLabel;
}



-(id)initWithUpdateDetailArray:(NSArray *)detailArray withIsForceUpdate:(BOOL)isForceUpdate withVersionoStr:(NSString *)versionStr withUpdateURLString:(NSString *)updateURLString
{
    if (self = [super initWithFrame:[UIScreen mainScreen].bounds]) {
        _detailLabelTextArray = [NSArray arrayWithArray:detailArray];
        _isforce = isForceUpdate;
        _updateStringPath = updateURLString;
        _versionLabelText = versionStr;
        [self creatUI];
    }
    return self;
}

-(void)creatUI
{
    if (_isforce) {
        self.cancelBtn.hidden = YES;
    }else{
        self.cancelBtn.hidden = NO;
    }
    [self addSubview:self.backView];
    [self addSubview:self.versionView];
    self.versionView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.versionView addSubview:self.titleLabel];
    self.titleLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.versionView addSubview:self.topImageView];
    self.topImageView.translatesAutoresizingMaskIntoConstraints = NO;
    [self.versionView addSubview:self.cancelBtn];
    self.cancelBtn.translatesAutoresizingMaskIntoConstraints = NO;
    [self.versionView addSubview:self.versionLabel];
    self.versionLabel.translatesAutoresizingMaskIntoConstraints = NO;
    [self.versionView addSubview:self.bottomBtn];
    self.bottomBtn.translatesAutoresizingMaskIntoConstraints = NO;
    
    self.versionLabel.text = _versionLabelText;
    [self.bottomBtn addTarget:self action:@selector(updateRightNow:) forControlEvents:UIControlEventTouchUpInside];
    [self.cancelBtn addTarget:self action:@selector(updateLater:) forControlEvents:UIControlEventTouchUpInside];
    [self creatAllLabel];
    [self setLayout];
}

-(void)creatAllLabel
{
    for (NSString *str in _detailLabelTextArray) {
        UILabel *label = [[UILabel alloc]init];
        label.text = str;
        label.textColor = [UIColor grayColor];
        label.numberOfLines = 0;
        label.font = [UIFont systemFontOfSize:14];
        label.textAlignment = NSTextAlignmentCenter;
        [self.allLabelArray addObject:label];
        [self.versionView addSubview:label];
    }
}
-(void)setLayout
{
    
    NSLayoutConstraint *versionViewLeft = [NSLayoutConstraint constraintWithItem:self.versionView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.backView attribute:NSLayoutAttributeLeft multiplier:1.0f constant:30];
    NSLayoutConstraint *versionViewCenterX = [NSLayoutConstraint constraintWithItem:self.versionView attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.backView attribute:NSLayoutAttributeCenterX multiplier:1.0f constant:0.0f];
    NSLayoutConstraint *versionViewCenterY = [NSLayoutConstraint constraintWithItem:self.versionView attribute:NSLayoutAttributeCenterY relatedBy:NSLayoutRelationEqual toItem:self.backView attribute:NSLayoutAttributeCenterY multiplier:1.0f constant:0.0f];
    NSLayoutConstraint *versionViewRight = [NSLayoutConstraint constraintWithItem:self.versionView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.backView attribute:NSLayoutAttributeRight multiplier:1.0f constant:-30];
    versionViewLeft.active = YES;
    versionViewCenterX.active = YES;
    versionViewCenterY.active = YES;
    versionViewRight.active = YES;
    
    NSLayoutConstraint *topImageViewLeft = [NSLayoutConstraint constraintWithItem:self.topImageView attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.versionView attribute:NSLayoutAttributeLeft multiplier:1.0f constant:0.0f];
    NSLayoutConstraint *topImageViewTop = [NSLayoutConstraint constraintWithItem:self.topImageView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.versionView attribute:NSLayoutAttributeTop multiplier:1.0f constant:0.0f];
    NSLayoutConstraint *topImageViewRight = [NSLayoutConstraint constraintWithItem:self.topImageView attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.versionView attribute:NSLayoutAttributeRight multiplier:1.0f constant:0.0f];
    NSLayoutConstraint *topImageViewHeight = [NSLayoutConstraint constraintWithItem:self.topImageView attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0f constant:180];
    topImageViewLeft.active = YES;
    topImageViewTop.active = YES;
    topImageViewRight.active = YES;
    topImageViewHeight.active = YES;
    
    NSLayoutConstraint *versionLabelCenterX = [NSLayoutConstraint constraintWithItem:self.versionLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.versionView attribute:NSLayoutAttributeCenterX multiplier:1.0f constant:0.0f];
    NSLayoutConstraint *versionLabelBottom = [NSLayoutConstraint constraintWithItem:self.versionLabel attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.topImageView attribute:NSLayoutAttributeBottom multiplier:1.0f constant:-30];
    NSLayoutConstraint *versionLabelHeight = [NSLayoutConstraint constraintWithItem:self.versionLabel attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0f constant:20];
    versionLabelCenterX.active = YES;
    versionLabelBottom.active = YES;
    versionLabelHeight.active = YES;
    
    
    NSLayoutConstraint *cancelBtnWidth = [NSLayoutConstraint constraintWithItem:self.cancelBtn attribute:NSLayoutAttributeWidth relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0f constant:20];
    NSLayoutConstraint *cancelBtnHeight = [NSLayoutConstraint constraintWithItem:self.cancelBtn attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0f constant:20];
    NSLayoutConstraint *cancelBtnRight = [NSLayoutConstraint constraintWithItem:self.cancelBtn attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.versionView attribute:NSLayoutAttributeRight multiplier:1.0f constant:-10];
    NSLayoutConstraint *cancelBtnTop = [NSLayoutConstraint constraintWithItem:self.cancelBtn attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.versionView attribute:NSLayoutAttributeTop multiplier:1.0f constant:10];
    
    cancelBtnWidth.active = YES;
    cancelBtnHeight.active = YES;
    cancelBtnRight.active = YES;
    cancelBtnTop.active = YES;
    
    
    NSLayoutConstraint *titleLabelCenterX = [NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeCenterX relatedBy:NSLayoutRelationEqual toItem:self.versionView attribute:NSLayoutAttributeCenterX multiplier:1.0f constant:0.0f];
    NSLayoutConstraint *titleLabelTop = [NSLayoutConstraint constraintWithItem:self.titleLabel attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.topImageView attribute:NSLayoutAttributeBottom multiplier:1.0f constant:10];
    
    titleLabelCenterX.active = YES;
    titleLabelTop.active = YES;
    
    if (self.allLabelArray.count > 0) {
        if (self.allLabelArray.count == 1) {
            UILabel *label = self.allLabelArray[0];
            label.translatesAutoresizingMaskIntoConstraints = NO;
            NSLayoutConstraint *labelLeft = [NSLayoutConstraint constraintWithItem:label attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.versionView attribute:NSLayoutAttributeLeft multiplier:1.0f constant:10.0f];
            NSLayoutConstraint *labelTop = [NSLayoutConstraint constraintWithItem:label attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.titleLabel attribute:NSLayoutAttributeBottom multiplier:1.0f constant:10.0f];
            NSLayoutConstraint *labelRight = [NSLayoutConstraint constraintWithItem:label attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.versionView attribute:NSLayoutAttributeRight multiplier:1.0f constant:-10.0f];
            
            labelLeft.active = YES;
            labelTop.active = YES;
            labelRight.active = YES;
        }
        
        if (self.allLabelArray.count == 2) {
            UILabel *label1 = self.allLabelArray[0];
            label1.translatesAutoresizingMaskIntoConstraints = NO;
            NSLayoutConstraint *label1Left = [NSLayoutConstraint constraintWithItem:label1 attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.versionView attribute:NSLayoutAttributeLeft multiplier:1.0f constant:10.0f];
            NSLayoutConstraint *label1Top = [NSLayoutConstraint constraintWithItem:label1 attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.titleLabel attribute:NSLayoutAttributeBottom multiplier:1.0f constant:10.0f];
            NSLayoutConstraint *label1Right = [NSLayoutConstraint constraintWithItem:label1 attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.versionView attribute:NSLayoutAttributeRight multiplier:1.0f constant:-10.0f];
            
            label1Left.active = YES;
            label1Top.active = YES;
            label1Right.active = YES;
            
            UILabel *label2 = self.allLabelArray[1];
            label2.translatesAutoresizingMaskIntoConstraints = NO;
            NSLayoutConstraint *label2Left = [NSLayoutConstraint constraintWithItem:label2 attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.versionView attribute:NSLayoutAttributeLeft multiplier:1.0f constant:10.0f];
            NSLayoutConstraint *label2Top = [NSLayoutConstraint constraintWithItem:label2 attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:label1 attribute:NSLayoutAttributeBottom multiplier:1.0f constant:10.0f];
            NSLayoutConstraint *label2Right = [NSLayoutConstraint constraintWithItem:label2 attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.versionView attribute:NSLayoutAttributeRight multiplier:1.0f constant:-10.0f];
            
            label2Left.active = YES;
            label2Top.active = YES;
            label2Right.active = YES;
        }
        
        if (self.allLabelArray.count > 2) {
            
            for (int i = 0; i < self.allLabelArray.count; i++) {
                UILabel *label = self.allLabelArray[i];
                label.translatesAutoresizingMaskIntoConstraints = NO;
                if (i == 0) {
                    
                    NSLayoutConstraint *labelLeft = [NSLayoutConstraint constraintWithItem:label attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.versionView attribute:NSLayoutAttributeLeft multiplier:1.0f constant:10.0f];
                    NSLayoutConstraint *labelTop = [NSLayoutConstraint constraintWithItem:label attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.titleLabel attribute:NSLayoutAttributeBottom multiplier:1.0f constant:10.0f];
                    NSLayoutConstraint *labelRight = [NSLayoutConstraint constraintWithItem:label attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.versionView attribute:NSLayoutAttributeRight multiplier:1.0f constant:-10.0f];
                    
                    labelLeft.active = YES;
                    labelTop.active = YES;
                    labelRight.active = YES;
                }else{
                    UILabel *lastLabel = self.allLabelArray[i - 1];
                    NSLayoutConstraint *labelLeft = [NSLayoutConstraint constraintWithItem:label attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.versionView attribute:NSLayoutAttributeLeft multiplier:1.0f constant:10.0f];
                    NSLayoutConstraint *labelTop = [NSLayoutConstraint constraintWithItem:label attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:lastLabel attribute:NSLayoutAttributeBottom multiplier:1.0f constant:10.0f];
                    NSLayoutConstraint *labelRight = [NSLayoutConstraint constraintWithItem:label attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.versionView attribute:NSLayoutAttributeRight multiplier:1.0f constant:-10.0f];
                    
                    labelLeft.active = YES;
                    labelTop.active = YES;
                    labelRight.active = YES;
                }
            }
        }
        
        NSLayoutConstraint *bottomBtnLeft = [NSLayoutConstraint constraintWithItem:self.bottomBtn attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.versionView attribute:NSLayoutAttributeLeft multiplier:1.0f constant:80.0f];
        NSLayoutConstraint *bottomBtnRight = [NSLayoutConstraint constraintWithItem:self.bottomBtn attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.versionView attribute:NSLayoutAttributeRight multiplier:1.0f constant:-80.0f];
        NSLayoutConstraint *bottomBtnTop = [NSLayoutConstraint constraintWithItem:self.bottomBtn attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.allLabelArray.lastObject attribute:NSLayoutAttributeBottom multiplier:1.0f constant:10.0f];
        NSLayoutConstraint *bottomBtnBottom = [NSLayoutConstraint constraintWithItem:self.bottomBtn attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.versionView attribute:NSLayoutAttributeBottom multiplier:1.0f constant:-10.0f];
        NSLayoutConstraint *bottomBtnHeight = [NSLayoutConstraint constraintWithItem:self.bottomBtn attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0f constant:44.0f];
        
        bottomBtnLeft.active = YES;
        bottomBtnRight.active = YES;
        bottomBtnTop.active = YES;
        bottomBtnBottom.active = YES;
        bottomBtnHeight.active = YES;
    }else{
        NSLayoutConstraint *bottomBtnLeft = [NSLayoutConstraint constraintWithItem:self.bottomBtn attribute:NSLayoutAttributeLeft relatedBy:NSLayoutRelationEqual toItem:self.versionView attribute:NSLayoutAttributeLeft multiplier:1.0f constant:80.0f];
        NSLayoutConstraint *bottomBtnRight = [NSLayoutConstraint constraintWithItem:self.bottomBtn attribute:NSLayoutAttributeRight relatedBy:NSLayoutRelationEqual toItem:self.versionView attribute:NSLayoutAttributeRight multiplier:1.0f constant:-80.0f];
        NSLayoutConstraint *bottomBtnTop = [NSLayoutConstraint constraintWithItem:self.bottomBtn attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.titleLabel attribute:NSLayoutAttributeBottom multiplier:1.0f constant:10.0f];
        NSLayoutConstraint *bottomBtnBottom = [NSLayoutConstraint constraintWithItem:self.bottomBtn attribute:NSLayoutAttributeBottom relatedBy:NSLayoutRelationEqual toItem:self.versionView attribute:NSLayoutAttributeBottom multiplier:1.0f constant:-10.0f];
        NSLayoutConstraint *bottomBtnHeight = [NSLayoutConstraint constraintWithItem:self.bottomBtn attribute:NSLayoutAttributeHeight relatedBy:NSLayoutRelationEqual toItem:nil attribute:NSLayoutAttributeNotAnAttribute multiplier:1.0f constant:44.0f];
        
        bottomBtnLeft.active = YES;
        bottomBtnRight.active = YES;
        bottomBtnTop.active = YES;
        bottomBtnBottom.active = YES;
        bottomBtnHeight.active = YES;
    }
}

-(void)updateRightNow:(UIButton *)sender
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:_updateStringPath]];
}

-(void)updateLater:(UIButton *)sender
{
    for (NSLayoutConstraint *constraint in self.constraints) {
        if (constraint.firstAttribute == NSLayoutAttributeCenterY && constraint.firstItem == self.versionView && constraint.secondItem == self.backView) {
            [self removeConstraint:constraint];
            [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
                self.backView.alpha = 0.05;
                NSLayoutConstraint *versionViewTop = [NSLayoutConstraint constraintWithItem:self.versionView attribute:NSLayoutAttributeTop relatedBy:NSLayoutRelationEqual toItem:self.backView attribute:NSLayoutAttributeBottom multiplier:1.0f constant:0.0f];
                versionViewTop.active = YES;
                [self layoutIfNeeded];
            } completion:^(BOOL finished) {
                [self removeFromSuperview];
            }];
            
        }
    }
}

-(void)show
{
    //注意，这里为了避免windows不存在，所以采用的是下诉方法，如果开发者使用到自己的项目中的时候注意改为[[UIApplication sharedApplication].keyWindow addSubview:self];否则会添加不成功，如果你不明白原因，建议你去了解一下window的层级显示问题
    [[UIApplication sharedApplication].windows[0] addSubview:self];
}
@end
