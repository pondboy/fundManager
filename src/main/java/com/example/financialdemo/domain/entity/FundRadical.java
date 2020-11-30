package com.example.financialdemo.domain.entity;

import com.baomidou.mybatisplus.annotation.TableName;
import lombok.Data;

/**
 * @Auther: jinhaihao
 * @Date: 2020/5/17 16:00
 */
@Data
@TableName("fund_radical")
public class FundRadical {

    private Integer id;
    private String fundCode;
    private String fundName;
    private String fundType;
    private String netWorth;
    private String expectGrowth;
    private String dayGrowth;
    private String monthGrowth;
    private String threeMonthsGrowth;
    private String sixMonthsGrowth;
    private String yearGrowth;
    private String manager;
    private String investment;
    private String investmentRation;
}
