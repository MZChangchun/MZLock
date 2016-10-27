//
//  PageHeadView.h
//  test
//
//  Created by Mr.Yang on 2016/10/26.
//  Copyright © 2016年 MZ. All rights reserved.
//
//
//仿密码输入界面头灯

#import <UIKit/UIKit.h>

@interface PageHeadView : UIView

@property (nonatomic, assign)NSInteger currentLigheNumber;

- (instancetype)initWithPageNumber:(NSInteger)number;

- (void)addLight;//增加点亮一个
- (void)deleteLight;//减少点亮一个

@end
