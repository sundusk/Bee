//
//  LW_OrderCell.m
//  Bee
//
//  Created by huanglinwang on 16/9/8.
//  Copyright © 2016年 ys. All rights reserved.
//

#import "LW_OrderCell.h"

#import "LW_OrderGoodsModel.h"
#import "UIImageView+WebCache.h"

@interface LW_OrderCell()

@property (weak, nonatomic) IBOutlet UIView *imageListV;
@property (weak, nonatomic) IBOutlet UILabel *countL;
@property (weak, nonatomic) IBOutlet UILabel *lastUpdateTimeL;
@property (weak, nonatomic) IBOutlet UILabel *textStatusL;
@property (weak, nonatomic) IBOutlet UILabel *prictL;
@property (weak, nonatomic) IBOutlet UIButton *welfareBtn;


@end

@implementation LW_OrderCell{
    NSArray<LW_OrderGoodsModel *> *_arrayM;
    

}

- (void)awakeFromNib {
    [super awakeFromNib];
    self.selectionStyle = UITableViewCellSelectionStyleNone;
    
    self.welfareBtn.layer.cornerRadius = 5;
    self.welfareBtn.layer.masksToBounds = YES;
    
}
#pragma mark - 传值

-(void)setModel:(LW_OrderModel *)model{
    _model = model;
    
    //价格
    __block float Allprict;
    //时间
    self.lastUpdateTimeL.text = model.lastUpdateTime;
    //状态
    self.textStatusL.text = model.textStatus;
    
    
    
    _arrayM = model.order_goods;
    
    self.countL.text = [NSString stringWithFormat:@"一共有%zd种类商品",_arrayM.count];
    
    
    if (_arrayM.count < 4) {
        //如果物品种类小于4
        
    [_arrayM enumerateObjectsUsingBlock:^(LW_OrderGoodsModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            
            Allprict += obj.goods_price.floatValue * obj.goods_nums.floatValue;
            self.prictL.text = [NSString stringWithFormat:@"%.2f",Allprict];
       
            
            UIImageView *imageV = [[UIImageView alloc]init];
            [imageV sd_setImageWithURL:[NSURL URLWithString:obj.img]];
            [self.imageListV addSubview:imageV];
            
            [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
                make.top.bottom.equalTo(self.imageListV);
                make.size.mas_equalTo(CGSizeMake(50, 50));
                make.left.equalTo(self.imageListV).offset(idx * 50);
            }];
        }];
        
        
        
    }else{
        
        
        //如果物品数量大于4
        [_arrayM enumerateObjectsUsingBlock:^(LW_OrderGoodsModel * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
            //如果是四个之前
            if (idx < 4) {
                
                
                Allprict += obj.goods_price.floatValue * obj.goods_nums.floatValue;
                self.prictL.text = [NSString stringWithFormat:@"%.2f",Allprict];
               
                
                UIImageView *imageV = [[UIImageView alloc]init];
                [imageV sd_setImageWithURL:[NSURL URLWithString:obj.img]];
                [self.imageListV addSubview:imageV];
                
                
                [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.bottom.equalTo(self.imageListV);
                    make.size.mas_equalTo(CGSizeMake(50, 50));
                    make.left.equalTo(self.imageListV).offset(idx * 50);
                }];
               
                
            }else{
                Allprict += obj.goods_price.floatValue * obj.goods_nums.floatValue;
                self.prictL.text = [NSString stringWithFormat:@"%.2f",Allprict];
                
                
                //如果是第四个
                UIImageView *imageV = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"v2_goodmore"]];
                
                [self.imageListV addSubview:imageV];
                
                
                [imageV mas_makeConstraints:^(MASConstraintMaker *make) {
                    make.top.bottom.equalTo(self.imageListV);
                    make.size.mas_equalTo(CGSizeMake(50, 50));
                    make.left.equalTo(self.imageListV).offset(idx * 50);
                }];
                
                //  判断停止的条件 - 注意 *stop不会立即停止,而是执行完成以后结束
                *stop = YES;
                
            }
        }];
    }
}



@end
