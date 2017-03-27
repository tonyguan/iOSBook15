//
//  MyView.m
//  Quartz2UKit
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
    
    //创建UIImage图片对象
    UIImage *uiImage = [UIImage imageNamed:@"cat"];
    //将UIImage图片对象转换为CGImage图片对象
    CGImageRef cgImage = uiImage.CGImage;
    
    CGContextRef context = UIGraphicsGetCurrentContext();
    
    CGContextScaleCTM(context, 1, -1);
    CGContextTranslateCTM(context, 0, -uiImage.size.height);
    
    CGRect imageRect = CGRectMake(0, 0, uiImage.size.width, uiImage.size.height);
    CGContextDrawImage(context, imageRect, cgImage);
    
}

@end
