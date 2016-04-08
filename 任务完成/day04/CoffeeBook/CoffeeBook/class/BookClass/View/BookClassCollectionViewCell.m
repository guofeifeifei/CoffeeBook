//
//  BookClassCollectionViewCell.m
//  CoffeeBook
//
//  Created by scjy on 16/3/6.
//  Copyright © 2016年 郭飞飞. All rights reserved.
//

#import "BookClassCollectionViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
@interface BookClassCollectionViewCell()
@property (weak, nonatomic) IBOutlet UIImageView *ImageView;

@property (weak, nonatomic) IBOutlet UILabel *classTitleLable;
@property (weak, nonatomic) IBOutlet UILabel *readNumberLable;

@end
@implementation BookClassCollectionViewCell

- (void)awakeFromNib {
    // Initialization code
}

- (void)setModel:(BookClassModel *)model{
    NSString *urlstring = [NSString stringWithFormat:@"%@/%@", bookClassJieko, model.classImage];
    NSLog(@"%@", urlstring);
    [self.ImageView sd_setImageWithURL:[NSURL URLWithString:urlstring] completed:nil];
    self.classTitleLable.text = model.className;
    self.readNumberLable.text = [NSString stringWithFormat:@"%@", model.readNumber];
}
@end
