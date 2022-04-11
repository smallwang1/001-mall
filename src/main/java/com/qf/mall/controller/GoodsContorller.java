/*
package com.qf.mall.controller;

import com.alibaba.druid.util.StringUtils;
import com.qf.mall.common.DataResult;
import com.qf.mall.common.GoodsSerchVo;
import com.qf.mall.pojo.Goods;
import com.qf.mall.service.GoodsService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;
import java.io.UnsupportedEncodingException;


@RestController
@RequestMapping("goods")
public class GoodsContorller {
    @Autowired
    private GoodsService goodsService;

    @RequestMapping("list")
    public DataResult getAllGoods(GoodsSerchVo goodsSerchVo) throws UnsupportedEncodingException {
        if (!StringUtils.isEmpty(goodsSerchVo.getGoodsName())){
            goodsSerchVo.setGoodsName(new String(goodsSerchVo.getGoodsName().getBytes("ISO-8859-1"),"UTF-8"));
        }
        if (!StringUtils.isEmpty(goodsSerchVo.getGoodsTypeName())){
            goodsSerchVo.setGoodsTypeName(new String(goodsSerchVo.getGoodsTypeName().getBytes("ISO-8859-1"),"UTF-8"));
        }
        return goodsService.getGoodsAllByLimit(goodsSerchVo);
    }

    @PostMapping("update")
    public DataResult update(Goods goods){

        return GoodsService.update(goods);
    }


}
*/
