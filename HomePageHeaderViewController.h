//
//  HomePageHeaderViewController.h
//  MoTe
//
//  Created by apple on 15/12/21.
//  Copyright © 2015年 apple. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface HomePageHeaderViewController : UIViewController
@property (nonatomic,strong)UICollectionView * collectionView;
@property (nonatomic,strong)NSArray * groupArray;

/**
 *  计时器
 */
@property (nonatomic,strong)NSTimer * timer;
/**
 *  小点
 */
@property (nonatomic,strong)UIPageControl * pageControl;
@end
