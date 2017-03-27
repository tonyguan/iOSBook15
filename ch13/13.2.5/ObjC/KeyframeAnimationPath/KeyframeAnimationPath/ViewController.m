//
//  ViewController.m
//  KeyframeAnimationPath
//
//  Created by tony on 2017/3/24.
//  本书网站：http://www.51work6.com
//  智捷课堂在线课堂：http://www.zhijieketang.com/
//  智捷课堂微信公共号：zhijieketang
//  作者微博：@tony_关东升
//  作者微信：tony关东升
//  QQ：569418560 邮箱：eorient@sina.com
//  QQ交流群：162030268
//

#import "ViewController.h"

@interface ViewController () <CAAnimationDelegate>

@property(strong, nonatomic) UIImageView *ball;
@property (strong, nonatomic) UIButton *button;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //界面初始化
    CGRect screen = [[UIScreen mainScreen] bounds];

    CGFloat imageWidth = 50;
    CGFloat imageHeight = 50;
    CGFloat imageTopView = 150;
    CGRect imageFrame = CGRectMake((screen.size.width - imageWidth) / 2, imageTopView, imageWidth, imageHeight);
    //创建Image View对象
    self.ball = [[UIImageView alloc] initWithFrame:imageFrame];
    //设置Image View的图片属性
    self.ball.image = [UIImage imageNamed:@"Ball.png"];
    //添加Image View到当前视图
    [self.view addSubview:self.ball];

    //创建按钮对象
    self.button = [UIButton buttonWithType:UIButtonTypeCustom];
    //设置按钮正常状态时显示图片
    [self.button setImage:[UIImage imageNamed:@"ButtonOutline.png"] forState:UIControlStateNormal];
    //设置按钮高亮状态时显示图片
    [self.button setImage:[UIImage imageNamed:@"ButtonOutlineHighlighted.png"] forState:UIControlStateHighlighted];
    //设置按钮触摸动作输出口
    [self.button addTarget:self action:@selector(onClick:) forControlEvents:UIControlEventTouchUpInside];

    CGFloat buttonWidth = 130;
    CGFloat buttonHeight = 50;
    CGFloat buttonTopView = 400;
    self.button.frame = CGRectMake((screen.size.width - buttonWidth) / 2, buttonTopView, buttonWidth, buttonHeight);
    //添加按钮到当前视图
    [self.view addSubview: self.button];

}

- (void)onClick:(id)sender {
    //设置按钮不可见
    self.button.alpha = 0.0;
    
    //创建路径
    CGMutablePathRef starPath = CGPathCreateMutable();
    CGPathMoveToPoint(starPath,NULL,160.0, 100.0);
    CGPathAddLineToPoint(starPath, NULL, 100.0, 280.0);
    CGPathAddLineToPoint(starPath, NULL, 260.0, 170.0);
    CGPathAddLineToPoint(starPath, NULL, 60.0, 170.0);
    CGPathAddLineToPoint(starPath, NULL, 220.0, 280.0);
    //闭合路径
    CGPathCloseSubpath(starPath);
    
    //创建位置变化的帧动画
    CAKeyframeAnimation *animation = [CAKeyframeAnimation animationWithKeyPath:@"position"];
    //设置动画持续时间
    animation.duration = 10.0;
    //设置self为动画委托对象
    animation.delegate = self;
    //设置动画路径
    animation.path = starPath;
    //释放动画路径对象
    CFRelease(starPath);
    
    [self.ball.layer addAnimation:animation forKey:@"position"];

}

#pragma mark --实现委托协议CAAnimationDelegate
// 动画开始方法
- (void)animationDidStart:(CAAnimation *)anim {
    NSLog(@"动画开始...");
}

// 动画结束方法
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    NSLog(@"动画结束...");
    [UIView animateWithDuration:1.0 animations:^{
        //设置按钮完全可见
        self.button.alpha = 1.0;
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
