package com.example.financialdemo.service;


import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;

import com.example.financialdemo.domain.dto.RoleResources;
import com.example.financialdemo.domain.entity.Role;

import java.util.List;

/**
 * @Auther: jinhaihao
 * @Date: 2020/5/13 5:31
 */
public interface RoleService {

    public IPage<Role> selectAll(Page page, String queryText);

    public List<Role> selectRoles();

    public int insertRole(Role role);

    public int deleteUserById(Integer id);

    public int deleteUserByIds(List<Integer> ids);

    public int assignRoleResources(RoleResources roleResources);
}
