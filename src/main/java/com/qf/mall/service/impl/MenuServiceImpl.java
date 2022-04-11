package com.qf.mall.service.impl;

import com.qf.mall.common.CommonsTree;
import com.qf.mall.common.DataResult;
import com.qf.mall.common.DtreeMenuVO;
import com.qf.mall.common.InitHomeInfo;
import com.qf.mall.mapper.MenuMapper;
import com.qf.mall.pojo.Menu;
import com.qf.mall.pojo.User;
import com.qf.mall.service.MenuService;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import javax.xml.crypto.Data;
import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

@Service
public class MenuServiceImpl implements MenuService {
    @Autowired
    private MenuMapper menuMapper;
    @Override
    public List<Menu> getAllMenu(int parentId) {
      return   menuMapper.findMenuByParentId(parentId);
    }

    @Override
    public InitHomeInfo getInitHome() {
        List<Menu> menuTreeList = menuMapper.findMenuByParentId(0);

        InitHomeInfo initHomeInfo = new InitHomeInfo();
        initHomeInfo.setMenuInfo(menuTreeList);

        Map<String,String> homeInfo = new HashMap<>();
        homeInfo.put("title","首页");
        homeInfo.put("href","/page/welcome");
        initHomeInfo.setHomeInfo(homeInfo);

        Map<String,String> logoInfo = new HashMap<>();
        logoInfo.put( "title","xiaomi");
        logoInfo.put("image","images/logo.png");
        logoInfo.put("href","");
        initHomeInfo.setLogoInfo(logoInfo);

        return initHomeInfo;
    }

    @Override
    @Transactional(readOnly = true)
    public CommonsTree getTreeFrame() {
        CommonsTree tree=new CommonsTree();
        Map<String,Object> status=new HashMap<>();
        status.put("code",200);
        status.put("message","成功");
        tree.setStatus(status);
        //这个集合中最终存放的是一个tree，这个tree就是parentId=0的tree
        List<DtreeMenuVO> treeMenuList=new ArrayList<>();//最终要返回的数据，具有树格式
        List<Menu> menuList = menuMapper.findMenuAll();//查询所有的menu，并且没有树结构
        // 需要先将所有menu转化为树对象，放在一个新的树集合中，这个集合中的树是没有结构
        List<DtreeMenuVO> originalTreeNodeList=new ArrayList<>();
        for (Menu menu : menuList) {
            DtreeMenuVO vo=new DtreeMenuVO();
            vo.setId(menu.getMenuId()+"");
            vo.setTitle(menu.getTitle());
            vo.setParentId(menu.getParentId()+"");
            vo.setParentIs(menu.getParentIs());
            if (vo.getParentId().equals("0")){
                treeMenuList.add(vo); //找到跟节点放到返回的结果中
            }else{
                originalTreeNodeList.add(vo);//这个集合中存放的是parentid=0的孩子和孙子
            }

        }
        // 将originalTreeNodeList父节点和子节点找到，并且进行关系组装
        List<DtreeMenuVO> parentTreeNodeList=new ArrayList<>();
        for (DtreeMenuVO parentNode : originalTreeNodeList) {
            if (parentNode.getParentIs()||parentNode.getParentId().equals("1")){
                for (DtreeMenuVO childNode : originalTreeNodeList) {//寻找父节点的孩子
                    if (childNode.getParentId().equals(parentNode.getId())){
                        //如果childNode的parentId与某个parentNode的id相同，
                        // 说明是这个parentNode的一个子节点
                        parentNode.getChildren().add(childNode);
                    }
                }
                // 如果是父节点 parentNode中一定有孩子的，但是还有没有孩子的

                parentTreeNodeList.add(parentNode);//将所有的父节点放到一个集合中
            }
        }
        for (int i = 0; i < parentTreeNodeList.size(); i++) {
            for (int j = 0; j < parentTreeNodeList.size()-i-1; j++) {
                DtreeMenuVO vo1 = parentTreeNodeList.get(j);
                DtreeMenuVO vo2 = parentTreeNodeList.get(j+1);
                if (Integer.parseInt(vo1.getId())<Integer.parseInt(vo2.getId())){
                    String temp=vo1.getId();
                    parentTreeNodeList.set(j,vo2);
                    parentTreeNodeList.set(j+1,vo1);
                }
            }
        }
        //将集合添加到treeMenuList中的元素对象中
        treeMenuList.get(0).setChildren(parentTreeNodeList);
        tree.setData(treeMenuList);
        return tree;
    }

    @Override
    @Transactional(readOnly = true)
    public DataResult getMenuDtreeByParentId(int parentId) {
        List<Menu> menuDtreeByParentId = menuMapper.findMenuDtreeByParentId(parentId);
        return DataResult.returnData(0,menuDtreeByParentId);
    }

    @Override
    @Transactional
    public DataResult addMenu(Menu menu) {
        menu.setOpen(false);
        menu.setParentIs(false);

        Menu parentIs = menuMapper.findParentMenuByChildParentId(menu.getParentId());
        System.out.println(menu.toString());
        if (!parentIs.getParentIs()){
            menu.setParentIs(true);
            menuMapper.updataParentIs(menu);
        }
        int count = menuMapper.addMenu(menu);

        if (count>0){
            return DataResult.ok("菜单添加成功");
        }
        return DataResult.err("菜单添加失败");
    }

}
