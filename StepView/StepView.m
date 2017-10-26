//
//  StepView.m
//  StepView
//
//  Created by tangshenchun on 2017/10/26.
//  Copyright © 2017年 Xianjia. All rights reserved.
//

#import "StepView.h"

#define LineUndoColor [UIColor lightGrayColor]
#define LineDoneColor [UIColor greenColor]

@interface StepView()

//整条线的颜色
@property (nonatomic, strong)UIView *lineUndo;
//选中时两点之间的横线颜色
@property (nonatomic, strong)UIView *lineDone;
//存储小圆点的数组
@property (nonatomic, retain) NSMutableArray *cricleMarks;
@property (nonatomic, assign) int totalStepIndex;

@end

@implementation StepView

-(instancetype)initWithFrame:(CGRect)frame totalStepIndex:(int)stepIndex {
    
    if ([super initWithFrame:frame])
    {
        _currentStepIndex = 0;
        self.totalStepIndex = stepIndex;
        
        _lineUndo = [[UIView alloc]init];
        _lineUndo.backgroundColor = LineUndoColor;
        [self addSubview:_lineUndo];
        
        _lineDone = [[UIView alloc]init];
        _lineDone.backgroundColor = LineDoneColor;
        [self addSubview:_lineDone];
        
        for (int i = 0; i < self.totalStepIndex; i++) {
            
            UIView *cricle = [[UIView alloc]initWithFrame:CGRectMake(0, 0, 13, 13)];
            cricle.backgroundColor = [UIColor lightGrayColor];
            cricle.layer.cornerRadius = 13.f / 2;
            [self addSubview:cricle];
            [self.cricleMarks addObject:cricle];
        }
    }
    return self;
    
}

#pragma mark 初始化数组
- (NSMutableArray *)cricleMarks
{
    if (_cricleMarks == nil)
    {
        _cricleMarks = [NSMutableArray arrayWithCapacity:self.totalStepIndex];
    }
    return _cricleMarks;
}

- (void)layoutSubviews
{
    NSInteger perWidth = self.frame.size.width / self.totalStepIndex;
    
    _lineUndo.frame = CGRectMake(0, 0, self.frame.size.width - perWidth, 3);
    _lineUndo.center = CGPointMake(self.frame.size.width / 2, self.frame.size.height / 4);
    
    CGFloat startX = _lineUndo.frame.origin.x;
    
    for (int i = 0; i < self.totalStepIndex; i++)
    {
        UIView *cricle = [_cricleMarks objectAtIndex:i];
        if (cricle != nil)
        {
            cricle.center = CGPointMake(i * perWidth + startX, _lineUndo.center.y);
        }
    }
    
    self.stepIndex = _currentStepIndex;
}


#pragma mark 设置第几步骤

-(void)setStepIndex:(int)stepIndex
{
    if (stepIndex >= 0 && stepIndex < self.totalStepIndex)
    {
        _currentStepIndex = stepIndex;
        
        CGFloat perWidth = self.frame.size.width / self.totalStepIndex;
        
        _lineDone.frame = CGRectMake(_lineUndo.frame.origin.x, _lineUndo.frame.origin.y, perWidth * _currentStepIndex, _lineUndo.frame.size.height);
        
        for (int i = 0; i < self.totalStepIndex; i++)
        {
            UIView *cricle = [_cricleMarks objectAtIndex:i];
            if (cricle != nil)
            {
                if (i <= _currentStepIndex)
                {
                    cricle.backgroundColor = LineDoneColor;
                }
                else
                {
                    cricle.backgroundColor = LineUndoColor;
                }
            }
        }
    }
}

#pragma mark 对外提供的方法
- (void)setStepIndex:(int)stepIndex animation:(BOOL)animation {
    
    if (stepIndex >= 0 && stepIndex < self.totalStepIndex)
    {
        if (animation)
        {
            [UIView animateWithDuration:0.5 animations:^{
                self.stepIndex = stepIndex;
            }];
        }
        else
        {
            self.stepIndex = stepIndex;
        }
    }
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end
