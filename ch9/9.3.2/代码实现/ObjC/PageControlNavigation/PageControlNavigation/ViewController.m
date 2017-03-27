//
//  ViewController.m
//  PageControlNavigation
//
//  Created by 关东升 on 2016-11-18.
//  本书网站：http://www.51work6.com
//  智捷课堂在线课堂：http://www.zhijieketang.com/
//  智捷课堂微信公共号：zhijieketang
//  作者微博：@tony_关东升
//  作者微信：tony关东升
//  QQ：569418560 邮箱：eorient@sina.com
//  QQ交流群：162030268
//


#import "ViewController.h"

//定义获取屏幕宽度宏
#define S_WIDTH [[UIScreen mainScreen] bounds].size.width
//定义获取屏幕高度宏
#define S_HEIGHT [[UIScreen mainScreen] bounds].size.height

@interface ViewController () <UIScrollViewDelegate>

@property (strong, nonatomic) UIScrollView *scrollView;
@property (strong, nonatomic) UIPageControl *pageControl;

@property (strong, nonatomic) UIImageView *imageView1;
@property (strong, nonatomic) UIImageView *imageView2;
@property (strong, nonatomic) UIImageView *imageView3;

- (void)changePage:(id)sender;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    self.scrollView = [[UIScrollView alloc] init];
    [self.view addSubview:self.scrollView];
    
    self.scrollView.delegate = self;
    self.scrollView.pagingEnabled = TRUE;
    self.scrollView.showsHorizontalScrollIndicator = FALSE;
    self.scrollView.showsVerticalScrollIndicator = FALSE;
    
    self.scrollView.contentSize = CGSizeMake(S_WIDTH * 3, S_HEIGHT);
    self.scrollView.frame = self.view.frame;
    
    self.imageView1 = [[UIImageView alloc] initWithFrame:CGRectMake(0.0f, 0.0f, S_WIDTH, S_HEIGHT)];
    self.imageView1.image = [UIImage imageNamed:@"达芬奇-蒙娜丽莎.png"];
    
    self.imageView2 = [[UIImageView alloc] initWithFrame:CGRectMake(S_WIDTH, 0.0f, S_WIDTH, S_HEIGHT)];
    self.imageView2.image = [UIImage imageNamed:@"罗丹-思想者.png"];
    
    self.imageView3 = [[UIImageView alloc] initWithFrame:CGRectMake(2 * S_WIDTH, 0.0f, S_WIDTH, S_HEIGHT)];
    self.imageView3.image = [UIImage imageNamed:@"保罗克利-肖像.png"];
    
    [self.scrollView addSubview:self.imageView1];
    [self.scrollView addSubview:self.imageView2];
    [self.scrollView addSubview:self.imageView3];
    
    CGFloat pageControlWidth  = 300.0;
    CGFloat pageControlHeight = 37.0;
    self.pageControl = [[UIPageControl alloc]
                        initWithFrame:CGRectMake((S_WIDTH - pageControlWidth) / 2, S_HEIGHT - pageControlHeight, pageControlWidth, pageControlHeight)];
    self.pageControl.numberOfPages = 3;
    [self.pageControl addTarget:self action:@selector(changePage:) forControlEvents: UIControlEventValueChanged];
    [self.view addSubview:self.pageControl];
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}


#pragma mark --实现UIScrollViewDelegate委托协议
- (void) scrollViewDidScroll: (UIScrollView *) scrollView {
    CGPoint offset = scrollView.contentOffset;
    self.pageControl.currentPage = offset.x / S_WIDTH;
}

#pragma mark --实现UIPageControl事件处理
- (void)changePage:(id)sender {
    [UIView animateWithDuration:0.3f animations:^{
        NSInteger whichPage = self.pageControl.currentPage;
        self.scrollView.contentOffset = CGPointMake(S_WIDTH * whichPage, 0.0f);
    }];
}

@end
