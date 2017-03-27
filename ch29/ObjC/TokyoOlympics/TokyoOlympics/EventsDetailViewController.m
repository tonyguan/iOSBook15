//
//  EventsDetailViewController.m
//  TokyoOlympics
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


#import "EventsDetailViewController.h"

@interface EventsDetailViewController ()

@property (nonatomic) UILabel *lblEventName;
@property (nonatomic) UIImageView *imgEventIcon;
@property (nonatomic) UITextView *txtViewKeyInfo;
@property (nonatomic) UITextView *txtViewBasicsInfo;
@property (nonatomic) UITextView *txtViewOlympicInfo;

@end

@implementation EventsDetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    CGRect screen = [[UIScreen mainScreen] bounds];
    
    self.view.backgroundColor = [UIColor whiteColor];
    
    /// 1.添加ImageView
    self.imgEventIcon = [[UIImageView alloc] initWithFrame: CGRectMake(10, 80, 102, 102)];
    self.imgEventIcon.image = [UIImage imageNamed:self.event.EventIcon];
    [self.view addSubview:self.imgEventIcon];
    
    /// 2.lblEventName标签
    self.lblEventName = [[UILabel alloc] initWithFrame:CGRectMake(160, 140, 200, 30)];
    self.lblEventName.text = self.event.EventName;
    self.lblEventName.font = [UIFont boldSystemFontOfSize:20];
    [self.view addSubview:self.lblEventName];
    
    /// 3.txtViewBasicsInfo标签
    self.txtViewKeyInfo = [[UITextView alloc] initWithFrame:CGRectMake(10, self.imgEventIcon.frame.origin.y + 120, screen.size.width - 20, 90)];
    self.txtViewKeyInfo.editable = NO;
    self.txtViewKeyInfo.text = self.event.KeyInfo;
    [self.view addSubview:self.txtViewKeyInfo];
    
    /// 4.静态标签The Basics
    UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(10, self.txtViewKeyInfo.frame.origin.y + 100, 200, 30)];
    label.text = @"The Basics";
    label.font = [UIFont boldSystemFontOfSize:20];
    [self.view addSubview:label];
    
    /// 5.txtViewBasicsInfo标签
    self.txtViewBasicsInfo = [[UITextView alloc] initWithFrame:CGRectMake(10, label.frame.origin.y + 30, screen.size.width - 20, 90)];
    self.txtViewBasicsInfo.editable = NO;
    self.txtViewBasicsInfo.text = self.event.BasicsInfo;
    [self.view addSubview:self.txtViewBasicsInfo];
    
    /// 6.静态标签Olympic past and present
    label = [[UILabel alloc] initWithFrame:CGRectMake(10, self.txtViewBasicsInfo.frame.origin.y + 100, 300, 30)];
    label.text = @"Olympic past and present";
    label.font = [UIFont boldSystemFontOfSize:20];
    [self.view addSubview:label];
    
    /// 7.txtViewOlympicInfo标签
    self.txtViewOlympicInfo = [[UITextView alloc] initWithFrame:CGRectMake(10, label.frame.origin.y + 30, screen.size.width - 20, 90)];
    self.txtViewOlympicInfo.editable = NO;
    self.txtViewOlympicInfo.text = self.event.KeyInfo;
    [self.view addSubview:self.txtViewOlympicInfo];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end
