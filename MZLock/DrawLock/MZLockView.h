//
//  MZLockView.h
//  test
//
//  Created by Mr.Yang on 2016/9/28.
//  Copyright © 2016年 MZ. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MZLockView;

@protocol MZLockViewDelegate <NSObject>
@optional
- (void)MZLockResult:(NSMutableString *)str;

@end


@interface MZLockView : UIView

@property (nonatomic, assign) id<MZLockViewDelegate>delegate;

@end
