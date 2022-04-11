package com.qf.mall.controller;

import com.qf.mall.mapper.RoleMapper;
import com.qf.mall.pojo.Role;
import com.qf.mall.service.RoleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("role")
public class RoleController {
    @Autowired
    RoleService roleService;
    @RequestMapping("roleAll")
    public List<Role> getAllRole(){
        return roleService.getRoleAll();
    }
}
