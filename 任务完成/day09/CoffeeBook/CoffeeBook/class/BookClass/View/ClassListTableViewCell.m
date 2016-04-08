//
//  ClassListTableViewCell.m
//  CoffeeBook
//
//  Created by scjy on 16/3/7.
//  Copyright © 2016年 郭飞飞. All rights reserved.
//

#import "ClassListTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
@interface ClassListTableViewCell()


@property (weak, nonatomic) IBOutlet UIImageView *bookImage;

@property (weak, nonatomic) IBOutlet UILabel *bookNameLable;

@property (weak, nonatomic) IBOutlet UILabel *authorLable;
@property (weak, nonatomic) IBOutlet UILabel *summaryLable;

@end
@implementation ClassListTableViewCell

- (void)awakeFromNib {
    // Initialization code
}
- (void)setModel:(BookList *)model{
    NSString *urlImage = [NSString stringWithFormat:@"%@%@",imageJieko, model.bookImage];
    [self.bookImage sd_setImageWithURL:[NSURL URLWithString:urlImage] completed:nil];
   
    self.bookNameLable.text = model.bookName;
    self.authorLable.text = model.authorName;
    self.summaryLable.text = model.summary;
    
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
