//
//  ViewController.m
//  ScreenEdgePanGestureRecognizer
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

@interface ViewController ()
@property(strong, nonatomic) UILabel *label;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //初始化界面
    CGRect screen = [[UIScreen mainScreen] bounds];
    CGFloat labelWidth = 300;
    CGFloat labelHeight = 30;
    CGFloat labelTopView = 150;
    CGRect frame = CGRectMake((screen.size.width - labelWidth) / 2, labelTopView, labelWidth, labelHeight);
    self.label = [[UILabel alloc] initWithFrame:frame];
    self.label.text = @"屏幕边缘平移手势识别";
    //字体左右居中
    self.label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.label];
    
    //创建2个ScreenEdgePan手势识别器
    NSInteger edges[2] = {UIRectEdgeRight, UIRectEdgeLeft};
    for (int i = 0; i < 2; i++) {
        UIScreenEdgePanGestureRecognizer *recognizer = [[UIScreenEdgePanGestureRecognizer alloc]
                                                        initWithTarget:self
                                                        action:@selector(foundScreenEdgePan:)];
        //设置识别边缘平移方向
        recognizer.edges = edges[i];
        //ScreenEdgePan手势识别器关联到View
        [self.view addGestureRecognizer:recognizer];
    }
    
    //设置View开启用户事件
    self.view.userInteractionEnabled = YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)foundScreenEdgePan:(UIScreenEdgePanGestureRecognizer*)sender {
    
    NSLog(@"edge = %li", (unsigned long)sender.edges);
    
    switch (sender.edges) {
        case UIRectEdgeLeft:
            self.label.text = @"从左边缘向右平移";
            break;
        case UIRectEdgeRight:
            self.label.text = @"从右边缘向左平移";
            break;
        default:
            self.label.text = @"";
    }
}

@end
