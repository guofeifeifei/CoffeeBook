//
//  DisListTableViewCell.h
//  CoffeeBook
//
//  Created by scjy on 16/3/6.
//  Copyright © 2016年 郭飞飞. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "DisModel.h"
@interface DisListTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UILabel *detailLable;
@property (weak, nonatomic) IBOutlet UIImageView *faceImage;
@property (weak, nonatomic) IBOutlet UIButton *nickname;
@property (weak, nonatomic) IBOutlet UIImageView *bookImage;

@property (weak, nonatomic) IBOutlet UILabel *bookName;

@property (weak, nonatomic) IBOutlet UILabel *authouName;

@property (weak, nonatomic) IBOutlet UILabel *summerLable;
@property (weak, nonatomic) IBOutlet UILabel *goodCountLable;
@property (weak, nonatomic) IBOutlet UILabel *tellCountLable;
@property (weak, nonatomic) IBOutlet UILabel *loadTimeLable;
@property (weak, nonatomic) IBOutlet UIButton *BookDetailButton;
@property(nonatomic, strong) DisModel *model;
- (CGFloat)calulateHeightWithTitle:(NSString *)title desip:(NSString *)descrip;
@end
