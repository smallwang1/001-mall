package com.qf.mall.controller;

import com.qf.mall.common.CommonsTree;
import com.qf.mall.common.DataResult;
import com.qf.mall.common.DtreeMenuVO;
import com.qf.mall.common.InitHomeInfo;
import com.qf.mall.pojo.Menu;
import com.qf.mall.service.MenuService;
import javafx.scene.Parent;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.web.bind.annotation.RequestMapping;
import org.springframework.web.bind.annotation.RequestParam;
import org.springframework.web.bind.annotation.RestController;

import java.util.List;

@RestController
@RequestMapping("menu")
public class MenuController {
    @Autowired
    private MenuService menuService;

    @RequestMapping("home/init")
    public InitHomeInfo getMenuAll(){
        return menuService.getInitHome();
    }

    @RequestMapping("tree")
    public CommonsTree getMenuTree(){
        return menuService.getTreeFrame();
    }

    @RequestMapping("list")
    public DataResult getMenuListDtree(@RequestParam(defaultValue = "-1")int parentId){

        return menuService.getMenuDtreeByParentId(parentId);
    }

    @RequestMapping("add")
    public DataResult addMenu(Menu menu){
      return  menuService.addMenu(menu);
    }
}
