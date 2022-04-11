package com.qf.mall.service;

import com.qf.mall.common.DataResult;
import com.qf.mall.common.UserSerchVo;
import com.qf.mall.pojo.User;
import com.qf.mall.pojo.UserVo;

import java.util.List;

public interface UserService {
    DataResult getUserByNamePsw(String username,String password);

    DataResult getUserAllByLimit(UserSerchVo userSerchVo);

    DataResult addUser(User user);

    DataResult batchDeleteUser(int[] idsArr);

    DataResult update(User user);
}
