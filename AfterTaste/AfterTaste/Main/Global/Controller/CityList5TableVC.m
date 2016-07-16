//
//  CityList5TableVC.m
//  AfterTaste
//
//  Created by apple on 16/7/5.
//  Copyright © 2016年 Czj. All rights reserved.
//

#import "CityList5TableVC.h"
#import "SceneCell.h"


@interface CityList5TableVC ()
{
    NSMutableArray *_scenes;
}
@end

@implementation CityList5TableVC

- (void)viewDidLoad {
    [super viewDidLoad];
    

}
- (instancetype)initWithCityIndex:(NSInteger)cityIndex cityListIndex:(NSInteger)index
{
    self = [super init];
    if (self) {

        _scenes = [[NSMutableArray alloc] init];

        NSString *fileName = [NSString stringWithFormat:@"CityList%ld%ld", (long)cityIndex, (long)index];
        NSDictionary *responseObject = [JSONDataService loadJSONFielWithName:fileName];
        NSArray *listArray = responseObject[@"data"][@"list"];
        for (NSDictionary *dic in listArray) {
            Scene *scene = [[Scene alloc] init];
            scene.name = dic[@"name"];
            scene.imageName = dic[@"cover"];
            scene.num = dic[@"num"];
            [_scenes addObject:scene];
        }
        [self.tableView reloadData];
    }
    return self;
}
#pragma mark - Table view data source

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {

    return _scenes.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    SceneCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle] loadNibNamed:@"SceneCell" owner:nil options:nil] lastObject];;
    }
    cell.scene = _scenes[indexPath.row];

    return cell;
}
#pragma mark - 设置单元格高度
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {

    return 200;
}


@end
