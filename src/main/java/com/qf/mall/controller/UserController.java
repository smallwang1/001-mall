package com.qf.mall.controller;

import com.alibaba.druid.util.StringUtils;
import com.qf.mall.common.DataResult;
import com.qf.mall.common.UserSerchVo;
import com.qf.mall.pojo.User;


import com.qf.mall.service.UserService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.PostMapping;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import javax.servlet.http.HttpSession;
import java.io.UnsupportedEncodingException;


@RestController
@RequestMapping("user")
public class UserController {
    @Autowired
    private UserService userService;
    @PostMapping("login")
    public DataResult login(String username, String password, String captcha, HttpSession session){
        //获取之前存在session里面的验证码
        String code = session.getAttribute("code").toString();

        if (!code.equalsIgnoreCase(captcha)){
            return DataResult.err("验证码错误！");

        }
        DataResult result = userService.getUserByNamePsw(username, password);
        Object data = result.getData();
        if(data!=null){
            session.setAttribute("data",data);
        }
        return result;
    }

    @RequestMapping("list")
    public DataResult getAllUser(UserSerchVo userSerchVo) throws UnsupportedEncodingException {
        if (!StringUtils.isEmpty(userSerchVo.getUsername())){
            userSerchVo.setUsername(new String(userSerchVo.getUsername().getBytes("ISO-8859-1"),"UTF-8"));
        }
        if (!StringUtils.isEmpty(userSerchVo.getUserSex())){
            userSerchVo.setUserSex(new String(userSerchVo.getUserSex().getBytes("ISO-8859-1"),"UTF-8"));
        }
        if (!StringUtils.isEmpty(userSerchVo.getRoleName())){
            System.out.println(userSerchVo.getRoleName());
            userSerchVo.setRoleName(new String(userSerchVo.getRoleName().getBytes("ISO-8859-1"),"UTF-8"));
        }
        if (!StringUtils.isEmpty(userSerchVo.getPhone())){
            userSerchVo.setPhone(new String(userSerchVo.getPhone().getBytes("ISO-8859-1"),"UTF-8"));
        }
        return userService.getUserAllByLimit(userSerchVo);
    }

    @RequestMapping("add")
    public DataResult addUser(User user){
        user.setPassword("123456");
        if(StringUtils.isEmpty(user.getHead())){
            user.setHead("default.jpg");
        }
        return userService.addUser(user);
    }

    @PostMapping("batchDelete")
    public DataResult batchDelete(String ids){
        String[] arr = ids.split(",");
        int[] idsArr = new int[arr.length];
        for (int i = 0; i < arr.length; i++) {
            idsArr[i]=Integer.parseInt((arr[i].trim()));
        }
        return userService.batchDeleteUser(idsArr);
    }

    @PostMapping("update")
    public DataResult update(User user){

        return userService.update(user);
    }


}
