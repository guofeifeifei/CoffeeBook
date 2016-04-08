//
//  DisListTableViewCell.m
//  CoffeeBook
//
//  Created by scjy on 16/3/6.
//  Copyright © 2016年 郭飞飞. All rights reserved.
//

#import "DisListTableViewCell.h"
#import <SDWebImage/UIImageView+WebCache.h>
@interface DisListTableViewCell()


@end
@implementation DisListTableViewCell

- (void)awakeFromNib {
    // Initialization code
  
    
}
- (void)setModel:(DisModel *)model{
    self.detailLable.text = model.detail;
    //  NSString *urlString = [NSString stringWithFormat:@"%@%@", imageJieko, model.faceImage];UIImageView *imgView = [[UIImageView alloc] initWithImage:[UIImage imageNamed:@"imgName.png"]];
    
   
    
    
    
       self.faceImage.image = [UIImage imageNamed:@"UMS_User_profile_default"]; ;
    [self.faceImage sd_setImageWithURL:[NSURL URLWithString:model.faceImage] completed:nil];
    
    [self.nickname setTitle:[NSString stringWithFormat:@"%@发表了评论", model.nickname] forState:UIControlStateNormal];
    
    NSString *imageurl = [NSString stringWithFormat:@"%@%@", imageJieko, model.bookImage];
    [self.bookImage sd_setImageWithURL:[NSURL URLWithString:imageurl]];
    
    NSLog(@" model.faceImage = %@", model.faceImage);
    self.bookName.text = model.bookName;
    self.authouName.text = model.authouName;
    self.summerLable.text = model.summer;
    self.goodCountLable.text =[NSString stringWithFormat:@"%@",  model.goodCount];
    self.tellCountLable.text = [NSString stringWithFormat:@"%@", model.tellCount];
    self.loadTimeLable.text = model.loadTime ;
    

}

- (CGFloat)calulateHeightWithTitle:(NSString *)title desip:(NSString *)descrip{
    CGFloat preMaxWaith = [UIScreen mainScreen].bounds.size.width - 50;
    [self.detailLable setPreferredMaxLayoutWidth:preMaxWaith];
    [self.detailLable layoutIfNeeded];
    [self.detailLable setText:descrip];
    [self.contentView layoutIfNeeded];
    CGSize size = [self.contentView systemLayoutSizeFittingSize:UILayoutFittingCompressedSize];
    //加1是关键
    return size.height + .0f;
}
- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
