//
//  NewsTableViewCell.m
//  wyoa
//
//  Created by apple on 2018/8/27.
//  Copyright © 2018年 zjf. All rights reserved.
//

#import "NewsTableViewCell.h"

@implementation NewsTableViewCell

-(void)setNewsDetailBean:(NewsDetailBean *)newsDetailBean{
    [self.creatorLabel setText:newsDetailBean.creator];
    [self.createTime setText:newsDetailBean.createDate];
    if(newsDetailBean.title&&newsDetailBean.title.length>0){
        [self.contentLabel setText:newsDetailBean.title];
    }else if(newsDetailBean.sortName&&newsDetailBean.sortName.length>0){
        [self.contentLabel setText:newsDetailBean.sortName];
    }else if(newsDetailBean.theme&&newsDetailBean.theme.length>0){
        [self.contentLabel setText:newsDetailBean.theme];
    }else{
        [self.contentLabel setText:@"无"];
    }
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end
