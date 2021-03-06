//
//  YQAlbumListViewController.h
//  PhotoSelect
//
//  Created by Mopon on 16/4/29.
//  Copyright © 2016年 Mopon. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "YQSelectorCommon.h"

//回调block
typedef void (^YQPhotoResult)(NSMutableArray * responseObject);

@interface YQAlbumListViewController : UITableViewController

@property (nonatomic ,strong)NSMutableArray *albums;

@property (nonatomic ,assign)NSInteger maxCount;

-(void)showPhotoListViewController:(YQPhotoResult)result;

@end
