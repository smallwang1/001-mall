package com.qf.mall.mapper;

import com.qf.mall.common.UserSerchVo;
import com.qf.mall.pojo.User;
import com.qf.mall.pojo.UserVo;

import java.util.List;

public interface UserMapper {
    User getUserByName(String username);

    List<UserVo> getAllUserByVo(UserSerchVo userSerchVo);

    int addUser(User user);

    User findUserById(int id);

    int batchDeleteUserByIds(int[] idsArr);

    int updateById(User user);
}
