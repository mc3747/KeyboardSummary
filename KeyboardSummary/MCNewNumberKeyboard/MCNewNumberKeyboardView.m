//
//  MCNewNumberKeyboardView.m
//  KeyboardSummary
//
//  Created by gjfax on 2018/8/18.
//  Copyright © 2018年 macheng. All rights reserved.
//

#import "MCNewNumberKeyboardView.h"
//RGB
#define RGBColor(r, g, b) [UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1.0]

//16进制
#define UIColorFromRGBHex(rgbValue)     [UIColor \
colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 \
green:((float)((rgbValue & 0xFF00) >> 8))/255.0 \
blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

//背景颜色
#define COMMON_WANRING_BG_COLOR RGBColor(241, 241, 241)

//警告框 文字颜色
#define COMMON_WANRING_Title_COLOR UIColorFromRGBHex(0xe3415f)
@interface MCNewNumberKeyboardView()
@property (nonatomic, strong) UIView *triangleView;
@property (nonatomic, strong) UILabel *warningLabel;
@end

@implementation MCNewNumberKeyboardView
#pragma mark -  初始化
- (instancetype)initWithFrame:(CGRect)frame andStyle:(NumberTextFieldStyle )textFieldStyle {
    if (self = [super initWithFrame:frame]) {
        [self addTextFieldWithFrame:frame andStyle:textFieldStyle];
        [self addWarningViewWithFrame:frame andStyle:textFieldStyle];
         _warningView.hidden = YES;
        self.clipsToBounds = YES;
    }
    return self;
}

#pragma mark -  输入框
- (void)addTextFieldWithFrame:(CGRect)frame andStyle:(NumberTextFieldStyle )textFieldStyle {
    _textField = [[MCNewNumberKeyboardTextField alloc] initWithFrame:CGRectMake(0, 0, frame.size.width, frame.size.height) andStyle:textFieldStyle];
    _textField.placeholder = @"1,默认";
    [self addSubview:_textField];
}

#pragma mark -  警告框
- (void)addWarningViewWithFrame:(CGRect)frame andStyle:(NumberTextFieldStyle )textFieldStyle {
    
    _warningView = [[UIView alloc] initWithFrame:CGRectMake(0, frame.size.height - 10, frame.size.width, 40)];
    _warningView.backgroundColor = COMMON_WANRING_BG_COLOR;
    [self addSubview:_warningView];
    
    _triangleView = [[UIView alloc] initWithFrame:CGRectMake(0, -10, MAIN_SCREEN_WIDTH, 10)];
    _triangleView.backgroundColor = [UIColor whiteColor];
    [_warningView addSubview:_triangleView];
    
    CAShapeLayer *outlineLayer = [[CAShapeLayer alloc] init];
    outlineLayer.strokeColor = COMMON_WANRING_BG_COLOR.CGColor;
    outlineLayer.lineWidth = 1.0f;
    outlineLayer.fillColor  = COMMON_WANRING_BG_COLOR.CGColor;
    //定义画图的path
    UIBezierPath *path = [[UIBezierPath alloc] init];
    CGPoint point1 = CGPointMake(60, 0);
    CGPoint point2 = CGPointMake(67, 10);
    CGPoint point3 = CGPointMake(53, 10);
    //path移动到开始画图的位置
    [path moveToPoint:point1];
    [path addLineToPoint:point2];
    [path addLineToPoint:point3];
    //关闭path
    [path closePath];
    //三角形内填充颜色
    outlineLayer.path = path.CGPath;
    [_triangleView.layer addSublayer:outlineLayer];
    [_warningView addSubview:_triangleView];
    
    //文字显示
    _warningLabel = [[UILabel alloc] initWithFrame:CGRectMake(120 + 20, 0, MAIN_SCREEN_WIDTH - 20, 30)];
    _warningLabel.textColor = COMMON_WANRING_Title_COLOR;
    _warningLabel.numberOfLines = 2;
    _warningLabel.alpha = 1;
    _warningLabel.font = [UIFont systemFontOfSize:12];
    _warningLabel.textAlignment = NSTextAlignmentLeft;
    
    [_warningView addSubview:_warningLabel];
    
    [self addSubview:_warningView];
}
#pragma mark -  显示警告
- (void)showWarningView:(NSString *)text {
    _warningView.hidden = NO;
    _warningLabel.text = text;
    
}
#pragma mark -  隐藏警告
- (void)hideWarningView {
    _warningView.hidden = YES;
}
@end
