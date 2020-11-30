package com.example.financialdemo.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.example.financialdemo.dao.RoleMapper;
import com.example.financialdemo.domain.dto.RoleResources;
import com.example.financialdemo.domain.entity.Role;
import com.example.financialdemo.service.RoleService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;
import org.springframework.transaction.annotation.Transactional;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;


/**
 * @Auther: jinhaihao
 * @Date: 2020/5/14 11:01
 */
@Slf4j
@Service
public class RoleServiceImpl implements RoleService {

    @Autowired
    private RoleMapper roleMapper;

    @Override
    public IPage<Role> selectAll(Page page, String queryText) {
        if(queryText==null) {
            return roleMapper.selectPage(page,new QueryWrapper<Role>().lambda().orderByDesc(Role::getCreateTime));
        } else {
            return roleMapper.selectPage(page,new QueryWrapper<Role>().lambda().orderByDesc(Role::getCreateTime)
                    .like(Role::getRoleName,queryText));
        }
    }

    @Override
    public List<Role> selectRoles() {
        return roleMapper.selectList(new QueryWrapper<Role>());
    }

    @Override
    public int insertRole(Role role) {
        return roleMapper.insert(role);
    }

    @Override
    public int deleteUserById(Integer id) {
        return roleMapper.delete(new QueryWrapper<Role>().lambda().eq(Role::getId,id));
    }

    @Override
    public int deleteUserByIds(List<Integer> ids) {
        return roleMapper.deleteBatchIds(ids);
    }

    @Override
    @Transactional
    public int assignRoleResources(RoleResources roleResources) {
        Integer roleId = roleResources.getRoleId();
        Integer[] resourceIds = roleResources.getResourceIds();
        roleMapper.deleteRoleResources(roleId);
        for(Integer resourceId : resourceIds) {
            roleMapper.assignRoleResources(roleId,resourceId);
        }

        return 1;
    }
}
