//
//  StepView.h
//  StepView
//
//  Created by tangshenchun on 2017/10/26.
//  Copyright © 2017年 Xianjia. All rights reserved.
//

#import <UIKit/UIKit.h>

//显示流程步骤视图
@interface StepView : UIView

//默认第几个选中
@property (nonatomic, assign)int currentStepIndex;

/**
 初始化步骤视图
 
 @param frame 坐标
 @param stepIndex 总共几步骤,大于1
 @return instancetype
 */
- (instancetype _Nullable )initWithFrame:(CGRect)frame totalStepIndex:(int)stepIndex;

/**
 设置当前显示步骤
 
 @param stepIndex 当前显示第几步骤
 @param animation 动画
 */
- (void)setStepIndex:(int)stepIndex animation:(BOOL)animation;

@end
