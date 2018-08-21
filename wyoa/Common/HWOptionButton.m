//
//  HWOptionButton.m
//  wyoa
//
//  Created by apple on 2018/8/18.
//  Copyright © 2018年 zjf. All rights reserved.
//

#import "HWOptionButton.h"

#define KMainW [UIScreen mainScreen].bounds.size.width
#define KMainH [UIScreen mainScreen].bounds.size.height
#define KMarginYWhenMoving 20.0f
#define KRowHeight 44.0f
#define KMaxShowLine 7
#define KFont [UIFont systemFontOfSize:20.0f]
#define KBackColor [UIColor whiteColor]

@interface HWOptionButton ()<UITableViewDelegate, UITableViewDataSource, UISearchBarDelegate>

@property (nonatomic, strong) NSArray *searchArray;
@property (nonatomic, strong) UIWindow *cover;
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) UISearchBar *searchBar;
@property (nonatomic, weak) UIView *view;
@property (nonatomic, weak) UIButton *button;
@property (nonatomic, assign, readwrite) NSInteger row;

@end

@implementation HWOptionButton

static NSString *KOptionButtonCell = @"KOptionButtonCell";

- (instancetype)initWithFrame:(CGRect)frame
{
    if (self = [super initWithFrame:frame]) {
        [self setup];
    }
    
    return self;
}

- (instancetype)initWithCoder:(NSCoder *)coder
{
    if (self = [super initWithCoder:coder]) {
        [self setup];
    }
    
    return self;
}

- (void)setup {
    self.title = [self getweekDay];
    
    UIButton *button = [[UIButton alloc] initWithFrame:self.bounds];
   
    [button setTitleColor:[UIColor colorWithHexString:@"333333"] forState:UIControlStateNormal];
    [button setTitleColor:[UIColor colorWithHexString:@"333333"] forState:UIControlStateSelected];
    [button setImage:[UIImage imageNamed:@"sanjiao"] forState:UIControlStateNormal];
    [button setTitle:_title forState:UIControlStateNormal];
//    [button setBackgroundColor:[UIColor redColor]];
    [button addTarget:self action:@selector(buttonAction:) forControlEvents:UIControlEventTouchUpInside];
    UIImage *image =button.imageView.image;
    UILabel *titleLabel =button.titleLabel;
    titleLabel.font=KFont;
    titleLabel.center=button.center;
    [button setTitleEdgeInsets:UIEdgeInsetsMake(0, -image.size.width, 0, image.size.width)];
    [button setImageEdgeInsets:UIEdgeInsetsMake(0, titleLabel.bounds.size.width+20, 0, -titleLabel.bounds.size.width)];
    [self addSubview:button];
    self.button = button;
    
    //搜索框
    _searchBar = [[UISearchBar alloc] init];
    _searchBar.barTintColor = KBackColor;
    _searchBar.layer.borderWidth = 1.0f;
    _searchBar.layer.borderColor = [[UIColor blackColor] CGColor];
    _searchBar.delegate = self;
    _searchBar.keyboardType = UIKeyboardTypeASCIICapable;
    
    //选项视图
    _tableView = [[UITableView alloc] init];
    _tableView.rowHeight = KRowHeight;
    _tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    _tableView.layer.borderWidth = 1.0f;
    _tableView.layer.borderColor = [[UIColor blackColor] CGColor];
    _tableView.dataSource = self;
    _tableView.delegate = self;
    
    self.showPlaceholder = YES;
    self.showSearchBar = NO;
    
}

- (void)buttonAction:(UIButton *)button
{
    [self creatControl];
    
    [self endEditing];
}

- (void)creatControl
{
    //遮盖window
    _cover = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    _cover.windowLevel = UIWindowLevelAlert;
    _cover.hidden = NO;
    
    //window视图
    UIView *view = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    [_cover addSubview:view];
    self.view = view;
    
    //遮盖视图
    UIView *backview = [[UIView alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    backview.backgroundColor = [UIColor colorWithRed:(0)/255.0 green:(0)/255.0 blue:(0)/255.0 alpha:0.0f];
    [backview addGestureRecognizer:[[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(Tap:)]];
    [self.view addSubview:backview];
    
    //坐标转换
    CGRect frame = [self.superview convertRect:self.frame toView:self.view];
    
    //显示选项按钮
//    UIButton *button = [[UIButton alloc] initWithFrame:CGRectMake(frame.origin.x, frame.origin.y, self.frame.size.width, self.frame.size.height)];
//    button.titleLabel.font = KFont;
//    [button setTitle:_button.titleLabel.text forState:UIControlStateNormal];
//    [button setTitleColor:[UIColor greenColor] forState:UIControlStateNormal];
//    [button addTarget:self action:@selector(btnOnClick) forControlEvents:UIControlEventTouchUpInside];
//    [button setBackgroundImage:[UIImage imageNamed:@"optionBtn_sel"] forState:UIControlStateNormal];
//    [self.view addSubview:button];
    
    //搜索框
    if (_showSearchBar) {
        _searchBar.frame = CGRectMake(frame.origin.x, CGRectGetMaxY(frame), frame.size.width, KRowHeight);
        [self.view addSubview:_searchBar];
    }
    
    //设置tableviewFrame
    NSInteger rowCount = _showSearchBar ? KMaxShowLine - 1 : KMaxShowLine;
    CGFloat tabelViewY = _showSearchBar ? CGRectGetMaxY(_searchBar.frame) : CGRectGetMaxY(frame);
    if (_array.count <= rowCount) {
        _tableView.frame = CGRectMake(frame.origin.x, tabelViewY, frame.size.width, _array.count * KRowHeight);
    }else {
        _tableView.frame = CGRectMake(frame.origin.x, tabelViewY, frame.size.width, rowCount * KRowHeight);
    }
    
    [self.view addSubview:_tableView];
}

- (void)endEditing
{
    [[[self findViewController] view] endEditing:YES];
}

- (UIViewController *)findViewController
{
    id target = self;
    while (target) {
        target = ((UIResponder *)target).nextResponder;
        if ([target isKindOfClass:[UIViewController class]]) {
            break;
        }
    }
    return target;
}

- (void)setArray:(NSArray *)array
{
    _array = array;
    
    self.searchArray = [_array copy];
    
    [self setInfo];
}

- (void)setShowPlaceholder:(BOOL)showPlaceholder
{
    _showPlaceholder = showPlaceholder;
    
    [self setInfo];
}

- (void)setInfo
{
    if (!_showPlaceholder && _array.count > 0) {
        [_button setSelected:YES];
        _title = _array[0];
        [_button setTitle:_title forState:UIControlStateNormal];
    }
    
    [_tableView reloadData];
}

- (void)btnOnClick
{
    [self dismissOptionAlert];
}

- (void)Tap:(UITapGestureRecognizer *)recognizer
{
    [self dismissOptionAlert];
}

- (void)dismissOptionAlert
{
    [_searchBar resignFirstResponder];
    
    if (self.view.frame.origin.y == 0) {
        [self removeCover];
    }else {
        [self searchBarTextDidEndEditing:_searchBar];
    }
}

- (void)removeCover
{
    [_searchBar resignFirstResponder];
    _cover.hidden = YES;
    _cover = nil;
}

#pragma mark - UISearchBarDelegate
- (void)searchBar:(UISearchBar *)searchBar textDidChange:(NSString *)searchText
{
    if (searchText.length > 0) {
        NSPredicate *predicate = [NSPredicate predicateWithFormat:@"SELF CONTAINS[c] %@", searchText];
        _searchArray = [[_array filteredArrayUsingPredicate:predicate] copy];
    }else {
        _searchArray = [_array copy];
    }
    
    [_tableView reloadData];
}

- (BOOL)searchBarShouldBeginEditing:(UISearchBar *)searchBar
{
    UIView *view = self.superview;
    while (view.superview) {
        view = view.superview;
    }
    
    CGFloat Y = KMarginYWhenMoving - [self.superview convertRect:self.frame toView:self.view].origin.y;
    [UIView animateWithDuration:0.22f animations:^{
        view.frame = CGRectMake(0, Y, KMainW, KMainH);
        self.view.frame = CGRectMake(0, Y, KMainW, KMainH);
    }];
    
    return YES;
}

- (void)searchBarTextDidEndEditing:(UISearchBar *)searchBar
{
    UIView *view = self.superview;
    while (view.superview) {
        view = view.superview;
    }
    
    [UIView animateWithDuration:0.22f animations:^{
        view.frame = CGRectMake(0, 0, KMainW, KMainH);
        self.view.frame = CGRectMake(0, 0, KMainW, KMainH);
    }completion:^(BOOL finished) {
        [self removeCover];
    }];
}

#pragma mark - tableViewDelegate
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _searchArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:KOptionButtonCell];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:KOptionButtonCell];
    }
    cell.textLabel.text = _searchArray[indexPath.row];
    cell.backgroundColor = [UIColor whiteColor];
    cell.textLabel.font = KFont;
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    _row = indexPath.row;
    [_button setSelected:YES];
    self.title = _searchArray[_row];
    [self.button setTitle:self.title forState:UIControlStateNormal];
    [self dismissOptionAlert];
    
    if (_delegate && [_delegate respondsToSelector:@selector(didSelectOptionInHWOptionButton:)]) {
        [_delegate didSelectOptionInHWOptionButton:self];
    }
}

-(NSString *) getweekDay{
    NSCalendar * calendar = [[NSCalendar alloc] initWithCalendarIdentifier:NSGregorianCalendar]; // 指定日历的算法
    NSDateComponents *comps = [calendar components:NSWeekdayCalendarUnit fromDate:[NSDate date]];
    // 1 是周日，2是周一 3.以此类推
    
    NSNumber * weekNumber = @([comps weekday]);
    
    NSInteger weekInt = [weekNumber integerValue];
    
    NSString *weekDayString = @"星期一";
    switch (weekInt) {
        case 1:
        {
            weekDayString = @"星期日";
        }
            break;
        case 2:
        {
            weekDayString = @"星期一";
        }
            break;
        case 3:
        {
            weekDayString = @"星期二";
        }
            break;
        case 4:
        {
            weekDayString = @"星期三";
        }
            break;
        case 5:
        {
            weekDayString = @"星期四";
        }
            break;
        case 6:
        {
            weekDayString = @"星期五";
        }
            break;
        case 7:
        {
            weekDayString = @"星期六";
        }
            break;
        default:
            break;
    }
    return weekDayString;
    
}
@end
