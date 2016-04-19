//
//  HomePageHeaderViewController.m
//  MoTe
//
//  Created by apple on 15/12/21.
//  Copyright © 2015年 apple. All rights reserved.
//

#import "HomePageHeaderViewController.h"
#import "HomePageHeaderCollectionViewCell1.h"

@interface HomePageHeaderViewController () <UICollectionViewDataSource,UICollectionViewDelegate,UICollectionViewDelegateFlowLayout>


@end

@implementation HomePageHeaderViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self.view addSubview:self.collectionView];
    [self.view addSubview:self.pageControl];
}

- (void)moveCollectionView
{
     [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
}
- (void)nextImage:(NSTimer *)timer
{
    //当前位置
    int page = self.collectionView.contentOffset.x / kScreenWidth;
    
    page ++;
    
    //如果到了最后一张
    if (page == self.groupArray.count - 1) {
        self.pageControl.currentPage = 0;
        
    } else {
        self.pageControl.currentPage = page - 1;
    }
    
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:page inSection:0] atScrollPosition:UICollectionViewScrollPositionLeft animated:YES];
    if (page == self.groupArray.count - 1) {
        [NSTimer scheduledTimerWithTimeInterval:.5 target:self selector:@selector(moveCollectionView) userInfo:nil repeats:NO];
    }
}


#pragma mark ----------------------------------------------------------------------
#pragma mark ----------------------Collection Delegate-------------------------------------
#pragma mark ----------------------------------------------------------------------


- (NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

- (NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return self.groupArray.count;
}

- (UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    HomePageHeaderCollectionViewCell1 * cell = [collectionView dequeueReusableCellWithReuseIdentifier:@"a" forIndexPath:indexPath];
    cell.imageView.image = [UIImage imageNamed:self.groupArray[indexPath.row]];
    return cell;
}

- (void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
   
}

- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    return CGSizeMake(kScreenWidth, kCarousePictureHeight);
}


- (void)setGroupArray:(NSArray *)groupArray
{
    if (!groupArray || ![groupArray isKindOfClass:NSArray.class] ||  groupArray.count == 0) {
        return;
    }
    NSMutableArray * array = [NSMutableArray arrayWithArray:groupArray];
    
    [array insertObject:array.lastObject atIndex:0];
    [array insertObject:array[1] atIndex:array.count];
    
    _groupArray = array;
 
    self.pageControl.numberOfPages = array.count - 2;

    [self.collectionView reloadData];
    [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:1 inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    
    [self.timer invalidate];
    self.timer = nil;
    self.timer = [NSTimer scheduledTimerWithTimeInterval:3 target:self selector:@selector(nextImage:) userInfo:nil repeats:YES];

}


#pragma mark ----------------------------------------------------------------------
#pragma mark ----------------------scrollView Delegate-------------------------------------
#pragma mark ----------------------------------------------------------------------
- (void)scrollViewWillBeginDragging:(UIScrollView *)scrollView
{
    [self.timer setFireDate:[NSDate distantFuture]];
}

- (void)scrollViewDidEndDecelerating:(UIScrollView *)scrollView
{
    [self.timer setFireDate:[NSDate dateWithTimeIntervalSinceNow:3]];
    
    NSInteger page = scrollView.contentOffset.x / kScreenWidth;
    if (page == 0) {
        page = self.groupArray.count;
        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:page - 2 inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
        
    }
    if (page == self.groupArray.count - 1) {
        page = 1;
        [self.collectionView scrollToItemAtIndexPath:[NSIndexPath indexPathForRow:page inSection:0] atScrollPosition:UICollectionViewScrollPositionNone animated:NO];
    }
    page --;
    
    self.pageControl.currentPage = page;
    
}
#pragma mark ----------------------------------------------------------------------
#pragma mark ----------------------Lazy Loading-------------------------------------
#pragma mark ----------------------------------------------------------------------

- (UICollectionView *)collectionView
{
    if (!_collectionView) {
        UICollectionViewFlowLayout * layout = [[UICollectionViewFlowLayout alloc] init];
        layout.minimumInteritemSpacing = 0;
        layout.minimumLineSpacing = 0;
        layout.sectionInset = UIEdgeInsetsMake(0, 0, 0, 0);
        layout.scrollDirection = UICollectionViewScrollDirectionHorizontal;
        
        _collectionView = [[UICollectionView alloc]initWithFrame:CGRectMake(0, 0, kScreenWidth,kCarousePictureHeight) collectionViewLayout:layout];
        _collectionView.backgroundColor = [UIColor orangeColor];
        _collectionView.frame = CGRectMake(0, 0, kScreenWidth, kCarousePictureHeight);
        _collectionView.pagingEnabled = YES;
        _collectionView.delegate = self;
        _collectionView.dataSource = self;
        _collectionView.alwaysBounceVertical = NO;
        _collectionView.showsHorizontalScrollIndicator = NO;
        _collectionView.showsVerticalScrollIndicator = NO;
        _collectionView.backgroundColor = [UIColor whiteColor];
        [_collectionView registerNib:[UINib nibWithNibName:@"HomePageHeaderCollectionViewCell1" bundle:nil] forCellWithReuseIdentifier:@"a"];
    }
    return _collectionView;
}

- (UIPageControl *)pageControl
{
    if (!_pageControl) {
        _pageControl = [[UIPageControl alloc]initWithFrame:CGRectMake(0, self.collectionView.frame.size.height - 40, kScreenWidth, 20)];
        _pageControl.currentPage = 0;
        _pageControl.currentPageIndicatorTintColor = [UIColor redColor];
        _pageControl.pageIndicatorTintColor = [UIColor whiteColor];
        
    }
    return _pageControl;
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end
