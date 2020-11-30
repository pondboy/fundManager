package com.example.financialdemo.domain.dto;

import io.swagger.annotations.ApiModelProperty;
import lombok.Data;

/**
 * @Auther: jinhaihao
 * @Date: 2020/5/15 18:44
 */
@Data
public class PageInput {

    @ApiModelProperty(value = "页码")
    private Integer pageNum;

    @ApiModelProperty(value = "页面大小")
    private Integer pageSize;

    @ApiModelProperty(value = "模糊查询条件内容")
    private String queryText;

    @ApiModelProperty(value = "自定义基金类型")
    private String type;
}
