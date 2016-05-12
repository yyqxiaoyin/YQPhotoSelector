# YQPhotoSelector_OC
照片选择器，浏览相册。支持多选<br>

使用方法：<br>

YQPhotoSelectController *photoSelect = [[YQPhotoSelectController alloc]init];<br>

photoSelect.maxCount = 8;<br>

__weak typeof(self)weakSelf = self;<br>

[photoSelect showInController:self result:^(NSMutableArray * responseObject) {<br>
	NSLog(@"%lu",responseObject.count);<br>
	self.imageSource = responseObject;<br>
	[weakSelf.collectionView reloadData];<br> 	
    }];
