package com.qf.mall.common;

import lombok.Data;

import java.util.ArrayList;
import java.util.List;
@Data
public class DtreeMenuVO {
    private String id;
    private String title;
    private String parentId;
    private Boolean parentIs;
    private String checkArr = "0";
    //将这个孩子实例化，方便操作，防止报空指针
    private List<DtreeMenuVO> children = new ArrayList<>();
}
