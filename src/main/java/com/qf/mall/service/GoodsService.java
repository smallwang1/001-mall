package com.qf.mall.service;

import com.qf.mall.common.DataResult;
import com.qf.mall.common.GoodsSerchVo;
import com.qf.mall.pojo.Goods;

public interface GoodsService {
    DataResult update(Goods goods);

    DataResult getGoodsAllByLimit(GoodsSerchVo goodsSerchVo) ;
}
