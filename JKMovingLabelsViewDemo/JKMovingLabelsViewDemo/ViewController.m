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
@property (nonatomic, strong) UIButton *changeBtn;
@property (nonatomic, strong) UISlider *slider;
@property (nonatomic, strong) UILabel *speedLabel;

@property (nonatomic, strong) NSArray *array_0;
@property (nonatomic, strong) NSArray *array_1;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
   
    UILabel *theLabel = [[UILabel alloc]init];
    [self.view addSubview:theLabel];
    [theLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@16);
        make.right.equalTo(@(-16));
        make.top.equalTo(@(64+22));
        make.height.mas_greaterThanOrEqualTo(44);
    }];
    theLabel.text = @"JKMovingLabelsView";
    theLabel.textAlignment = NSTextAlignmentCenter;
    theLabel.font = [UIFont systemFontOfSize:20 weight:(UIFontWeightLight)];
    theLabel.layer.borderColor = [UIColor darkTextColor].CGColor;
    theLabel.layer.borderWidth = .5;
    
    
    self.movingView = [[JKMovingLabelsView alloc]initWithFrame:(CGRectMake(16, 160, self.view.bounds.size.width-16*2, 24))];
    [self.view addSubview:self.movingView];
   
    self.movingView.colWidth = self.view.bounds.size.width;
    self.movingView.minSpace = 44;
    self.movingView.speed = .5;
    
    __weak typeof(self) weakSelf = self;
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
        make.top.mas_equalTo(self.movingView.mas_bottom).offset(44);
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
    NSString *tem = @"点击运动的label可以查看效果...";
    
    NSMutableAttributedString * this_mAttribute = [[NSMutableAttributedString alloc] initWithString:tem];
    [this_mAttribute addAttribute:NSForegroundColorAttributeName value:[UIColor darkTextColor] range:NSMakeRange(0, tem.length)];
    [this_mAttribute addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13 weight:(UIFontWeightLight)] range:NSMakeRange(0, tem.length)];
    self.showLabel.attributedText = [this_mAttribute mutableCopy];
    
    self.changeBtn = [[UIButton alloc]init];
    [self.view addSubview:self.changeBtn];
    [self.changeBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@16);
        make.right.equalTo(@(-16));
        make.top.mas_equalTo(self.showLabel.mas_bottom).offset(44);
        make.height.mas_greaterThanOrEqualTo(44);
    }];
    [self.changeBtn setBackgroundColor:[UIColor blueColor]];
    [self.changeBtn setTitle:@"切换数据源" forState:(UIControlStateNormal)];
    [self.changeBtn setTitleColor:[UIColor whiteColor] forState:(UIControlStateNormal)];
    [self.changeBtn addTarget:self action:@selector(changeData) forControlEvents:(UIControlEventTouchUpInside)];
    
    self.array_0 = @[@"《早发白帝城》 唐·李白    朝辞白帝彩云间，千里江陵一日还。两岸猿声啼不住，轻舟已过万重山。 ",
                          @"《秋夕》 唐代·杜牧    银烛秋光冷画屏，轻罗小扇扑流萤。天阶夜色凉如水，卧看牵牛织女星。",
                          @"《春夜喜雨》 唐·杜甫    好雨知时节，当春乃发生。随风潜入夜，润物细无声。野径云俱黑，江船火独明。晓看红湿处，花重锦官城。",
                          @"《乌衣巷》 唐代·刘禹锡    朱雀桥边野草花，乌衣巷口夕阳斜。旧时王谢堂前燕，飞入寻常百姓家。",
                          @"《出塞二首·其一》 唐代·王昌龄    秦时明月汉时关，万里长征人未还。但使龙城飞将在，不教胡马度阴山。"];
    self.array_1 = @[@"《满江红》 [宋]岳飞    怒发冲冠，凭栏处潇潇雨歇。抬望眼，仰天长啸，壮怀激烈。三十功名尘与土，八千里路云和月。莫等闲白了少年头，空悲切。  靖康耻，犹未雪；臣子恨，何时灭！驾长车踏破贺兰山缺。壮志饥餐胡虏肉，笑谈渴饮匈奴血。待从头收拾旧山河，朝天阙。",
                              @"《江城子·乙卯正月二十日夜记梦》 [宋]苏轼    十年生死两茫茫，不思量，自难忘。千里孤坟，无处话凄凉。纵使相逢应不识，尘满面，鬓如霜。  夜来幽梦忽还乡，小轩窗，正梳妆。相顾无言，惟有泪千行。料得年年肠断处，明月夜，短松冈。",
                              @"《水调歌头·明月几时有》 [宋]苏轼    明月几时有？把酒问青天。不知天上宫阙，今夕是何年。我欲乘风归去，又恐琼楼玉宇，高处不胜寒。起舞弄清影，何似在人间？  转朱阁，低绮户，照无眠。不应有恨，何事长向别时圆？人有悲欢离合，月有阴晴圆缺，此事古难全。但愿人长久，千里共婵娟。",
                              @"《声声慢·寻寻觅觅》 [宋]李清照    寻寻觅觅，冷冷清清，凄凄惨惨戚戚。乍暖还寒时候，最难将息。三杯两盏淡酒，怎敌他、晚来风急？雁过也，正伤心，却是旧时相识。  满地黄花堆积。憔悴损，如今有谁堪摘？守着窗儿，独自怎生得黑？梧桐更兼细雨，到黄昏、点点滴滴。这次第，怎一个愁字了得！ "];

    [self setWithDataArray:self.array_0];
    
    self.slider = [[UISlider alloc]init];
    [self.view addSubview:self.slider];
    [self.slider mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@16);
        make.right.equalTo(@(-16));
        make.top.mas_equalTo(self.changeBtn.mas_bottom).offset(44);
        make.height.mas_greaterThanOrEqualTo(36);
    }];
    [self.slider addTarget:self action:@selector(changeSpeed:) forControlEvents:(UIControlEventValueChanged)];
    [self.slider setMinimumValue:0.0];
    [self.slider setMaximumValue:10.0];
   
    self.slider.value = self.movingView.speed;
    
    self.speedLabel = [[UILabel alloc]init];
    [self.view addSubview:self.speedLabel];
    [self.speedLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.equalTo(@16);
        make.right.equalTo(@(-16));
        make.top.mas_equalTo(self.slider.mas_bottom).offset(0);
        make.height.mas_greaterThanOrEqualTo(24);
    }];
    [self.speedLabel setText:[NSString stringWithFormat:@"速度调整（0~10）,当前速度 %.2f",self.slider.value]];
    [self.speedLabel setTextAlignment:(NSTextAlignmentCenter)];
    [self.speedLabel setFont:[UIFont systemFontOfSize:(15) weight:(UIFontWeightLight)]];
    
}

static int TempNumber = 1;

- (void)changeData{
    TempNumber += 1;
    if (TempNumber%2) {
        [self setWithDataArray:self.array_0];
    }else{
        [self setWithDataArray:self.array_1];
    }
}

- (void)setWithDataArray:(NSArray *)array{
    
//    NSString *tem = @"已修改数据源....";
//    NSMutableAttributedString * this_mAttribute = [[NSMutableAttributedString alloc] initWithString:tem];
//    [this_mAttribute addAttribute:NSForegroundColorAttributeName value:[UIColor darkTextColor] range:NSMakeRange(0, tem.length)];
//    [this_mAttribute addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13 weight:(UIFontWeightLight)] range:NSMakeRange(0, tem.length)];
//    self.showLabel.attributedText = [this_mAttribute mutableCopy];
//
    
    NSMutableArray *dataArray = [NSMutableArray array];
    
    for (NSString *subStr in array) {
        
        NSMutableAttributedString * mAttribute = [[NSMutableAttributedString alloc] initWithString:subStr];
        [mAttribute addAttribute:NSForegroundColorAttributeName value:[UIColor darkTextColor] range:NSMakeRange(0, subStr.length)];
        [mAttribute addAttribute:NSFontAttributeName value:[UIFont systemFontOfSize:13 weight:(UIFontWeightLight)] range:NSMakeRange(0, subStr.length)];
        
        NSRange rang0 = [subStr rangeOfString:@"《"];
        NSRange rang1 = [subStr rangeOfString:@"》"];
        NSRange titleRange = NSMakeRange(rang0.location, rang1.location - rang0.location + 1);
        
        [mAttribute addAttribute:NSForegroundColorAttributeName value:[UIColor orangeColor] range:titleRange];
        
        [dataArray addObject:mAttribute];
    }
    
    
    [self.movingView pauseAnimation];
    self.movingView.dataArray = [dataArray mutableCopy];
    [self.movingView startAnimation];
}

- (void)changeSpeed:(UISlider *)slider{
    self.movingView.speed = self.slider.value;
    [self.speedLabel setText:[NSString stringWithFormat:@"速度调整（0~10）,当前速度 %.2f",self.slider.value]];

}

@end
