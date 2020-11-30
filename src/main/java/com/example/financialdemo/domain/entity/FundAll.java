package com.example.financialdemo.domain.entity;

import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

/**
 * @Auther: jinhaihao
 * @Date: 2020/5/17 16:00
 */
@Data
@TableName("fund_all")
public class FundAll {

    private Integer id;
    private String all;
}
