//
//  TouchIDResult.h
//  test
//
//  Created by Mr.Yang on 2016/10/24.
//  Copyright © 2016年 MZ. All rights reserved.
//

#import <Foundation/Foundation.h>


@interface TouchIDResult : NSObject
@property (nonatomic, assign)BOOL resultSuccess;
@property (nonatomic, copy)NSString * reason;
@property (nonatomic, assign)NSInteger code;
@end
