package com.example.financialdemo.domain.dto;

import lombok.Data;

/**
 * @Auther: jinhaihao
 * @Date: 2020/5/20 17:41
 */
@Data
public class UserRoles {

    private Integer userId;
    private Integer[] roleIds;
}
