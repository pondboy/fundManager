package com.example.financialdemo.domain.dto;

import lombok.Data;

import javax.validation.constraints.NotNull;

/**
 * @Auther: jinhaihao
 * @Date: 2020/5/13 5:26
 */
@Data
public class RegUser {

    @NotNull
    private String userName;

    @NotNull
    private String userPassword;

    @NotNull
    private String email;
}
