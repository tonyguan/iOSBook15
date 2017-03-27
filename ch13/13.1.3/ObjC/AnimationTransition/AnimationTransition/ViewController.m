//
//  ViewController.m
//  AnimationTransition
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

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
}

- (IBAction)doUIViewAnimation:(id)sender {
    
    UIButton *button = (UIButton *)sender;
    NSLog(@"tag = %li", (long)button.tag);
    
    switch (button.tag) {
        case 1:
            [UIView transitionWithView:self.view duration:1.5
                               options:UIViewAnimationOptionCurveEaseOut | UIViewAnimationOptionTransitionFlipFromLeft
                            animations:NULL completion:NULL];
            break;
        case 2:
            [UIView transitionWithView:self.view duration:1.5
                               options:UIViewAnimationOptionCurveEaseOut | UIViewAnimationOptionTransitionFlipFromRight
                            animations:NULL completion:NULL];
            break;
        case 3:
            [UIView transitionWithView:self.view duration:1.5
                               options:UIViewAnimationOptionCurveEaseOut | UIViewAnimationOptionTransitionCurlUp
                            animations:NULL completion:NULL];
            break;
        case 4:
            [UIView transitionWithView:self.view duration:1.5
                               options:UIViewAnimationOptionCurveEaseOut | UIViewAnimationOptionTransitionCurlDown
                            animations:NULL completion:NULL];
            break;
    }
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end
