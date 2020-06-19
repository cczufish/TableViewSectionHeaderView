//
//  ATableViewCell.m
//  test222
//
//  Created by yu shuhui on 2020/6/18.
//  Copyright © 2020 yu shuhui. All rights reserved.
//

#import "ATableViewCell.h"

@implementation ATableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    
    // Configure the view for the selected state
}


//重写init方法
- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier{
    //调用父类init方法创建
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        //创建成功则t给cell添加需要的子视图
        self.leftimage = [[UILabel alloc] init];
        _leftimage.frame = CGRectMake(0, 0, 100, 40);
        _leftimage.backgroundColor = [UIColor redColor];
        
        [self.contentView addSubview:_leftimage];
        
        self.rightimage = [[UILabel alloc] init];
        _rightimage.frame = CGRectMake(120, 0, 200, 40);
        _rightimage.backgroundColor = [UIColor lightGrayColor];
        [self.contentView addSubview:_rightimage];
    }
    
    return self;
}

//重写layoutSubviews方法，给视图设置位置大小
- (void)layoutSubviews{
    
}

- (void)setRightView:(BOOL)isUp Scroll:(CGFloat)scrolly{
    CGFloat rightimageY = self.rightimage.frame.origin.y;
    CGFloat lastY = rightimageY + scrolly;
    if (lastY>0) {
        lastY = 0;
    }else if (lastY<-40){
        lastY = -40;
    }else{
        
    }
    
    _rightimage.frame = CGRectMake(120, lastY, 200, 40);
    //    [self.rightimage setFrame:CGRectMake(120,rightimageY + scrolly, 200, 40)];
    
}

@end
