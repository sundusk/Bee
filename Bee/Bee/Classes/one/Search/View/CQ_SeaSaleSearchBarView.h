//
//  CQ_SeaSaleSearchBarView.h
//  CCQ_Demo
//
//  Created by 神威 on 16/9/11.
//  Copyright © 2016年 ccq. All rights reserved.
//

#import <UIKit/UIKit.h>
@protocol SearchBarViewDelegate <NSObject>
@optional
/**
 搜索框开始编辑
 */
- (void)searchBarFieldDidBeginEditing:(UISearchBar *)searchBar;

/**
 搜索框结束编辑
 */
- (void)searchBarFieldDidEndEditing:(UISearchBar *)searchBar;

/**
 搜索框搜索按钮点击事件
 */
- (void)searchBarFieldButtonClicked:(UISearchBar *)searchBar;

/**
 搜索框更新编辑
 */
- (void)searchBarFieldChangeEditing:(NSString *)searchText;

@end
@interface CQ_SeaSaleSearchBarView : UIView<UITextFieldDelegate, UISearchBarDelegate>
{
@private
    UIButton *searchButton;
    
    //搜索框占字符
    NSString *_placeHolder;
    struct {
        unsigned int didBeginEdit;
        unsigned int didEndEdit;
        unsigned int didClicked ;
        unsigned int didChangeEdit ;
    } _delegateFlags;// delegate 响应标识
}



@property (nonatomic, assign) id<SearchBarViewDelegate>delegate;


@property (nonatomic, copy) NSString *searchContentKey;

@property (nonatomic, copy) UISearchBar *searchBar;;




/**
 * 重写初始化方法，加入代理
 */
- (instancetype)initWithFrame:(CGRect)frame
                  placeHolder:(NSString *)placeHolder
                     Delegate:(id<SearchBarViewDelegate>)delegate;

@end
