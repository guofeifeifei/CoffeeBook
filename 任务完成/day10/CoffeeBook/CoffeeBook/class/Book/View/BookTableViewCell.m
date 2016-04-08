//
//  BookTableViewCell.m
//  CoffeeBook
//
//  Created by scjy on 16/3/4.
//  Copyright © 2016年 郭飞飞. All rights reserved.
//

#import "BookTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
@interface BookTableViewCell()

@property (weak, nonatomic) IBOutlet UIImageView *titleImage;

@property (weak, nonatomic) IBOutlet UILabel *titleLable;
@property (weak, nonatomic) IBOutlet UILabel *summaryLable;
@property (weak, nonatomic) IBOutlet UIImageView *iconUrlImage;

@property (weak, nonatomic) IBOutlet UILabel *stytleLable;

@property (weak, nonatomic) IBOutlet UILabel *timeLable;

@property (weak, nonatomic) IBOutlet UILabel *tellLable;
@property (weak, nonatomic) IBOutlet UILabel *likeLable;

@end
@implementation BookTableViewCell

- (void)setModel:(Model *)model{
    [self.titleImage sd_setImageWithURL:[NSURL URLWithString:model.bookImage] placeholderImage:nil];
    self.titleLable.text = model.booktitle;
    [self.iconUrlImage sd_setImageWithURL:[NSURL URLWithString:model.typleImage] placeholderImage:nil];
    self.stytleLable.text = model.typletitle;
    
    self.timeLable.text = [NSString stringWithFormat:@"%@", model.time];
    self.tellLable.text = [NSString stringWithFormat:@"%@", model.tell];
    self.likeLable.text = [NSString stringWithFormat:@"%@", model.love];
    
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
