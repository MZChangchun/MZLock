//
//  TouchIDManager.h
//  test
//
//  Created by Mr.Yang on 2016/10/24.
//  Copyright © 2016年 MZ. All rights reserved.
//
// 引入“LocalAuthentication”这个库，然后导入#import <LocalAuthentication/LocalAuthentication.h>
#import <Foundation/Foundation.h>
#import <LocalAuthentication/LocalAuthentication.h>
#import "TouchIDResult.h"

typedef void(^touchIDCheck)(TouchIDResult * result);

@interface TouchIDManager : NSObject

@property (nonatomic, strong)touchIDCheck touchCheck;

- (instancetype)initWithBlock:(touchIDCheck)block;

- (void)touchIDChecken:(touchIDCheck)block;

@end
