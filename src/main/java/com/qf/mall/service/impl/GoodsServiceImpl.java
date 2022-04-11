/*
package com.qf.mall.service.impl;

import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.qf.mall.common.DataResult;
import com.qf.mall.common.GoodsSerchVo;
import com.qf.mall.mapper.GoodsMapper;
import com.qf.mall.pojo.Goods;
import com.qf.mall.pojo.GoodsVo;
import com.qf.mall.pojo.UserVo;
import com.qf.mall.service.GoodsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.List;

@Service
public class GoodsServiceImpl implements GoodsService {
    @Autowired
    GoodsMapper goodsMapper;

    @Override
    public DataResult update(Goods goods) {
        int row = goodsMapper.updateById(goods);
        if(row>0){
            return DataResult.ok("修改成功");
        }
        return DataResult.err("修改失败");
    }

    @Override
    public DataResult getGoodsAllByLimit(GoodsSerchVo goodsSerchVo) {
        PageHelper.startPage(goodsSerchVo.getPage(),goodsSerchVo.getLimit());
        List<GoodsVo> goodsVoList = goodsMapper.getAllGoodsByVo(goodsSerchVo);
        PageInfo<GoodsVo> pageInfo = new PageInfo<>(goodsVoList);
        return DataResult.returnPageLimit(pageInfo.getTotal(),pageInfo.getList());
    }
}
*/
