//
//  JKMovingLabelsView.h
//  cpfiction
//
//  Created by Apple on 2019/3/13.
//  Copyright © 2019 Changpei. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface JKMovingLabelsView : UIView

@property (strong, nonatomic) UICollectionView *collection;
@property (nonatomic, assign) CGFloat colWidth;
@property (nonatomic, strong) NSArray <NSAttributedString *> *dataArray;

@property (nonatomic, assign) CGFloat minSpace;
@property (nonatomic, assign) CGFloat speed;

typedef void (^SomeDicBlock)(NSDictionary * info);
@property (nonatomic, copy) SomeDicBlock block;

- (void)startAnimation;
- (void)pauseAnimation;
- (void)stopAnimation;

@end

NS_ASSUME_NONNULL_END
