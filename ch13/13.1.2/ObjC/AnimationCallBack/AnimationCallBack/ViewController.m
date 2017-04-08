//
//  ViewController.m
//  AnimationBlock
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

@interface ViewController () {
    //小球运动方向标志，1表示向下运行，-1表示向上运行
    int flag;
}

@property(nonatomic) UIImageView *ball;
@property(nonatomic) UIButton *button;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //初始化小球运动方向标志
    flag = 1;
    
    //界面初始化
    CGRect screen = [[UIScreen mainScreen] bounds];

    CGFloat imageWidth = 86;
    CGFloat imageHeight = 86;
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
    CGFloat buttonTopView = 500;
    self.button.frame = CGRectMake((screen.size.width - buttonWidth) / 2, buttonTopView, buttonWidth, buttonHeight);
    //添加按钮到当前视图
    [self.view addSubview:self.button];

}

- (void)onClick:(id)sender {
    
    //动画开始将按钮设置为不可见
    self.button.alpha = 0.0;

    [UIView animateWithDuration:1.5 animations:^{
        CGRect frame = self.ball.frame;
        frame.origin.y += 200 * flag;
        flag *= -1; //取反
        self.ball.frame = frame;
    } completion:^(BOOL finished) {
        NSLog(@"动画结束了。");
        [self viewAnimationDone];
    }];
    
}

//动画结束之后的处理
- (void)viewAnimationDone {
    //为按钮显示过程添加动画
    [UIView animateWithDuration:1. animations:^{
        //动画结束后将按钮设置为可见
        self.button.alpha = 1.0;
    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
