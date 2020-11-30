package com.example.financialdemo.dao;

import com.baomidou.mybatisplus.core.mapper.BaseMapper;
import com.example.financialdemo.domain.entity.Resource;
import com.example.financialdemo.domain.entity.User;
import org.apache.ibatis.annotations.*;

import java.util.List;


/**
 * @Auther: jinhaihao
 * @Date: 2020/5/13 5:30
 */
@Mapper
public interface UserMapper extends BaseMapper<User> {

    @Select("select * from rbac_user where user_name = #{userName}")
    public User getUserByName(String userName);

    @Select("select ur.role_id from rbac_user u,rbac_user_role ur where u.id = ur.user_id and u.id = #{id}")
    public List<Integer> getRoleIdsByUserId(Integer id);

    @Insert("insert into rbac_user_role (user_id,role_id) values(#{userId},#{roleId})")
    public int insertUserRoles(@Param("userId") Integer userId,@Param("roleId") Integer roleId);

    @Delete("delete from rbac_user_role where user_id = #{userId} and role_id = #{roleId}")
    public int deleteUserRoles(@Param("userId") Integer userId,@Param("roleId") Integer roleId);

    @Select("select r.* from rbac_user u left join rbac_user_role ur on u.id = ur.user_id left join rbac_role_resource rr " +
            "on ur.role_id = rr.role_id left join rbac_resource r on rr.resource_id = r.id where u.user_name = #{userName}")
    public List<Resource> getResourcesByUser(String userName);
}
