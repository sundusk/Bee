//
//  CQ_SeaSaleSearchBarView.m
//  CCQ_Demo
//
//  Created by 神威 on 16/9/11.
//  Copyright © 2016年 ccq. All rights reserved.
//

#import "CQ_SeaSaleSearchBarView.h"

@implementation CQ_SeaSaleSearchBarView


- (instancetype)initWithFrame:(CGRect)frame
                  placeHolder:(NSString *)placeHolder
                     Delegate:(id<SearchBarViewDelegate>)delegate
{
    self = [super initWithFrame:frame];
    if (self) {
        
        self.delegate = delegate;
        
        [self setup:frame];
    }
    return self;
}

- (void)setup:(CGRect)rect{
    self.backgroundColor = [UIColor whiteColor];
    self.layer.borderColor = [UIColor lightGrayColor].CGColor;
    self.layer.borderWidth = 0.8;
    
    // _searchBar
    _searchBar = [[UISearchBar alloc] initWithFrame:CGRectMake(0, 0, rect.size.width, rect.size.height)];
    //对文本对象自动校正风格
    _searchBar.autocorrectionType = UITextAutocorrectionTypeNo;
    //设置某种情况下大写
    _searchBar.autocapitalizationType = UITextAutocapitalizationTypeNone;
    //键盘样式
    _searchBar.keyboardType = UIKeyboardTypeDefault;
    _searchBar.returnKeyType = UIReturnKeySearch;
    _searchBar.backgroundColor=[UIColor clearColor];
    _searchBar.translucent = YES;//barTintColor
    _searchBar.barStyle = UIBarStyleDefault;
    //搜索框的颜色
    _searchBar.backgroundColor=[UIColor clearColor];
     _searchBar.placeholder = _placeHolder;;
    _searchBar.delegate = self;
    _searchBar.tintColor=[UIColor grayColor];
    for (UIView *view in _searchBar.subviews) {
        // for before iOS7.0
        if ([view isKindOfClass:NSClassFromString(@"UISearchBarBackground")]) {
            [view removeFromSuperview];
            break;
        }
        // for later iOS7.0(include)
        if ([view isKindOfClass:NSClassFromString(@"UIView")] && view.subviews.count > 0) {
            [[view.subviews objectAtIndex:0] removeFromSuperview];
            UITextField *textField = [view.subviews objectAtIndex:0];
            textField.returnKeyType = UIReturnKeyDone;
            break;
            
        }
    } 
    [self addSubview:_searchBar];
    
}

#pragma mark -- setter(delegate)
- (void)setDelegate:(id<SearchBarViewDelegate>)delegate
{
    _delegate = delegate;
    
        _delegateFlags.didClicked = [_delegate respondsToSelector:@selector(searchBarFieldButtonClicked:)];
}


#pragma mark -- UISearchBarDelegate


- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar
{
    [searchBar resignFirstResponder];
    
    if (_delegateFlags.didClicked) {
        [self.delegate searchBarFieldButtonClicked:_searchBar];
    }
    
}





@end
