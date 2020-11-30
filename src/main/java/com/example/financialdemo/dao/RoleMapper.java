package com.example.financialdemo.dao;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.example.financialdemo.domain.entity.Role;
import org.apache.ibatis.annotations.*;
import java.util.List;


/**
 * @Auther: jinhaihao
 * @Date: 2020/5/13 5:30
 */
@Mapper
public interface RoleMapper extends BaseMapper<Role> {

    @Insert("insert into rbac_role_resource (role_id,resource_id) values(#{roleId},#{resourceId})")
    public int assignRoleResources(@Param("roleId")Integer roleId,@Param("resourceId")Integer resourceId);

    @Delete("delete from rbac_role_resource where role_id = #{roleId}")
    public int deleteRoleResources(@Param("roleId") Integer roleId);

}
