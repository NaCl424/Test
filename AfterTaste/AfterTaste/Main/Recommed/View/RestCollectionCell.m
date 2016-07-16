//
//  RestCollectionCell.m
//  
//
//  Created by mac on 16/7/6.
//
//
#import "RestCollectionCell.h"
@implementation RestCollectionCell

- (void)awakeFromNib {
    
    self.layer.cornerRadius = self.frame.size.height / 10;

}


- (void)setRestModel:(Restaurant *)restModel {


    if (_restModel == restModel) {
        
        return;
    }

    _restModel = restModel;
    
    [_restImage sd_setImageWithURL:[NSURL URLWithString:_restModel.cover] placeholderImage:[UIImage imageNamed:@"finishe_travel"]];
    _restName.text = _restModel.name;
    _restPrice.text = [NSString stringWithFormat:@"人均: %@元", _restModel.cost];
    
}




- (IBAction)mapButtonAction:(UIButton *)sender {


}




@end
