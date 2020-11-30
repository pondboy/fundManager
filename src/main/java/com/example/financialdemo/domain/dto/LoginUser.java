package com.example.financialdemo.domain.dto;

import lombok.Data;

import javax.validation.constraints.NotNull;

/**
 * @Auther: jinhaihao
 * @Date: 2020/5/13 5:25
 */
@Data
public class LoginUser {

    @NotNull
    private String userName;

    @NotNull
    private String userPassword;
}
