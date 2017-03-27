//
//  ViewController.m
//  PITax
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
#import "TaxRevenueBL.h"

@interface ViewController ()

@property (weak, nonatomic) IBOutlet UITextField *txtRevenue;
@property (weak, nonatomic) IBOutlet UILabel *lblTax;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
}

- (IBAction)onClick:(id)sender {
    //关闭键盘
    [self.txtRevenue resignFirstResponder];
    
    NSString *value = self.txtRevenue.text;
    if (value.length == 0) {
        UIAlertController* alertController  = [UIAlertController alertControllerWithTitle:@"警告"
                                                                                  message: @"请输入内容"
                                                                           preferredStyle:UIAlertControllerStyleAlert];
        UIAlertAction* okAction = [UIAlertAction actionWithTitle:@"OK"
                                                           style:UIAlertActionStyleDefault
                                                         handler:nil];
        [alertController addAction:okAction];
        //显示
        [self presentViewController:alertController animated:TRUE completion:nil];
        return ;
    }
    double revenue = [value doubleValue];
    TaxRevenueBL *bl = [[TaxRevenueBL alloc] init];
    double resultValue = [bl calculate:revenue];
    NSString* strTax = [NSString stringWithFormat:@"%.2f", resultValue];
    
    self.lblTax.text = strTax;
}

@end
