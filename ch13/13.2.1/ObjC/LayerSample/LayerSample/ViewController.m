//
//  ViewController.m
//  LayerSample
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

@property(nonatomic) CALayer *ballLayer;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];

    //创建层ballLayer对象
    self.ballLayer = [CALayer layer];
    
    //读取图片创建UIImage对象
    UIImage *image = [UIImage imageNamed:@"Ball2.png"];
    
    //设置层ballLayer对象
    //设置层内容
    self.ballLayer.contents = (__bridge id)(image.CGImage);
    //设置层内容布局方式
    self.ballLayer.contentsGravity = kCAGravityResizeAspect;
    //设置层的边界
    self.ballLayer.bounds = CGRectMake(0.0, 0.0, 125.0, 125.0);
    //设置层的位置
    self.ballLayer.position = CGPointMake(CGRectGetMidX(self.view.bounds),
                                          CGRectGetMidY(self.view.bounds));
    //添加ballLayer层到当前层
    [self.view.layer addSublayer:self.ballLayer];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
