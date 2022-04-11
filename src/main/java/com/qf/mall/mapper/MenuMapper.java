package com.qf.mall.mapper;

import com.qf.mall.common.DataResult;
import com.qf.mall.pojo.Menu;
import org.apache.ibatis.annotations.Param;

import java.util.List;

public interface MenuMapper {
    //通过父节点ID查询出当前所有子节点
    List<Menu> findMenuByParentId(int parentId);
    List<Menu> findMenuAll();

    List<Menu> findMenuDtreeByParentId(@Param("parentId") int parentId);

    int addMenu(Menu menu);

    Menu findParentMenuByChildParentId(Integer parentId);

    int updataParentIs(Menu menu);

}
