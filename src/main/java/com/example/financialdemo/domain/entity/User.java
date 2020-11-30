package com.example.financialdemo.domain.entity;

import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

import java.util.Date;

/**
 * @Auther: jinhaihao
 * @Date: 2020/5/13 5:29
 */
@TableName("rbac_user")
@Data
public class User {

    private Integer id;
    private String userName;
    private String loginName;
    private String userPassword;
    private String email;
    private Date createTime;
}
