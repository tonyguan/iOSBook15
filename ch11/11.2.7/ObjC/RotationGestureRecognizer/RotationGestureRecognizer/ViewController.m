//
//  ViewController.m
//  TapGestureRecognizer
//
//  Created by tony on 2017/3/20.
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
    //垃圾桶旋转角度
    CGFloat rotationAngleInRadians;
}

@property(strong, nonatomic) UIImage *imageTrashFull;
@property(strong, nonatomic) UIImageView *imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //界面初始化
    CGRect screen = [[UIScreen mainScreen] bounds];
    CGFloat imageViewWidth = 128;
    CGFloat imageViewHeight = 128;
    CGFloat imageViewTopView = 300;
    CGRect frame = CGRectMake((screen.size.width - imageViewWidth) / 2, imageViewTopView, imageViewWidth, imageViewHeight);
    self.imageView = [[UIImageView alloc] initWithFrame:frame];
    [self.view addSubview:self.imageView];

    //创建图片对象
    self.imageTrashFull = [UIImage imageNamed:@"Blend Trash Full"];

    self.imageView.image = self.imageTrashFull;

    //创建Rotation手势识别器
    UIRotationGestureRecognizer *recognizer = [[UIRotationGestureRecognizer alloc]
            initWithTarget:self
                    action:@selector(foundRotation:)];

    //Rotation手势识别器关联到imageView
    [self.imageView addGestureRecognizer:recognizer];
    //设置imageView开启用户事件
    self.imageView.userInteractionEnabled = YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)foundRotation:(UIRotationGestureRecognizer *)sender {
    // 上一次角度加上本次旋转的角度
    self.imageView.transform = CGAffineTransformMakeRotation(rotationAngleInRadians + sender.rotation);

    // 手势识别完成，保存旋转的角度
    if (sender.state == UIGestureRecognizerStateEnded) {
        rotationAngleInRadians += sender.rotation;
    }
}

@end
