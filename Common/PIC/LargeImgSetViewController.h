//
//  LargeImgSetViewController.h
//  Chaofan
//
//  Created by Ren Guohua on 13-11-19.
//  Copyright (c) 2013年 yunfeng. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <QuartzCore/QuartzCore.h>
@interface LargeImgSetViewController : UIViewController<UICollectionViewDataSource,UICollectionViewDelegate,UIScrollViewDelegate>
{
    BOOL tabbarHidden;
    UICollectionViewFlowLayout *flowLayout;
    NSMutableArray *textArray;
    NSMutableArray *picDataArray;
    BOOL isTap;
}

@property (retain,nonatomic) NSMutableArray *cellList;

@property (retain,nonatomic) UIPageControl *pageController;

@property(nonatomic,strong)NSString *imageSetId;
@property(nonatomic,strong)UIImageView *imageView;
@property(nonatomic,strong)NSMutableArray *picArray;
@property(nonatomic,strong)UICollectionView *collectionView;
@property(nonatomic,assign)NSInteger currentPage;
@property(nonatomic,strong)NSMutableArray *picStringArray;
@property(nonatomic,strong)UITextView *textView;
@property(nonatomic,strong)UIView *textBackView;
-(void)initViewWithArray:(NSMutableArray *)ImageArray;
@end
