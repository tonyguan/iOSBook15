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

@property (weak, nonatomic) IBOutlet UIImageView *imageView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
  
    //创建图片对象
    self.imageTrashFull = [UIImage imageNamed:@"Blend Trash Full"];
    self.imageTrashEmpty = [UIImage imageNamed:@"Blend Trash Empty"];
    
    self.imageView.image = self.imageTrashFull;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

//Tap手势处理方法
- (IBAction)foundTap:(id)sender {
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
