package com.example.financialdemo.domain.entity;

import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.util.Date;

/**
 * @Auther: jinhaihao
 * @Date: 2020/5/16 13:10
 */
@TableName("rbac_role")
@Data
public class Role {

    private Integer id;
    private String roleName;
    private Date createTime;
}
