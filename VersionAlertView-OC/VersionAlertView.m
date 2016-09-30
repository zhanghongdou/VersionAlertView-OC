//
//  VersionAlertView.m
//  VersionAlertView-OC
//
//  Created by 爱利是 on 16/9/30.
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
    [self.versionView addSubview:self.titleLabel];
    [self.versionView addSubview:self.topImageView];
    [self.versionView addSubview:self.cancelBtn];
    [self.versionView addSubview:self.versionLabel];
    [self.versionView addSubview:self.bottomBtn];
    
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
    [self.versionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.backView.mas_left).offset(30);
        make.center.equalTo(self.backView);
        make.right.equalTo(self.backView.mas_right).offset(-30);
    }];

    [self.topImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.versionView);
        make.right.equalTo(self.versionView);
        make.top.equalTo(self.versionView);
        make.height.equalTo(@(180));
    }];
    
    [self.versionLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.versionView);
        make.bottom.equalTo(self.topImageView.mas_bottom).offset(-30);
        make.height.equalTo(@(20));
    }];

    [self.cancelBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.size.equalTo([NSValue valueWithCGSize:CGSizeMake(20, 20)]);
        make.right.equalTo(self.versionView.mas_right).offset(-10);
        make.top.equalTo(self.versionView.mas_top).offset(10);
    }];

    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.equalTo(self.versionView);
        make.top.equalTo(self.topImageView.mas_bottom).offset(10);
    }];

    
    if (self.allLabelArray.count > 0) {
        if (self.allLabelArray.count == 1) {
            UILabel *label = self.allLabelArray[0];
            [label mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.versionView.mas_left).offset(10);
                make.right.equalTo(self.versionView.mas_right).offset(-10);
                make.top.equalTo(self.titleLabel.mas_bottom).offset(10);
            }];
        }

        if (self.allLabelArray.count == 2) {
            UILabel *label1 = self.allLabelArray[0];
            [label1 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.versionView.mas_left).offset(10);
                make.right.equalTo(self.versionView.mas_right).offset(-10);
                make.top.equalTo(self.titleLabel.mas_bottom).offset(10);
            }];
            
            UILabel *label2 = self.allLabelArray[1];
            [label2 mas_makeConstraints:^(MASConstraintMaker *make) {
                make.left.equalTo(self.versionView.mas_left).offset(10);
                make.right.equalTo(self.versionView.mas_right).offset(-10);
                make.top.equalTo(label1.mas_bottom).offset(10);
            }];
        }

        if (self.allLabelArray.count > 2) {
            
            for (int i = 0; i < self.allLabelArray.count; i++) {
                UILabel *label = self.allLabelArray[i];
                if (i == 0) {
                    [label mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.left.equalTo(self.versionView.mas_left).offset(10);
                        make.right.equalTo(self.versionView.mas_right).offset(-10);
                        make.top.equalTo(self.titleLabel.mas_bottom).offset(10);
                    }];
                }else{
                    UILabel *lastLabel = self.allLabelArray[i - 1];
                    [label mas_makeConstraints:^(MASConstraintMaker *make) {
                        make.left.equalTo(self.versionView.mas_left).offset(10);
                        make.right.equalTo(self.versionView.mas_right).offset(-10);
                        make.top.equalTo(lastLabel.mas_bottom).offset(10);
                    }];
                }
            }
        }
        
        [self.bottomBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.versionView.mas_left).offset(80);
            make.right.equalTo(self.versionView.mas_right).offset(-80);
            make.top.equalTo([self.allLabelArray.lastObject mas_bottom]).offset(10);
            make.bottom.equalTo(self.versionView.mas_bottom).offset(-10);
            make.height.equalTo(@(44));
        }];
        
    }else{
        [self.bottomBtn mas_makeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.versionView.mas_left).offset(80);
            make.right.equalTo(self.versionView.mas_right).offset(-80);
            make.top.equalTo(self.titleLabel.mas_bottom).offset(10);
            make.bottom.equalTo(self.versionView.mas_bottom).offset(-10);
            make.height.equalTo(@(44));
        }];
    }
}

-(void)updateRightNow:(UIButton *)sender
{
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:_updateStringPath]];
}

-(void)updateLater:(UIButton *)sender
{
    [UIView animateWithDuration:0.3 delay:0 options:UIViewAnimationOptionCurveLinear animations:^{
        [self.versionView mas_remakeConstraints:^(MASConstraintMaker *make) {
            make.left.equalTo(self.backView.mas_left).offset(30);
            make.right.equalTo(self.backView.mas_right).offset(-30);
            make.centerX.equalTo(self.backView);
            make.top.equalTo(self.backView.mas_bottom);
        }];
        [self layoutIfNeeded];
    } completion:^(BOOL finished) {
        [self removeFromSuperview];
    }];
}

-(void)show
{
    [[UIApplication sharedApplication].windows[0] addSubview:self];
    [self.versionView mas_remakeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(self.backView.mas_left).offset(30);
        make.center.equalTo(self.backView);
        make.right.equalTo(self.backView.mas_right).offset(-30);
    }];
}
@end
