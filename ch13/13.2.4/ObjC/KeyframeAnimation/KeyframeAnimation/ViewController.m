//
//  ViewController.m
//  KeyframeAnimation
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

@interface ViewController ()

@property(strong, nonatomic) UIImageView *plane;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //界面初始化
    CGRect screen = [[UIScreen mainScreen] bounds];

    CGFloat imageWidth = 100;
    CGFloat imageHeight = 100;
    CGFloat imageTopView = 25;
    CGFloat imageLeftView = 20;
    CGRect imageFrame = CGRectMake(imageLeftView, imageTopView, imageWidth, imageHeight);
    //创建Image View对象plane
    self.plane = [[UIImageView alloc] initWithFrame:imageFrame];
    //设置plane的图片属性
    self.plane.image = [UIImage imageNamed:@"clipartPlane.png"];
    //设置plane视图上的层opacity属性
    self.plane.layer.opacity = 0.25;
    //添加plane到当前视图
    [self.view addSubview:self.plane];

    //创建按钮对象
    UIButton *button = [UIButton buttonWithType:UIButtonTypeCustom];
    //设置按钮正常状态时显示图片
    [button setImage:[UIImage imageNamed:@"ButtonOutline.png"] forState:UIControlStateNormal];
    //设置按钮高亮状态时显示图片
    [button setImage:[UIImage imageNamed:@"ButtonOutlineHighlighted.png"] forState:UIControlStateHighlighted];
    //设置按钮触摸动作输出口
    [button addTarget:self action:@selector(movePlane:) forControlEvents:UIControlEventTouchUpInside];

    CGFloat buttonWidth = 130;
    CGFloat buttonHeight = 50;
    CGFloat buttonTopView = 500;
    button.frame = CGRectMake((screen.size.width - buttonWidth) / 2, buttonTopView, buttonWidth, buttonHeight);
    //添加按钮到当前视图
    [self.view addSubview:button];

}

- (void)movePlane:(id)sender {
    
    //创建opacity的关键帧动画
    CAKeyframeAnimation *opAnim = [CAKeyframeAnimation animationWithKeyPath:@"opacity"];
    //设置动画持续时间
    opAnim.duration = 6.0;
    //设置关键帧时间点
    opAnim.keyTimes = @[@0.0, @0.5, @1.0];
    //设置每个关键帧上的opacity值
    opAnim.values = @[@0.25, @0.75, @1.0];
    //设置动画结束时候处理方式
    opAnim.fillMode = kCAFillModeForwards;
    //设置动画结束时是否停止
    opAnim.removedOnCompletion = NO;
    //添加动画到层
    [self.plane.layer addAnimation:opAnim forKey:@"animateOpacity"];
    
    //创建平移仿射变换
    CGAffineTransform moveTransform = CGAffineTransformMakeTranslation(200, 300);
    //创建平移动画
    CABasicAnimation *moveAnim = [CABasicAnimation animationWithKeyPath:@"transform"];
    moveAnim.duration = 6.0;
    //设置结束位置
    moveAnim.toValue= [NSValue valueWithCATransform3D:
                       CATransform3DMakeAffineTransform(moveTransform)];
    moveAnim.fillMode = kCAFillModeForwards;
    moveAnim.removedOnCompletion = NO;
    [self.plane.layer addAnimation:moveAnim forKey:@"animateTransform"];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
