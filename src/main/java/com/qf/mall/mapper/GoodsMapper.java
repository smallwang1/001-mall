package com.qf.mall.mapper;

import com.qf.mall.common.GoodsSerchVo;
import com.qf.mall.common.UserSerchVo;
import com.qf.mall.pojo.GoodsVo;
import com.qf.mall.pojo.User;
import com.qf.mall.pojo.UserVo;

import java.util.List;

public interface GoodsMapper {


    List<GoodsVo> getAllGoodsByVo(GoodsSerchVo goodsSerchVo);

   /* User getUserById(String username);

    int addUser(User user);

    User findUserById(int id);

    int batchDeleteUserByIds(int[] idsArr);

    int updateById(User user);*/
}
