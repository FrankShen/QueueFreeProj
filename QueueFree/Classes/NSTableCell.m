//
//  NSTableViewCell.m
//  QueueFree
//
//  Created by pursue_ct on 12-11-7.
//  Copyright (c) 2012年 BuG.BS. All rights reserved.
//

#import "NSTableCell.h"

@implementation NSTableCell

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

-(void) setShopImage:(UIImageView *)shopImage:(UIImageView *)image
{
    if(![image isEqual:_shopImage])
    {
        self.shopImage = image;
    }
}

-(void)setShopName:(UILabel *)aShopName
{
    if(![aShopName.text isEqual:_shopName.text])
    {
        self.shopName.text = aShopName.text;
    }
}

-(void)setQueuePeopleNumber:(UILabel *)aQueuePeopleNumber
{
    if(![aQueuePeopleNumber.text isEqual:_queuePeopleNumber.text])
    {
        self.queuePeopleNumber.text =aQueuePeopleNumber.text;
    }
}

-(void)setDistanceToUserLocation:(UILabel *)aDistanceToUserLocation
{
    if (![aDistanceToUserLocation.text isEqual:_distanceToUserLocation.text])
    {
        self.distanceToUserLocation.text = aDistanceToUserLocation.text;
    }
}
@end
