package com.example.financialdemo.domain.entity;

import com.baomidou.mybatisplus.annotation.TableName;
import io.swagger.annotations.ApiModel;
import lombok.Data;


/**
 * @Auther: jinhaihao
 * @Date: 2020/5/27 21:55
 */
@Data
@TableName("rbac_resource")
@ApiModel(value = "资源表")
public class Resource {

    private Integer id;
    private Integer parentId;
    private Integer resourceType;
    private String resourceName;
    private String resourceUrl;
    private String resourceCode;
}
