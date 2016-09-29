//
//  MZLockView.m
//  test
//
//  Created by Mr.Yang on 2016/9/28.
//  Copyright © 2016年 MZ. All rights reserved.
//


#import "MZLockView.h"

CGFloat const btCount = 9;
CGFloat const btW = 74;
CGFloat const btH = 74;
int const columnCount = 3;
#define VieW self.frame.size.width
#define VieH self.frame.size.height
#define kScreen [UIScreen mainScreen].bounds.size.width
#define WS(weakSelf,Views)  __weak typeof(Views) weakSelf = Views


@interface MZLockView()

@property (nonatomic, copy)NSMutableArray * array;
@property (nonatomic, assign)CGPoint currentPoint;
@property (nonatomic, strong)NSMutableString * currentPassword;

@end


@implementation MZLockView



#pragma mark-初始化方法
- (instancetype)init {
    self = [super init];
    if (self) {
        self.frame = CGRectMake(0, 0, kScreen, kScreen);
        [self createButton];
    }
    return self;
}
-(instancetype)initWithFrame:(CGRect)frame {
    self = [super initWithFrame:frame];
    if (self) {
        self.frame = CGRectMake(0, 0, kScreen, kScreen);
        [self createButton];
    }
    return self;
}
-(instancetype)initWithCoder:(NSCoder *)aDecoder
{
    self = [super initWithCoder:aDecoder];
    if (self) {
        self.frame = CGRectMake(0, 0, kScreen, kScreen);
        [self createButton];
    }
    return self;
}


-(NSMutableArray *)array {
    if (!_array) {
        _array = [NSMutableArray arrayWithCapacity:0];
    }
    return _array;
}


-(NSMutableString *)currentPassword {
    if (!_currentPassword) {
        _currentPassword = [NSMutableString string];
    }
    return _currentPassword;
}

#pragma mark-创建按钮
//创建按钮
- (void)createButton
{
    
    self.backgroundColor = [UIColor clearColor];
    
    CGFloat height = 0;
    for (int i = 0; i < btCount; i ++) {
        UIButton * but = [UIButton buttonWithType:UIButtonTypeCustom];
        [but setBackgroundImage:[UIImage imageNamed:@"gesture_node_normal"] forState:UIControlStateNormal];
        [but setBackgroundImage:[UIImage imageNamed:@"gesture_node_highlighted"] forState:UIControlStateSelected];
        int row = i / columnCount;
        int column = i % columnCount;
        CGFloat margin = (VieW - btW * columnCount) / (columnCount + 1);
        CGFloat butX = (btW + margin) * column + margin;
        
        CGFloat butY = row * (btH + margin);
        
        but.frame = CGRectMake(butX, butY, btW, btH);
        but.userInteractionEnabled = 0;
        but.tag = i;
        [self addSubview:but];
        
        if (i == (btCount - 1)) {
            height = butY + btH;
        }
    }
}

#pragma mark-触摸方法
- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UIButton * butt = [self pointSelect:touches];
    if (butt && butt.selected == 0) {
        butt.selected = 1;
        [self.array addObject:butt];
    }
}
- (void)touchesMoved:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    UIButton * butt = [self pointSelect:touches];
    if (butt && butt.selected == 0) {
        butt.selected = 1;
        [self.array addObject:butt];
    } else {
        self.currentPoint = [[touches anyObject] locationInView:self];
    }
    [self setNeedsDisplay];
}
- (void)touchesEnded:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    //结束触摸，执行逻辑处理
    [self mzlockresult];
}
- (void)touchesCancelled:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event {
    [self touchesEnded:touches withEvent:event];
}
#pragma mark-取点
//返回当前触摸的按钮
- (UIButton *)pointSelect:(NSSet<UITouch *> *)touches
{
    UITouch * beginTouch = [touches anyObject];
    CGPoint point = [beginTouch locationInView:self];
    for (UIButton * but in self.subviews) {
        if (CGRectContainsPoint(but.frame, point)) {
            return but;
        }
    }
    return nil;
}

#pragma mark-绘图
- (void)drawRect:(CGRect)rect {
    if (0 == self.array.count) {
        return;
    }
    UIBezierPath * path = [UIBezierPath bezierPath];
    path.lineWidth = 8;
    path.lineJoinStyle = kCGLineJoinRound;//线头相交部分样式
    [[UIColor colorWithRed:32/255.0 green:210/255.0 blue:254/255.0 alpha:0.5] set];
    
    WS(weakpath, path);
    [self.array enumerateObjectsUsingBlock:^(UIButton * obj, NSUInteger idx, BOOL * _Nonnull stop) {
        if (0 == idx) {
            [weakpath moveToPoint:obj.center];
        } else {
            [weakpath addLineToPoint:obj.center];
        }
    }];

    [path addLineToPoint:self.currentPoint];
    [path stroke];
}

#pragma mark-结果输出
- (void)mzlockresult {
    //获取当前画出的密码
    self.currentPassword = [NSMutableString stringWithString:@""];
    for (UIButton * butt in self.array) {
        [self.currentPassword appendFormat:@"%ld", (long)butt.tag];
    }
    for (int i = 1; i < self.array.count; i ++) {
        UIButton * but = self.array[i];
        [but setSelected:0];
    }
    //清空所有图
//    [self.array makeObjectsPerformSelector:@selector(setSelected:) withObject:@(NO)];//设置是否选中为no iOS10 失效
    [self.array enumerateObjectsUsingBlock:^(UIButton * obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [obj setSelected:0];
    }];
    
    [self.array removeAllObjects];
    [self setNeedsDisplay];
    
    if (self.delegate && [self.delegate respondsToSelector:@selector(MZLockResult:)]) {
        [self.delegate MZLockResult:self.currentPassword];
    }
    
}
@end
