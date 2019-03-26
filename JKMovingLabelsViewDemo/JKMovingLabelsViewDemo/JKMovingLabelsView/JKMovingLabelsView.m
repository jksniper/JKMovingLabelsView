//
//  JKMovingLabelsView.m
//  cpfiction
//
//  Created by Apple on 2019/3/13.
//  Copyright © 2019 Changpei. All rights reserved.
//

#import "JKMovingLabelsView.h"
#import "Masonry.h"

@interface JKMovingLabelsView ()<UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout>

@property (nonatomic, strong) UICollectionViewFlowLayout *layout;

@property (nonatomic, strong) NSMutableArray  *array_more;

@property (nonatomic, strong) CADisplayLink *displayLink;

@property (nonatomic, assign) CGFloat totalLength;

@end


@implementation JKMovingLabelsView

- (instancetype)initWithCoder:(NSCoder *)aDecoder{
    if (self = [super initWithCoder:aDecoder]) {
        [self inits];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
        [self inits];
    }
    return self;
}

- (void)inits{
    
    self.layout = [[UICollectionViewFlowLayout alloc]init];
    self.layout.minimumInteritemSpacing = 0;
    self.layout.minimumLineSpacing = 0;
    [self.layout setScrollDirection:(UICollectionViewScrollDirectionHorizontal)];
    self.collection = [[UICollectionView alloc]initWithFrame:(CGRectZero) collectionViewLayout:self.layout];
    [self addSubview:self.collection];
    [self.collection mas_makeConstraints:^(MASConstraintMaker *make) {
        make.edges.equalTo(@0);
    }];
    
    self.collection.backgroundColor = [UIColor clearColor];
    self.collection.delegate = self;
    self.collection.dataSource = self;
    [self.collection registerClass:[UICollectionViewCell class] forCellWithReuseIdentifier:@"cell"];
    self.collection.showsHorizontalScrollIndicator = NO;
    
    [self startDisplay];
}

- (void)dealloc{

}

- (void)layoutSubviews{
    [super layoutSubviews];
    self.layout.estimatedItemSize = CGSizeMake(self.colWidth/2.0, self.collection.bounds.size.height);
    self.layout.minimumLineSpacing = self.minSpace;
}

- (void)setColWidth:(CGFloat)colWidth{
    _colWidth = colWidth;
}

- (void)setDataArray:(NSArray<NSAttributedString *> *)dataArray{
    _dataArray = dataArray;
    self.array_more = [[NSMutableArray alloc]initWithArray:dataArray];
    
    CGFloat tem = 0.0;
    NSInteger i = 0;
    while (tem < self.colWidth) {
        [self.array_more addObject:self.dataArray[i]];
        CGRect frame = [dataArray[i] boundingRectWithSize:CGSizeMake(MAXFLOAT, 1) options:NSStringDrawingUsesLineFragmentOrigin context:nil];
        tem += ((frame.size.width > self.colWidth/2.0 ? frame.size.width : self.colWidth/2.0) + self.minSpace);
        i++;
        if (i >= self.dataArray.count) {
            i = i - self.dataArray.count;
        }
    }
    [self.array_more addObjectsFromArray:dataArray];
    self.totalLength = 0.0;
    for (NSInteger i = 0; i < self.dataArray.count; ++i) {
        CGRect frame = [dataArray[i] boundingRectWithSize:CGSizeMake(MAXFLOAT, 1) options:NSStringDrawingUsesLineFragmentOrigin context:nil];
        self.totalLength += ((frame.size.width > self.colWidth/2.0 ? frame.size.width : self.colWidth/2.0) + self.minSpace);
    }
    [self.collection setContentOffset:(CGPointZero)];
    [self.collection reloadData];
    
}

#pragma mark - funcs

- (void)startDisplay{
    self.displayLink = [CADisplayLink displayLinkWithTarget:self selector:@selector(updateScroll)];
    [self.displayLink addToRunLoop:[NSRunLoop currentRunLoop] forMode:NSRunLoopCommonModes];
}

- (void)updateScroll{
    if (self.collection.contentOffset.x >= self.totalLength) {
        self.collection.contentOffset = CGPointZero;
    }else{
        self.collection.contentOffset = CGPointMake(self.collection.contentOffset.x + 1*self.speed, 0);
    }
}

#pragma mark - displaylink

- (void)startAnimation{
    self.displayLink.paused = NO;
}

- (void)pauseAnimation{
    self.displayLink.paused = YES;
}

- (void)stopAnimation{
    self.displayLink.paused = YES;
    [self.displayLink invalidate];
    self.displayLink = nil;
}


#pragma mark - collectionview dele & data

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section{
    return self.array_more.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath{
    
    UICollectionViewCell *cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
    UILabel *label;
    if (cell.contentView.subviews.count == 0) {
        label = [[UILabel alloc]init];
        [cell.contentView addSubview:label];
        [label mas_makeConstraints:^(MASConstraintMaker *make) {
            make.edges.equalTo(@0);
            make.width.mas_greaterThanOrEqualTo(self.colWidth/2.0);
            make.height.mas_equalTo(self.collection.bounds.size.height);
        }];
        label.numberOfLines = 1;
        
        label.tag = 100;
    }else{
        label = [cell.contentView viewWithTag:100];
    }
    label.attributedText = self.array_more[indexPath.item];
    
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath{
    if (self.block) {
        NSIndexPath *idxP = indexPath;
        if (indexPath.item >= self.dataArray.count) {
            idxP = [NSIndexPath indexPathForItem:(indexPath.item-self.dataArray.count) inSection:0];
        }
        self.block(@{@"idx":@(idxP.item),
                     @"data":self.dataArray[idxP.item]});
    }
}

@end
