package com.example.financialdemo.domain.dto;

import lombok.Data;

import java.util.List;

/**
 * @Auther: jinhaihao
 * @Date: 2020/5/27 22:33
 */
@Data
public class TreeNode {

    private Integer id;
    private Integer pId;
    private String name;
    private String url;
    private Boolean open;
    private Boolean checked = false;
    //基于资源类型分配图标 0-菜单 1-按钮
    private String icon;
    private List<TreeNode> children;
}
