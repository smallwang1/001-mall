package com.qf.mall.service;

import com.qf.mall.common.CommonsTree;
import com.qf.mall.common.DataResult;
import com.qf.mall.common.InitHomeInfo;
import com.qf.mall.pojo.Menu;
import com.qf.mall.pojo.User;

import java.util.List;

public interface MenuService {
    List<Menu> getAllMenu(int parentId);

    InitHomeInfo getInitHome();

    CommonsTree getTreeFrame();

    DataResult getMenuDtreeByParentId(int parentId);

    DataResult addMenu(Menu menu);
}
