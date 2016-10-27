//
//  NumberCipherView.m
//  别忘密码
//
//  Created by Mr.Yang on 2016/10/25.
//  Copyright © 2016年 MZ. All rights reserved.
//

#import "NumberCipherView.h"
#import "PageHeadView.h"
#import <AudioToolbox/AudioToolbox.h>

#define VieW self.frame.size.width
#define VieH self.frame.size.height
#define kScreen [UIScreen mainScreen].bounds.size.width
#define WS(weakSelf,Views)  __weak typeof(Views) weakSelf = Views

@interface NumberCipherView()

@property (nonatomic, strong)UILabel * titleLabel;
@property (nonatomic, strong)PageHeadView * pageView;
@property (nonatomic, assign)NSInteger totalPage;
@property (nonatomic, assign)NSInteger currentPage;
@property (nonatomic, strong)NSMutableString * resultString;

@end

@implementation NumberCipherView
- (instancetype)initWithPassNumber:(NSInteger)number {
    self = [super init];
    if (self) {
        self.totalPage = number;
        self.currentPage = 0;
        self.backgroundColor = [UIColor clearColor];
        self.frame = [UIScreen mainScreen].bounds;
        [self createTitleView];
        [self createPageHeadView:number];
        [self createNumberButton];
        [self createDeleteCancelButton];
    }
    return self;
}
- (NSMutableString *)resultString {
    if (!_resultString) {
        _resultString = [NSMutableString string];
    }
    return _resultString;
}
- (void)createTitleView {
    self.titleLabel = [[UILabel alloc] initWithFrame:CGRectMake(0, 70, VieW, 40)];
    self.titleLabel.textAlignment = 1;
    self.titleLabel.font = [UIFont systemFontOfSize:15.0f];
    self.titleLabel.textColor = [UIColor whiteColor];
    [self addSubview:self.titleLabel];
}
- (void)createPageHeadView:(NSInteger)number {
    self.pageView = [[PageHeadView alloc] initWithPageNumber:number];
    self.pageView.center = CGPointMake(CGRectGetMidX(self.frame), 125);
    [self addSubview:self.pageView];
}

- (void)createNumberButton {
    CGFloat widthSpace = (VieW - 260) / 2;
    CGFloat heighSpace = 15.0f;
    CGFloat head = (VieH - 476) / 2;
    int tempNUM = 0;
    
    for (int i = 0; i < 10; i++) {
        tempNUM = i + 1;
        if (9 == i) {
            i = 10;
        }
        
        UIButton * button = [UIButton buttonWithType:UIButtonTypeCustom];
        [button setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"butt_Norman_Numbutt%d", tempNUM]] forState:UIControlStateNormal];
        [button setBackgroundImage:[UIImage imageNamed:[NSString stringWithFormat:@"butt_Click_Number%d", tempNUM]] forState:UIControlStateSelected];
        button.tag = i + 197;
        [button addTarget:self action:@selector(clickButtonAction:) forControlEvents:UIControlEventTouchDown];
        button.frame = CGRectMake(40 + (60 + widthSpace) * (i % 3), head + 140 + (60 + heighSpace) * (i / 3), 60, 60);
        [self addSubview:button];
    }
    
    
}
//创建删除取消按钮
- (void)createDeleteCancelButton {
    UIButton * cancelButt = [[UIButton alloc] initWithFrame:CGRectMake(34, VieH - 51.0, 76, 30)];
    cancelButt.titleLabel.font = [UIFont systemFontOfSize:15.0f];
    [cancelButt setTitle:@"取消" forState:UIControlStateNormal];
    [cancelButt addTarget:self action:@selector(cancelClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:cancelButt];
    
    UIButton * deletelButt = [[UIButton alloc] initWithFrame:CGRectMake(VieW - 110.0, VieH - 51.0, 76, 30)];
    deletelButt.titleLabel.font = [UIFont systemFontOfSize:15.0f];
    [deletelButt setTitle:@"删除" forState:UIControlStateNormal];
    [deletelButt addTarget:self action:@selector(deleteClick) forControlEvents:UIControlEventTouchUpInside];
    [self addSubview:deletelButt];
}
//标题改变
- (void)setTitleMessage:(NSString *)titleMessage {
    if ([titleMessage isEqualToString:_titleMessage ]) {
        return;
    }
    self.titleLabel.text = titleMessage;
    _titleMessage = titleMessage;
}

//取消
- (void)cancelClick {
    if (self.delegate && [self.delegate respondsToSelector:@selector(NumberCancel)]) {
        [self.delegate NumberCancel];
    }
}
//删除
- (void)deleteClick {
    [self.pageView deleteLight];
    if (self.currentPage != 0) {
        self.currentPage -= 1;
        [self.resultString deleteCharactersInRange:NSMakeRange(self.resultString.length - 3, 3)];
    }
}

- (void)clickButtonAction:(UIButton *)butt {
    NSLog(@"");
    [self.pageView addLight];
    [self.resultString appendFormat:@"%ld", (long)butt.tag];
    self.currentPage += 1;
    if (self.currentPage == self.totalPage) {
        
        if (self.delegate && [self.delegate respondsToSelector:@selector(NumberCipherResult:)]) {
            [self.delegate NumberCipherResult:self.resultString];
        }
        self.pageView.currentLigheNumber = 0;
        self.currentPage = 0;
        _resultString = nil;
    }
}

- (void)ErrorTheCipherDouDong {//密码错误抖动
    AudioServicesPlaySystemSound(kSystemSoundID_Vibrate);//调用系统震动
    [UIView animateWithDuration:0.15
                          delay:0
         usingSpringWithDamping:0.8
          initialSpringVelocity:4
                        options:UIViewAnimationOptionCurveLinear
                     animations:^{
                         self.pageView.center = CGPointMake(CGRectGetMidX(self.frame) - 50, 125);
                     } completion:^(BOOL finished) {
                         [UIView animateWithDuration:0.15
                                               delay:0
                              usingSpringWithDamping:0.1
                               initialSpringVelocity:4
                                             options:UIViewAnimationOptionCurveLinear
                                          animations:^{
                                              self.pageView.center = CGPointMake(CGRectGetMidX(self.frame), 125);
                                          } completion:nil];
                     }];
    
}
@end
