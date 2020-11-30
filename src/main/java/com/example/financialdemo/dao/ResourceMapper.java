package com.example.financialdemo.dao;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.example.financialdemo.domain.entity.Resource;
import org.apache.ibatis.annotations.Mapper;
import org.apache.ibatis.annotations.Param;
import org.apache.ibatis.annotations.Select;

import java.util.List;

/**
 * @Auther: jinhaihao
 * @Date: 2020/5/27 22:00
 */
@Mapper
public interface ResourceMapper extends BaseMapper<Resource> {

    @Select("select resource_id from rbac_role_resource where role_id = #{roleId}")
    public List<Integer> getRoleResources(@Param("roleId") Integer roleId);
}
