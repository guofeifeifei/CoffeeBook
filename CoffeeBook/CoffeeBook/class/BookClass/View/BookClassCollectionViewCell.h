//
//  BookClassCollectionViewCell.h
//  CoffeeBook
//
//  Created by scjy on 16/3/6.
//  Copyright © 2016年 郭飞飞. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "BookClassModel.h"
@interface BookClassCollectionViewCell : UICollectionViewCell
@property(nonatomic, strong) BookClassModel *model;

@property (weak, nonatomic) IBOutlet UIImageView *ImageView;

@property (weak, nonatomic) IBOutlet UILabel *classTitleLable;

@property (weak, nonatomic) IBOutlet UILabel *readNumberLable;

@end
