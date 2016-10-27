//
//  NumberCipherView.h
//  别忘密码
//
//  Created by Mr.Yang on 2016/10/25.
//  Copyright © 2016年 MZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@class NumberCipherView;
@protocol NumberCipherViewDelegate <NSObject>

@optional
- (void)NumberCipherResult:(NSMutableString *)str;//输入完毕
- (void)NumberCancel; //取消

@end


@interface NumberCipherView : UIView

- (instancetype)initWithPassNumber:(NSInteger)number;

@property (nonatomic, assign)id<NumberCipherViewDelegate> delegate;
@property (nonatomic, copy)NSString * titleMessage;//标题

- (void)ErrorTheCipherDouDong;//密码错误抖动

@end
