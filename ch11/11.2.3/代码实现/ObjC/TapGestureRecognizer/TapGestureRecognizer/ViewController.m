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

@interface ViewController ()
{
    BOOL boolTrashEmptyFlag;//垃圾桶是否为空标志：NO-桶满；YES-桶空
}

@property (strong, nonatomic) UIImage *imageTrashFull;
@property (strong, nonatomic) UIImage *imageTrashEmpty;

@property (strong, nonatomic) UIImageView *imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    //界面初始化
    CGRect screen = [[UIScreen mainScreen] bounds];
    CGFloat imageViewWidth = 128;
    CGFloat imageViewHeight = 128;
    CGFloat imageViewTopView = 148;
    CGRect frame = CGRectMake((screen.size.width - imageViewWidth)/2 , imageViewTopView, imageViewWidth, imageViewHeight);
    self.imageView = [[UIImageView alloc] initWithFrame:frame];
    [self.view addSubview:self.imageView];

    //创建图片对象
    self.imageTrashFull = [UIImage imageNamed:@"Blend Trash Full"];
    self.imageTrashEmpty = [UIImage imageNamed:@"Blend Trash Empty"];
    
    self.imageView.image = self.imageTrashFull;
    
    //创建Tap手势识别器
    UITapGestureRecognizer *tapRecognizer =[[UITapGestureRecognizer alloc]
                                            initWithTarget:self
                                            action:@selector(foundTap:)];
    //设置Tap手势识别器属性
    tapRecognizer.numberOfTapsRequired = 1;
    tapRecognizer.numberOfTouchesRequired = 1;
    
    //Tap手势识别器关联到imageView
    [self.imageView addGestureRecognizer:tapRecognizer];
    //设置imageView开启用户事件
    self.imageView.userInteractionEnabled = YES;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (void)foundTap:(id)sender {
    NSLog(@"Tap");
    if (boolTrashEmptyFlag) {
        self.imageView.image = self.imageTrashFull;
        boolTrashEmptyFlag = NO;
    } else {
        self.imageView.image = self.imageTrashEmpty;
        boolTrashEmptyFlag = YES;
    }
}


@end
