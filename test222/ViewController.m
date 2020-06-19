//
//  ViewController.m
//  test222
//
//  Created by yu shuhui on 2020/6/18.
//  Copyright © 2020 yu shuhui. All rights reserved.
//

#import "ViewController.h"
#import "ATableViewCell.h"

#define headerHeight 44
static CGFloat lastOffsetY;
static CGFloat  OffsetY;

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
{
    //是否上拉
    BOOL _isScrollUp;
    NSMutableDictionary<NSString*,UIView*> *headerViews;
}
#pragma mark - 表格
@property (nonatomic,strong)UITableView *tableview;

@end

@implementation ViewController{
    // MARK: 当前顶部悬停Section的section
    long _currentTopSectionViewCount;
}

// MARK: 宏定义颜色
#define normalColor [UIColor whiteColor]
#define highlightColor [UIColor redColor]


- (void)viewDidLoad {
    [super viewDidLoad];
    self.edgesForExtendedLayout = UIRectEdgeNone;
    
    headerViews = [NSMutableDictionary new];
    // Do any additional setup after loading the view.
    [self.view addSubview:self.tableview];//添加表格到视图
    self.tableview.bounces = NO;
    if (@available(iOS 11.0, *)) {
        self.tableview.contentInsetAdjustmentBehavior = UIScrollViewContentInsetAdjustmentNever;
    }else {
        self.automaticallyAdjustsScrollViewInsets = NO;
    }
    
}


-(UITableView *)tableview{
    if(_tableview == nil){
        _tableview = [[UITableView alloc]initWithFrame:CGRectMake(0, 44, self.view.bounds.size.width, self.view.bounds.size.height-44) style:UITableViewStylePlain];
        _tableview.dataSource = self;//遵循数据源
        _tableview.delegate = self;//遵循协议
    }
    return _tableview;
}

#pragma mark - UITableViewDelegate,UITableViewDataSource

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section{
    return headerHeight;
}
//表格组数 Sections 组
- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView{
    return 10;
}


// MARK: DataSource
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    ATableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"ATableViewCell"];
    if (cell == nil) {
        cell = [[ATableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ATableViewCell"];
    }
    [cell.leftimage setHidden:YES];
    cell.rightimage.text = [NSString stringWithFormat:@"第%ld行",(long)indexPath.row+1];
    return cell;
}


- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 3;
}

// MARK: Delegate
- (void)scrollViewDidScroll:(UIScrollView *)scrollView{
    
    
    
    if (scrollView == self.tableview) {
        
        ///记录当前组数
        NSMutableDictionary *dicM = [NSMutableDictionary dictionary];
        NSArray <ATableViewCell *> *cellArray = [self.tableview  visibleCells];
        //cell的section的最小值
        long cellSectionMINCount = LONG_MAX;
        for (int i = 0; i < cellArray.count; i++) {
            ATableViewCell *cell = cellArray[i];
            long cellSection = [self.tableview indexPathForCell:cell].section;
            [dicM setValue:@(cellSection) forKey:[NSString stringWithFormat:@"%ld",cellSection]];
            if (cellSection < cellSectionMINCount) {
                cellSectionMINCount = cellSection;
            }
        }
        
        _currentTopSectionViewCount = cellSectionMINCount;
        NSLog(@"当前悬停的组头是:%ld",_currentTopSectionViewCount);
        
        // MARK: 进行section的颜色设置
        NSDictionary *dic = dicM.copy;
        NSArray *allKeys = dic.allKeys;
        for (int i = 0; i < allKeys.count; i++) {
            NSString *sectionCountStr = [dicM objectForKey:allKeys[i]];
            NSInteger sectionCount = [sectionCountStr integerValue];
            ATableViewCell *sectionView = (ATableViewCell *)[self.tableview headerViewForSection:sectionCount];
            sectionView.contentView.backgroundColor = normalColor;
            if (sectionCount == _currentTopSectionViewCount) {
                sectionView.contentView.backgroundColor = highlightColor;
                
                OffsetY = 0;
                _isScrollUp = lastOffsetY < scrollView.contentOffset.y;
                OffsetY = lastOffsetY - scrollView.contentOffset.y;
                lastOffsetY = scrollView.contentOffset.y;
                NSLog(@"%f",lastOffsetY);
                NSString *key = [NSString stringWithFormat:@"%ld",_currentTopSectionViewCount];
                ATableViewCell *header = ( ATableViewCell *)headerViews[key];
                [header setRightView:YES Scroll:OffsetY];
                
            } else {
                sectionView.contentView.backgroundColor = normalColor;
                //  [sectionView setRightView:NO Scroll:1];
            }
        }
    }
}

- (UIView *)tableView:(UITableView *)tableView viewForHeaderInSection:(NSInteger)section {
    
    NSString *key = [NSString stringWithFormat:@"%zd",section];
    ATableViewCell *header = headerViews[key];
    
    if(!header){
        
        header = [tableView dequeueReusableCellWithIdentifier:@"ATableViewCell1"];
        if (header == nil) {
            header = [[ATableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"ATableViewCell1"];
        }
        header.leftimage.text = [NSString stringWithFormat:@"第%ld组",(long)section];
        header.rightimage.text = [NSString stringWithFormat:@"第0行"];
        
        //缓存组头
        headerViews[key] = header;
        
    }
    
    return header;
}




//- (void)tableView:(UITableView *)tableView willDisplayHeaderView:(nonnull UIView *)view forSection:(NSInteger)section{
//    // if(!_isUpScroll && (self.tableview.dragging || self.tableview.decelerating)){
//    //最上面组头（不一定是第一个组头，指最近刚被顶出去的组头）又被拉回来
//    NSLog(@"_isUpScroll");
//    ATableViewCell *header = (ATableViewCell *)view;
//    NSLog(@"++%@",header.leftimage.text);
//    //        [header setRightView:NO];
//    // }
//}
//
//- (void)tableView:(UITableView *)tableView didEndDisplayingHeaderView:(UIView *)view forSection:(NSInteger)section{
//    //   if((self.tableview.dragging || self.tableview.decelerating)&& _isUpScroll){
//    //最上面的组头被顶出去
//    NSLog(@"_isUpScroll ---- ");
//    ATableViewCell *header = (ATableViewCell *)view;
//    NSLog(@"++%@",header.leftimage.text);
//    //        [header setRightView:YES];
//    //  }
//
//}

// 标记一下TableView的滚动方向，是向上还是向下
//- (void)scrollViewDidScroll:(UIScrollView *)scrollView
//{
//    // 判断滑动到cell和setion重叠的时候 cell 位移第一个可视范围的section的右边 向上滚动
//
//    static CGFloat lastOffsetY = 0;
//    _isUpScroll = lastOffsetY < scrollView.contentOffset.y;
//    lastOffsetY = scrollView.contentOffset.y;
//   // NSLog(@"_isUpScroll ---- ……%f ",scrollView.contentOffset.y);
//    
//}



@end
