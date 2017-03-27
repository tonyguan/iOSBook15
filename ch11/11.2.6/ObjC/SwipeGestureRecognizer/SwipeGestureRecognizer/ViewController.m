//
//  ViewController.m
//  SwipeGestureRecognizer
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
    self.label.text = @"Swipe（滑动）手势识别";
    //字体左右居中
    self.label.textAlignment = NSTextAlignmentCenter;
    [self.view addSubview:self.label];

    //创建4个Swipe手势识别器
    NSInteger directions[4] = {UISwipeGestureRecognizerDirectionRight,
            UISwipeGestureRecognizerDirectionLeft,
            UISwipeGestureRecognizerDirectionUp,
            UISwipeGestureRecognizerDirectionDown};
    for (int i = 0; i < 4; i++) {
        UISwipeGestureRecognizer *recognizer = [[UISwipeGestureRecognizer alloc]
                initWithTarget:self
                        action:@selector(foundSwipe:)];
        //设置识别滑动方向
        recognizer.direction = directions[i];
        //Swipe手势识别器关联到View
        [self.view addGestureRecognizer:recognizer];
    }

    //设置View开启用户事件
    self.view.userInteractionEnabled = YES;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)foundSwipe:(UISwipeGestureRecognizer *)sender {

    NSLog(@"direction = %li", sender.direction);

    switch (sender.direction) {
        case UISwipeGestureRecognizerDirectionDown:
            self.label.text = @"向下滑动";
            break;
        case UISwipeGestureRecognizerDirectionLeft:
            self.label.text = @"向左滑动";
            break;
        case UISwipeGestureRecognizerDirectionRight:
            self.label.text = @"向右滑动";
            break;
        case UISwipeGestureRecognizerDirectionUp:
            self.label.text = @"向上滑动";
            break;
        default:
            self.label.text = @"未知";
    }
}

@end
