//
//  LargeImgSetViewController.m
//  Chaofan
//
//  Created by Ren Guohua on 13-11-19.
//  Copyright (c) 2013年 yunfeng. All rights reserved.
//

#import "LargeImgSetViewController.h"
#import "LargeCell.h"
#import "zzAnimat.h"
//#import "GlobleData.h"
//#import "UIImageView+AFNetworking.h"
//#import "UIViewController+RESideMenu.h"
//#import "UIImage+BlurredFrame.h"
#define iPhone5 ([UIScreen instancesRespondToSelector:@selector(currentMode)] ? CGSizeEqualToSize(CGSizeMake(640, 1136), [[UIScreen mainScreen] currentMode].size) : NO)

@interface LargeImgSetViewController ()

@end

@implementation LargeImgSetViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self)
    {
        //self.cellList = [[NSMutableArray alloc]init];
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setMyView];
//    [self addLabel];
    [self addTap];
}

- (void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    tabbarHidden = NO;
    isTap = NO;
}

- (void)viewDidAppear:(BOOL)animated
{
  
}


-(void)initViewWithArray:(NSMutableArray *)imageArray
{
    picDataArray=[[NSMutableArray alloc]initWithArray:imageArray];
   [self initCollectionView];
}

- (void)setMyView
{
    self.view.backgroundColor=[UIColor lightGrayColor];
}


/**
 *  初始化collectionView
 */
-(void)initCollectionView
{
    flowLayout=[[UICollectionViewFlowLayout alloc] init];
    flowLayout.itemSize=CGSizeMake(320.0f,self.view.frame.size.height);
    [flowLayout setScrollDirection:UICollectionViewScrollDirectionHorizontal];
    flowLayout.minimumLineSpacing = 20.0f;
    flowLayout.minimumInteritemSpacing = 0.0f;
    CGRect frame = CGRectMake(-10.0f, 0.0f, self.view.frame.size.width+20.0f,self.view.frame.size.height);
   
    _collectionView = [[UICollectionView alloc] initWithFrame:frame collectionViewLayout:flowLayout];
    _collectionView.showsHorizontalScrollIndicator = NO;
    _collectionView.backgroundColor = [UIColor lightGrayColor];
    _collectionView.dataSource = self;
    _collectionView.delegate = self;
    [_collectionView registerClass:[LargeCell class] forCellWithReuseIdentifier:@"cell"];
    _collectionView.pagingEnabled = YES;

    [_collectionView setContentOffset:CGPointMake(_currentPage*340, 0)];
    [self.view addSubview:_collectionView];
    
    ///pageController
    self.pageController = [[UIPageControl alloc]init];
    self.pageController.frame = CGRectMake(150, self.view.bounds.size.height-40, 20, 20);
    self.pageController.numberOfPages = picDataArray.count;
    self.pageController.currentPage = _currentPage;
    [self.view addSubview:self.pageController];
}

-(void)addLabel
{
    UILabel *label = [[UILabel alloc] initWithFrame:self.view.frame];
    [self.view addSubview:label];
}
/**
 *  增加手势，单击的时候，隐藏周边的文字，只显示图片，双击的时候图片进行缩放
 */
-(void)addTap
{
    /**
     *  单击
     *
     *  @param tap: <#tap: description#>
     *
     *  @return <#return value description#>
     */
    UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
    tap.numberOfTapsRequired = 1;
    [self.view addGestureRecognizer:tap];
    
    /**
     *  双击
     *
     *  @param doubleTapToZoom: <#doubleTapToZoom: description#>
     *
     *  @return <#return value description#>
     */
    UITapGestureRecognizer *doubleTap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(doubleTapToZoom:)];
    doubleTap.numberOfTapsRequired = 2;
    [self.view addGestureRecognizer:doubleTap];
    
    [tap requireGestureRecognizerToFail:doubleTap];
     
}

#pragma CollectionView DataSource
/**
 *  collectionView 的数据源，
 *
 *  @param collectionView 集合视图
 *
 *  @return 返回collectionView的section的个数，此处返回1，表明该集合视图只有一个section
 */
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    
   // return [_picArray count];
    return [picDataArray count];
}


- (UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(0.0f, 10.0f, 0.0f, 10.0f);
    
}

-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    LargeCell *cell = (LargeCell *)[collectionView dequeueReusableCellWithReuseIdentifier:@"cell" forIndexPath:indexPath];
//    cell.imageView.frame= [picDataArray objectAtIndex:indexPath.row].frame;
    cell.imageView.contentMode =UIViewContentModeScaleAspectFit;
    cell.imageView.image = [picDataArray objectAtIndex:indexPath.row];
    cell.backgroundColor = [UIColor lightGrayColor];
    cell.scrollView.zoomScale = 1.0f;

    //[self.cellList addObject:cell];
    
    return cell;
}

- (void)scrollViewDidScroll:(UIScrollView *)sender {
    
    //nowPage = self.collectionView.contentOffset.x / 320;//通过滚动的偏移量来判断目前页面所对应的小白点
    
}
-(void)goBack:(id)sender
{
    [self.navigationController popViewControllerAnimated:NO];
}

-(void)doubleTapToZoom:(UIGestureRecognizer *)recognizer
{
    LargeCell *cell = (LargeCell*)[_collectionView cellForItemAtIndexPath:[NSIndexPath indexPathForRow:_currentPage inSection:0]];
    if(cell.scrollView.zoomScale == 1)
    {
        //cell.scrollView.zoomScale = 1.5;
        [cell.scrollView setZoomScale:1.5 animated:YES];
    }
    else if(cell.scrollView.zoomScale == 1.5)
    {
        //cell.scrollView.zoomScale = 1;
        [cell.scrollView setZoomScale:1 animated:YES];
    }
    
    
}
-(void)tap:(UIGestureRecognizer *)recognizer
{
    [self dismissViewControllerAnimated:NO completion:nil];
    return;
}


#pragma ScrollView delegate
/**
 *  collectionView停止减速的时候，设置当前页面为第几页，同时修改_textView的内容;
 *
 *  @param scrollView 传入参数为collectionView(PS：collectionView是scrollView的子View);
 */
- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    if ([scrollView isKindOfClass:[UICollectionView class]])
    {
        CGFloat pageWidth = self.view.frame.size.width+20.0f;
        NSInteger page = floor((scrollView.contentOffset.x - pageWidth / 2) / pageWidth) + 1;
 
        if (_currentPage != page)
        {
            _currentPage = page;
            self.pageController.currentPage = page;
        }
    }

}


- (BOOL)prefersStatusBarHidden
{
    if (isTap)
    {
        isTap = NO;
        return !tabbarHidden;
    }
    else
    {
        isTap = NO;
        return NO;
    }
   
}


#pragma mark - Status Bar

- (UIStatusBarStyle)preferredStatusBarStyle
{
    return UIStatusBarStyleDefault;//UIStatusBarStyleLightContent;
}

- (UIStatusBarAnimation)preferredStatusBarUpdateAnimation {
    
    return UIStatusBarAnimationFade;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
}

@end
