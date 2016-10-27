//
//  PageHeadView.m
//  test
//
//  Created by Mr.Yang on 2016/10/26.
//  Copyright © 2016年 MZ. All rights reserved.
//

#import "PageHeadView.h"

@interface PageHeadView()

@property (nonatomic, assign)NSInteger totalNumber;
@property (nonatomic, strong)NSMutableArray * pointArray;

@end
@implementation PageHeadView

- (void)setCurrentLigheNumber:(NSInteger)currentLigheNumber {
    if (_currentLigheNumber == currentLigheNumber) {
        return;
    }
    _currentLigheNumber = currentLigheNumber;
    [self setNeedsDisplay];
}

- (instancetype)initWithPageNumber:(NSInteger)number {
    self = [super init];
    if (self) {
        self.bounds = CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, 30);
        self.backgroundColor = [UIColor clearColor];
        
        NSInteger temp = floor(([UIScreen mainScreen].bounds.size.width - 20) / 38);
        self.totalNumber = number > temp ? temp : number;
        //创建位置数组
        [self createPointArray:self.totalNumber];
        
        self.currentLigheNumber = 0;
        [self setNeedsDisplay];
        
    }
    return self;
}
- (void)createPointArray:(NSInteger)number {
    self.pointArray = [NSMutableArray arrayWithCapacity:0];
    for (int i = 0; i < number; i ++) {
        [self.pointArray addObject:[NSNumber numberWithFloat:[UIScreen mainScreen].bounds.size.width/2.0 + 10 - 19 * number + i * 38]];
    }
}

- (void)addLight {
    if (_currentLigheNumber == self.totalNumber) {
        return;
    }
    self.currentLigheNumber += 1;
}
- (void)deleteLight {
    if (_currentLigheNumber == 0) {
        return;
    }
    self.currentLigheNumber -= 1;
}

- (void)drawRect:(CGRect)rect {
    
    for (int i = 0; i < _currentLigheNumber; i++) {
        UIBezierPath * path = [UIBezierPath bezierPathWithArcCenter:CGPointMake([self.pointArray[i] floatValue], 15)
                                                             radius:9.0f
                                                         startAngle:0
                                                           endAngle:M_PI * 2
                                                          clockwise:1];
        [[UIColor colorWithRed:95/255.0 green:118/255.0 blue:154/255.0 alpha:1] setFill];
        [path stroke];
        [path fill];
    }
    
    for (int j = (int)_currentLigheNumber; j < _totalNumber; j++) {
        UIBezierPath * path = [UIBezierPath bezierPathWithArcCenter:CGPointMake([self.pointArray[j] floatValue], 15)
                                                             radius:9.0f
                                                         startAngle:0
                                                           endAngle:M_PI * 2
                                                          clockwise:1];
        [path setLineWidth:1];
        [[UIColor colorWithRed:95/255.0 green:118/255.0 blue:154/255.0 alpha:1] setStroke];
        [path stroke];
    }
    
}



@end
