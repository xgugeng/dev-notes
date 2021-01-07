//
//  BIDNameAndColorCell.m
//  Cells
//
//  Created by JN on 9/9/13.
//  Copyright (c) 2013 Apress. All rights reserved.
//

#import "BIDNameAndColorCell.h"

@interface BIDNameAndColorCell ()

@property (strong, nonatomic) IBOutlet UILabel *nameLabel;
@property (strong, nonatomic) IBOutlet UILabel *colorLabel;

@end

@implementation BIDNameAndColorCell

//- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
//{
//    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
//    if (self) {
//        // Initialization code
//        CGRect nameLabelRect = CGRectMake(0, 5, 70, 15);
//        UILabel *nameMarker = [[UILabel alloc] initWithFrame:nameLabelRect];
//        nameMarker.textAlignment = NSTextAlignmentRight;
//        nameMarker.text = @"Name:";
//        nameMarker.font = [UIFont boldSystemFontOfSize:12];
//        [self.contentView addSubview:nameMarker];
//        
//        CGRect colorLabelRect = CGRectMake(0, 26, 70, 15);
//        UILabel *colorMarker = [[UILabel alloc] initWithFrame:colorLabelRect];
//        colorMarker.textAlignment = NSTextAlignmentRight;
//        colorMarker.text = @"Color:";
//        colorMarker.font = [UIFont boldSystemFontOfSize:12];
//        [self.contentView addSubview:colorMarker];
//        
//        CGRect nameValueRect = CGRectMake(80, 5, 200, 15);
//        _nameLabel = [[UILabel alloc] initWithFrame:
//                      nameValueRect];
//        [self.contentView addSubview:_nameLabel];
//        
//        CGRect colorValueRect = CGRectMake(80, 25, 200, 15);
//        _colorLabel = [[UILabel alloc] initWithFrame:
//                       colorValueRect];
//        [self.contentView addSubview:_colorLabel];
//    }
//    return self;
//}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated
{
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (void)setName:(NSString *)n
{
    if (![n isEqualToString:_name]) {
        _name = [n copy];
        self.nameLabel.text = _name;
    }
}

- (void)setColor:(NSString *)c
{
    if (![c isEqualToString:_color]) {
        _color = [c copy];
        self.colorLabel.text = _color;
    }
}

@end
