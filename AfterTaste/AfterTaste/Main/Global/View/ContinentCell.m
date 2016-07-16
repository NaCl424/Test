//
//  ContinentCell.m
//  AfterTaste
//
//  Created by apple on 16/6/30.
//  Copyright © 2016年 ljp. All rights reserved.
//

#import "ContinentCell.h"

@interface ContinentCell ()
@property (strong, nonatomic) IBOutlet UILabel *nameLable;

@property (strong, nonatomic) IBOutlet UIButton *continentButton;
@property (strong, nonatomic) IBOutlet UIButton *firstButton;
@property (strong, nonatomic) IBOutlet UIButton *secondButton;
@property (strong, nonatomic) IBOutlet UIButton *thirdButton;
@property (strong, nonatomic) IBOutlet UIButton *fourthButton;
@property (strong, nonatomic) IBOutlet UIButton *fifthButton;
@property (strong, nonatomic) IBOutlet UIButton *moreButton;

@end
@implementation ContinentCell

- (void)setCellObject:(id)cellObject {

    if (_cellObject == cellObject) {
        return;
    }
    _cellObject = cellObject;
    if ([cellObject isKindOfClass:[Country class]]) {
        Country *country = (Country *)cellObject;
        _nameLable.text = country.name;
        NSMutableArray *nameArray = [[NSMutableArray alloc] init];
        for (City *city in country.cities) {
            [nameArray addObject:city.name];
        }
        [_firstButton setTitle:nameArray[0] forState:UIControlStateNormal];
        [_secondButton setTitle:nameArray[1] forState:UIControlStateNormal];
        [_thirdButton setTitle:nameArray[2] forState:UIControlStateNormal];
        [_fourthButton setTitle:nameArray[3] forState:UIControlStateNormal];
        [_fifthButton setTitle:nameArray[4] forState:UIControlStateNormal];

        NSString *imageName = [NSString stringWithFormat:@"find_list%d", country.index + 1];
        [_continentButton setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    }else if ([cellObject isKindOfClass:[Continent class]]){

        Continent *continent = (Continent *)cellObject;
        _nameLable.text = continent.name;
        NSMutableArray *nameArray = [[NSMutableArray alloc] init];
        for (Country *country in continent.countries) {
            [nameArray addObject:country.name];
        }
        [_firstButton setTitle:nameArray[0] forState:UIControlStateNormal];
        [_secondButton setTitle:nameArray[1] forState:UIControlStateNormal];
        [_thirdButton setTitle:nameArray[2] forState:UIControlStateNormal];
        [_fourthButton setTitle:nameArray[3] forState:UIControlStateNormal];
        [_fifthButton setTitle:nameArray[4] forState:UIControlStateNormal];

        NSString *imageName = [NSString stringWithFormat:@"find_list%d", continent.index + 1];
        [_continentButton setImage:[UIImage imageNamed:imageName] forState:UIControlStateNormal];
    }
}
- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}
- (IBAction)pushCountryAction:(UIButton*)sender {

    if (_countryBlock) {
        _countryBlock();
    }
}
- (IBAction)pushCityAction:(UIButton *)sender {

    if (_cityBlock) {
        _cityBlock(sender.tag);
    }
}

@end
