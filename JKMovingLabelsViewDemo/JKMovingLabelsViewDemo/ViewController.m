//
//  ViewController.m
//  JKMovingLabelsViewDemo
//
//  Created by Apple on 2019/3/13.
//  Copyright © 2019 GhostFire. All rights reserved.
//

#import "ViewController.h"
#import "JKMovingLabelsView.h"
#import "Masonry.h"

@interface ViewController ()

@property (nonatomic, strong) JKMovingLabelsView *movingView;
@property (nonatomic, strong) UILabel *showLabel;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    self.movingView = [[JKMovingLabelsView alloc]initWithFrame:(CGRectMake(16, 160, self.view.bounds.size.width-16*2, 24))];
    [self.view addSubview:self.movingView];
   
    self.movingView.colWidth = self.view.bounds.size.width;
    self.movingView.minSpace = 44;
    self.movingView.speed = .5;
    
    
    NSArray *stringsArray = @[@"《早发白帝城》 唐·李白    朝辞白帝彩云间，千里江陵一日还。两岸猿声啼不住，轻舟已过万重山。 ",
                          @"《秋夕》 唐代·杜牧    银烛秋光冷画屏，轻罗小扇扑流萤。天阶夜色凉如水，卧看牵牛织女星。",
                          @"《春夜喜雨》 唐·杜甫    好雨知时节，当春乃发生。随风潜入夜，润物细无声。野径云俱黑，江船火独明。晓看红湿处，花重锦官城。",
                          @"《乌衣巷》 唐代·刘禹锡    朱雀桥边野草花，乌衣巷口夕阳斜。旧时王谢堂前燕，飞入寻常百姓家。",
                          @"《出塞二首·其一》 唐代·王昌龄    秦时明月汉时关，万里长征人未还。但使龙城飞将在，不教胡马度阴山。"];
    NSMutableArray *dataArray = [NSMutableArray array];

    for (NSString *subStr in stringsArray) {
        
        NSMutableAttributedString * mAttribute = [[NSMutableAttributedString alloc] initWithString:subStr];
        [mAttribute addAttribute:NSForegroundColorAttributeName value:[UIColor darkTextColor] range:NSMakeRange(0, subStr.length)];
        [mAttribute addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13 weight:(UIFontWeightLight)] range:NSMakeRange(0, subStr.length)];

        NSRange rang0 = [subStr rangeOfString:@"《"];
        NSRange rang1 = [subStr rangeOfString:@"》"];
        NSRange titleRange = NSMakeRange(rang0.location, rang1.location - rang0.location + 1);
        
        [mAttribute addAttribute:NSForegroundColorAttributeName value:[UIColor orangeColor] range:titleRange];
        
        [dataArray addObject:mAttribute];
    }
   
    __weak typeof(self) weakSelf = self;
    self.movingView.dataArray = [dataArray mutableCopy];
    self.movingView.backgroundColor = [UIColor colorWithWhite:.9 alpha:.5];
    self.movingView.block = ^(NSDictionary * info) {
        NSLog(@"idx:%@\ndata:%@",info[@"idx"],((NSAttributedString *)info[@"data"]).string);
        weakSelf.showLabel.attributedText = info[@"data"];
    };
    
    UIView *view = [[UIView alloc]init];
    [self.view addSubview:view];
    view.backgroundColor = [UIColor colorWithWhite:.9 alpha:.3];
    [view mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@16);
        make.right.equalTo(@(-16));
        make.top.mas_equalTo(self.movingView.mas_bottom).offset(100);
        make.height.mas_greaterThanOrEqualTo(44);
    }];
    
    self.showLabel = [[UILabel alloc]init];
    [view addSubview:self.showLabel];
    [self.showLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@12);
        make.right.equalTo(@(-12));
        make.top.equalTo(@12);
        make.bottom.equalTo(@(-12));
    }];
    self.showLabel.numberOfLines = 0;
    self.showLabel.text = @"点击运动的label可以查看效果...";
}


@end
