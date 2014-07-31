//
//  LargeCell.h
//  Chaofan
//
//  Created by Ren Guohua on 13-11-27.
//  Copyright (c) 2013年 yunfeng. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LargeCell : UICollectionViewCell<UIScrollViewDelegate>

@property(nonatomic,strong)UIImageView *imageView;
@property(nonatomic,strong)UILabel *titleLabel;
@property(nonatomic,strong)UILabel *detailLabel;
@property(nonatomic,strong)UIScrollView *scrollView;
@property(nonatomic,strong)UITextView *textView;

@end
