//
//  YQ_CategoryModel.h
//  Bee
//
//  Created by 黄跃奇 on 16/9/8.
//  Copyright © 2016年 ys. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface YQ_CategoryModel : NSObject

/**
 *  分类名称
 */
@property(copy, nonatomic) NSString *name;

/**
 *  产品列表id
 */
@property(copy, nonatomic) NSString *id;

@end

/*
 
 {
	visibility = 1;
	sort = 1;
	pcid = 55;
	id = a106;
	disabled_show = 0;
	name = 优选水果;
	icon = /upload/activity/2015071416553788.png;
 }
 
 */



