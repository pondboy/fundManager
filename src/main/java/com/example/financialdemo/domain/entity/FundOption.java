package com.example.financialdemo.domain.entity;

import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

/**
 * @Auther: jinhaihao
 * @Date: 2020/5/17 16:00
 */
@Data
@TableName("fund_option")
public class FundOption {

    private Integer id;
    private String fundCode;
    private String fundName;
    private String fundType;
    private String monthGrowth;
    private String threeMonthsGrowth;
    private String sixMonthsGrowth;
    private String yearGrowth;
    private String manager;
}
