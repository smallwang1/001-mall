package com.qf.mall.service.impl;


import com.github.pagehelper.PageHelper;
import com.github.pagehelper.PageInfo;
import com.qf.mall.common.DataResult;
import com.qf.mall.common.UserSerchVo;
import com.qf.mall.mapper.UserMapper;
import com.qf.mall.pojo.User;
import com.qf.mall.pojo.UserVo;
import com.qf.mall.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;
import java.util.List;

@Service
public class UserServiceImpl implements UserService {
    @Autowired
    private UserMapper userMapper;
    @Override
    @Transactional(readOnly = true)
    public DataResult getUserByNamePsw(String username, String password) {
       //先判断是否有这个用户
        User user = userMapper.getUserByName(username);

        if(user==null){
          return   DataResult.err("该用户不存在！");
        }
        if (!user.getPassword().equals(password)){
          return   DataResult.err("密码输入错误");
        }
        return DataResult.ok(user);
    }

    @Override
    public DataResult getUserAllByLimit(UserSerchVo userSerchVo) {
        PageHelper.startPage(userSerchVo.getPage(),userSerchVo.getLimit());
        List<UserVo> userVoList = userMapper.getAllUserByVo(userSerchVo);
        PageInfo<UserVo> pageInfo = new PageInfo<>(userVoList);
        return DataResult.returnPageLimit(pageInfo.getTotal(),pageInfo.getList());
    }

    @Override
    @Transactional
    public DataResult addUser(User user) {
        int count = userMapper.addUser(user);

        if (count>0){
            return DataResult.ok("用户添加成功");
        }
            return DataResult.err("用户添加失败");
        }

    @Override
    @Transactional
    public DataResult batchDeleteUser(int[] idsArr) {
        boolean flag=true;
        //超级管理员不能删
        //先查询谁是超级管理员
        for (int i=0;i<idsArr.length;i++) {
           User user =  userMapper.findUserById(idsArr[i]);
           if(user.getUserRoleId()==1){
               idsArr[i]=0;//保护超级管理员
               flag=false;
                break;
           }
        }
        int rows=userMapper.batchDeleteUserByIds(idsArr);
        if(flag&&rows==idsArr.length){
            return DataResult.ok("删除成功");
        }else if(!flag&&rows==idsArr.length-1){
            return DataResult.ok("删除成功，超级管理员已忽略");
        }
        return DataResult.err("删除失败");
    }

    @Override
    @Transactional
    public DataResult update(User user) {
       int row = userMapper.updateById(user);
       if(row>0){
           return DataResult.ok("修改成功");
       }
       return DataResult.err("修改失败");
    }

}
