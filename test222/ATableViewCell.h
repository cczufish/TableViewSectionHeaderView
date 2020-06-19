//
//  ATableViewCell.h
//  test222
//
//  Created by yu shuhui on 2020/6/18.
//  Copyright © 2020 yu shuhui. All rights reserved.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface ATableViewCell : UITableViewCell
@property (nonatomic, strong)UILabel *leftimage;
@property (nonatomic, strong)UILabel *rightimage;

- (void)setRightView:(BOOL)isUp Scroll:(CGFloat)scrolly;

@end

NS_ASSUME_NONNULL_END
