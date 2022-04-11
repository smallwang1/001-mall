package com.qf.mall.service.impl;

import com.qf.mall.mapper.RoleMapper;
import com.qf.mall.pojo.Role;
import com.qf.mall.service.RoleService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.List;
@Service
public class RoleServiceImpl implements RoleService {
    @Autowired
    private RoleMapper roleMapper;
    @Override
    @Transactional(readOnly = true)
    public List<Role> getRoleAll() {
        return roleMapper.getRoleAll();
    }
}
