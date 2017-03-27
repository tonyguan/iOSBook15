//
//  MyView.m
//  ImageStringSample
//
//  Created by tony on 2017/3/23.
//  本书网站：http://www.51work6.com
//  智捷课堂在线课堂：http://www.zhijieketang.com/
//  智捷课堂微信公共号：zhijieketang
//  作者微博：@tony_关东升
//  作者微信：tony关东升
//  QQ：569418560 邮箱：eorient@sina.com
//  QQ交流群：162030268
//

#import "MyView.h"

@implementation MyView

- (void)drawRect:(CGRect)rect {
    
    //填充白色背景
    [[UIColor whiteColor] setFill];
    UIRectFill(rect);
    
    UIImage* image = [UIImage imageNamed:@"dog"];
    
    //设置一个rect矩形区域
    CGRect imageRect = CGRectMake(0, 40, [[UIScreen mainScreen] bounds].size.width, [[UIScreen mainScreen] bounds].size.width);
    //绘制图片
    [image drawInRect:imageRect];
    //[image drawAtPoint:CGPointMake(0, 40)];
    //[image drawAsPatternInRect:CGRectMake(0, 0, 320, 400)];

    NSString *title = @"我的小狗";
    UIFont *font = [UIFont systemFontOfSize:28];
    NSDictionary *attr = @{NSFontAttributeName:font};
    //获得字符串大小
    CGSize size = [title sizeWithAttributes:attr];
    //水平居中时x轴坐标
    CGFloat xpos = [[UIScreen mainScreen] bounds].size.width / 2 - size.width / 2;
    //绘制字符串
    [title drawAtPoint:CGPointMake(xpos, 20) withAttributes:attr];
    //CGRect stringRect = CGRectMake(xpos, 60, 100, 40);
    //[title drawInRect:stringRect withAttributes:attr];
}

@end
