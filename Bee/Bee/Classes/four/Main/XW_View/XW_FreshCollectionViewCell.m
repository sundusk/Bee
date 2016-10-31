//
//  XW_FreshCollectionViewCell.m
//  Bee
//
//  Created by 9264 on 16/9/9.
//  Copyright © 2016年 ys. All rights reserved.
//

#import "XW_FreshCollectionViewCell.h"
#import "UIImageView+WebCache.h"
#import "YQ_ProductsOrderControl.h"

@interface XW_FreshCollectionViewCell()
@property(weak,nonatomic)UIImageView *imageView;
@property(weak,nonatomic)UILabel *nameLabel;
@property(weak,nonatomic)UIImageView *preferentialImageView;
@property(weak,nonatomic)UILabel *sizeLabel;
@property(weak,nonatomic)UILabel *priceLabel;
@property(weak,nonatomic)UILabel *partner_priceLabel;
@property(weak,nonatomic)UILabel *numberLabel;
@property(weak,nonatomic)UIButton *reduceButton;
@property(weak,nonatomic)UIImageView *recommendedImageView;
@end
@implementation XW_FreshCollectionViewCell{
    
}
- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.count = 0;
        [self setupUI];
    }
    return self;
}

#pragma mark - 搭建新鲜热卖cell
- (void)setupUI {
    self.count = 0;
    //MARK:- 添加控件
    self.backgroundColor = [UIColor whiteColor];
    UIImageView *imageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"L1"]];
    [self.contentView addSubview:imageView];
    //名字
    UILabel *nameLabel = [UILabel bee_labelWithText:@"路飞" andColor:[UIColor blackColor] andFontSize:14];
    nameLabel.numberOfLines = 1;
    [self.contentView addSubview:nameLabel];
    //精选
    UIImageView *boutiqueImageView = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"jingxuan.png"]];
    [self.contentView addSubview:boutiqueImageView];
    //买一赠一
    UIImageView *preferentialImageView = [[UIImageView alloc]initWithImage:nil];
    [self.contentView addSubview:preferentialImageView];
    //推荐
    UIImageView *recommendedImageView = [[UIImageView alloc]initWithImage:nil];
    [self.contentView addSubview:recommendedImageView];
    //规格
    UILabel *sizeLabel = [UILabel bee_labelWithText:@"1-4档" andColor:[UIColor grayColor] andFontSize:12];
    [self.contentView addSubview:sizeLabel];
    //现价
    UILabel *priceLabel = [UILabel bee_labelWithText:@"9.99" andColor:[UIColor redColor] andFontSize:13];
    [self.contentView addSubview:priceLabel];
    //分割线
    UIView *partitionView = [[UIView alloc]init];
    partitionView.backgroundColor = [UIColor blackColor];
    [self.contentView addSubview:partitionView];
    //横线
    UIView *HRView = [[UIView alloc]init];
    HRView.backgroundColor = [UIColor grayColor];
    [self.contentView addSubview:HRView];
    //原价
    UILabel *partner_priceLabel = [UILabel bee_labelWithText:@"9999" andColor:[UIColor grayColor] andFontSize:10];
    [self.contentView addSubview:partner_priceLabel];
    //数量加减,自定义control类描述加减,设置值改变事件
    YQ_ProductsOrderControl *orderControl = [YQ_ProductsOrderControl productsOrderControl];
//    _orderControl = orderControl;
    
    // 监听数量控件的值改变事件
//    [orderControl addTarget:self action:@selector(orderControlValueChanged:) forControlEvents:UIControlEventValueChanged];
    [self.contentView addSubview:orderControl];
    
    // 监听数量控件的值改变事件
    [orderControl addTarget:self action:@selector(orderControlValueChanged:) forControlEvents:UIControlEventValueChanged];
    
    //设置约束
    [orderControl mas_makeConstraints:^(MASConstraintMaker *make) {
        make.bottom.equalTo(self.contentView).offset(-10);
        make.right.equalTo(self.contentView).offset(0);
        make.size.mas_equalTo(CGSizeMake(80, 25));
    }];
//    //增加按钮
//    UIButton *addButton = [[UIButton alloc]init];
//    [addButton setImage:[UIImage imageNamed:@"v2_increase"] forState:UIControlStateNormal];
//    [addButton addTarget:self action:@selector(buyBuybBuy:) forControlEvents:UIControlEventTouchUpInside ];
//    [self.contentView addSubview:addButton];
//    //数量label
//    UILabel *numberLabel = [UILabel bee_labelWithText:@"0" andColor:[UIColor blackColor] andFontSize:13];
//    [self.contentView addSubview:numberLabel];
//    //减少按钮
//    UIButton *reduceButton = [[UIButton alloc]init];
//    [reduceButton setImage:[UIImage imageNamed:@"v2_reduce"] forState:UIControlStateNormal];
//    [reduceButton addTarget:self action:@selector(returnedGoods:) forControlEvents:UIControlEventTouchUpInside];
//    [self.contentView addSubview:reduceButton];
    
    //MARK:- 设置约束
    //图片
    [imageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.left.right.equalTo(self.contentView);
        make.width.mas_equalTo(self.contentView.size.width);
        make.height.offset(140);
        
    }];
    //name
    [nameLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(imageView.mas_bottom).offset(5);
        make.right.equalTo(imageView.mas_right).offset(-10);
        make.left.equalTo(imageView).offset(10);
        make.width.mas_equalTo(self.contentView.size.width - 20);
    }];
    //精选
    [boutiqueImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(nameLabel.mas_bottom).offset(3);
        make.left.equalTo(nameLabel);
        make.height.offset(15);
        make.width.offset(30);
    }];
    //买一赠一
        [preferentialImageView mas_makeConstraints:^(MASConstraintMaker *make) {
            make.top.equalTo(boutiqueImageView);
            make.left.equalTo(boutiqueImageView.mas_right).offset(3);
            make.height.offset(15);
            make.width.offset(30);
        }];
    //推荐
    [recommendedImageView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(self.contentView);
        make.right.offset(-10);
        make.width.offset(20);
        make.height.offset(40);
    }];
    //规格
    [sizeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(boutiqueImageView.mas_bottom).offset(3);
        make.left.equalTo(boutiqueImageView);
    }];
    //现价
    [priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(sizeLabel.mas_bottom).offset(0);
        make.left.equalTo(sizeLabel);
    }];
    //分割线
    [partitionView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.top.equalTo(priceLabel);
        make.left.equalTo(priceLabel.mas_right).offset(5);
        make.height.equalTo(priceLabel);
        make.width.offset(0.5);
    }];
    //原价
    [partner_priceLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerY.equalTo(partitionView);
        make.left.equalTo(partitionView.mas_right).offset(5);
    }];
    //横线
    [HRView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.center.equalTo(partner_priceLabel);
        make.width.offset(30);
        make.height.offset(0.8);
    }];
//    //增加按钮
//    [addButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.right.bottom.offset(-5);
//        make.height.width.offset(20);
//    }];
//    //数量label
//    [numberLabel mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.equalTo(addButton);
//        make.right.equalTo(addButton.mas_left).offset(-3);
//    }];
//    //减少按钮
//    [reduceButton mas_makeConstraints:^(MASConstraintMaker *make) {
//        make.centerY.equalTo(numberLabel);
//        make.right.equalTo(numberLabel.mas_left).offset(-3);
//        make.height.width.offset(20);
//    }];
    
    /*
     赋值
     */
    _imageView = imageView;
    _nameLabel = nameLabel;
    _sizeLabel = sizeLabel;
    _priceLabel = priceLabel;
    _partner_priceLabel = partner_priceLabel;
    _preferentialImageView = preferentialImageView;
//    _numberLabel = numberLabel;
//    _reduceButton = reduceButton;
    _recommendedImageView = recommendedImageView;
    //调用setCount方法
    if (self.count == 0) {
        [self setCount:0];
    }
}

#pragma mark - 监听数量改变的事件
- (void)orderControlValueChanged:(YQ_ProductsOrderControl *)sender {
    // 1.将接收的数量信息,设置给自己的模型!
    
    //     2.搞清楚,是增加还是减少
    if (sender.isIncrease) {
        
        //通知发出模型数据
        [[NSNotificationCenter defaultCenter] postNotificationName:@"addProducts" object:_freshModel];
//        //数组内没有商品则添加模型
//        if (_selectedModelList.count == 0) {
//            [_selectedModelList addObject:_freshModel];
//        }else{
//        [_selectedModelList enumerateObjectsUsingBlock:^(XW_FreshModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
//            if (![_freshModel.name isEqualToString:obj.name]) {
//                [_selectedModelList addObject:_freshModel];
//            }
//        }];
//        }
//        if (![[DQ_SelectedGoods sharedSelectedGoods].selectedGoodsArry containsObject:_freshModel]) {
//            [[DQ_SelectedGoods sharedSelectedGoods].selectedGoodsArry addObject: _freshModel];
//        }
        
        UIImageView *imgView = [[UIImageView alloc] initWithImage:_imageView.image];
        imgView.size = _imageView.size;
        
        UIWindow *keyW = [UIApplication sharedApplication].keyWindow;
        _startP = [self convertPoint:_imageView.center toView:keyW];
        [keyW addSubview:imgView];
        
        CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:@"position"];
        [anim setValue:imgView forKey:@"imgV"];
        //设置动画
        [UIView animateWithDuration:1.4 animations:^{
            UIBezierPath *path = [UIBezierPath bezierPath];
            [path moveToPoint:_startP];
            
            CGPoint endP = CGPointMake(235, keyW.bounds.size.height - 45);
            [path addQuadCurveToPoint:endP controlPoint:sender.center];
            anim.path = path.CGPath;
            
            imgView.size = CGSizeZero;
            
        }];
        
        anim.removedOnCompletion = NO;
        anim.fillMode = kCAFillModeForwards;
        // 设置动画时间
        anim.duration = 1;
        anim.delegate = self;
        [imgView.layer addAnimation:anim forKey:nil];
        //模型数量加减,判断是否为0,从模型数组中移除
//        [[NSNotificationCenter defaultCenter] postNotificationName:@"AddGoods" object:_model];
        
    } else {
        
        //移除商品的通知
        [[NSNotificationCenter defaultCenter] postNotificationName:@"reduceProdcts" object:_freshModel];
//        //商品数量为0移除
//        if (sender.count == 0) {
//            [[DQ_SelectedGoods sharedSelectedGoods].selectedGoodsArry removeObject:_freshModel];
//        }
//        [[NSNotificationCenter defaultCenter] postNotificationName:@"ReduceGoods" object:_model];
    }
    
    
}

#pragma mark - 赋值
-(void)setFreshModel:(XW_FreshModel *)freshModel
{
    _freshModel = freshModel;
    NSURL *url = [NSURL URLWithString:freshModel.img];
    [_imageView sd_setImageWithURL:url];
    _nameLabel.text = freshModel.name;
    _sizeLabel.text = freshModel.specifics;
    _priceLabel.text = freshModel.price;
    _partner_priceLabel.text = freshModel.market_price;
    if ([freshModel.pm_desc isEqualToString:@"买一赠一"]) {
        _preferentialImageView.image = [UIImage imageNamed:@"buyOne.png"];
    }
    if ([freshModel.brand_name isEqualToString:@"爱鲜蜂"]) {
        _recommendedImageView.image = [UIImage imageNamed:@"Recommend"];
    }
}

////#pragma mark - 购买事件
//- (void)buyBuybBuy:(UIButton *)sender{
//    self.count++;
//    
//    UIImageView *imgView = [[UIImageView alloc] initWithImage:_imageView.image];
//    imgView.size = _imageView.size;
//    
//    UIWindow *keyW = [UIApplication sharedApplication].keyWindow;
//    _startP = [self convertPoint:_imageView.center toView:keyW];
//    [keyW addSubview:imgView];
//    
//    CAKeyframeAnimation *anim = [CAKeyframeAnimation animationWithKeyPath:@"position"];
//    [anim setValue:imgView forKey:@"imgV"];
//    //设置动画     
//    [UIView animateWithDuration:1.4 animations:^{
//        UIBezierPath *path = [UIBezierPath bezierPath];
//        [path moveToPoint:_startP];
//        
//        CGPoint endP = CGPointMake(235, keyW.bounds.size.height - 45);
//        [path addQuadCurveToPoint:endP controlPoint:sender.center];
//        anim.path = path.CGPath;
//        
//        imgView.size = CGSizeZero;
//        
//    }];
//    
//    anim.removedOnCompletion = NO;
//    anim.fillMode = kCAFillModeForwards;
//    // 设置动画时间
//    anim.duration = 1;
//    anim.delegate = self;
//    [imgView.layer addAnimation:anim forKey:nil];
//}

#pragma mark - 核心动画的代理方法
- (void)animationDidStop:(CAAnimation *)anim finished:(BOOL)flag {
    //1. 取出图片框
    UIImageView *imgV = [anim valueForKey:@"imgV"];
    //2. 移除核心动画
    [imgV.layer removeAllAnimations];
    //3. 移除图片框
    [imgV removeFromSuperview];
}

//#pragma mark - 退货事件
//- (void)returnedGoods:(UIButton *)sender{
//    self.count--;
//    
//}
//
//#pragma mark - 重写count的set方法
//- (void)setCount:(NSInteger)count {
//    _count = count;
//    if (count > 0) {
//        _reduceButton.hidden = NO;
//        _numberLabel.hidden = NO;
//    } else {
//        _reduceButton.hidden = YES;
//        _numberLabel.hidden = YES;
//    }
//    _numberLabel.text = @(count).description;
//}

@end
