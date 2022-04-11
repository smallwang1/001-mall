package com.qf.mall.pojo;

import lombok.Data;

import java.util.List;
import java.util.Set;

@Data
public class Menu {
   private Integer menuId;
   private String title;
   private String icon;
   private String href;
   private String target;
   private Boolean parentIs;
   private Integer parentId;
   private Boolean open;
   //当前菜单如果是父节点那么就会有子节点
   private List<Menu> child;
}
