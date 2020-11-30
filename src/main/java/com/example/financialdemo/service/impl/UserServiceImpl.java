package com.example.financialdemo.service.impl;

import com.baomidou.mybatisplus.core.conditions.query.QueryWrapper;
import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.example.financialdemo.dao.ResourceMapper;
import com.example.financialdemo.dao.UserMapper;
import com.example.financialdemo.domain.dto.*;
import com.example.financialdemo.domain.entity.Resource;
import com.example.financialdemo.domain.entity.User;
import com.example.financialdemo.domain.enums.ResourceType;
import com.example.financialdemo.service.UserService;
import lombok.extern.slf4j.Slf4j;
import org.springframework.beans.BeanUtils;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Service;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;

/**
 * @Auther: jinhaihao
 * @Date: 2020/5/14 11:01
 */
@Slf4j
@Service
public class UserServiceImpl implements UserService {

    @Autowired
    private UserMapper userMapper;
    @Autowired
    private ResourceMapper resourceMapper;

    @Override
    public Boolean isExist(String userName) {
        User user = userMapper.getUserByName(userName);
        return (user==null)?false:true;
    }

    @Override
    public IPage<User> selectAll(Page page, String queryText) {
        if(queryText==null) {
            return userMapper.selectPage(page, new QueryWrapper<User>().lambda().orderByDesc(User::getCreateTime));
        } else {
            return userMapper.selectPage(page, new QueryWrapper<User>().lambda().like(User::getUserName,queryText).orderByDesc(User::getCreateTime));
        }
    }

    @Override
    public int insertUser(User user) {
        //TODO 设置默认的用户密码初始密码
        user.setUserPassword("123456");
        return userMapper.insert(user);
    }

    @Override
    public User getUserById(Integer id) {
        return userMapper.selectOne(new QueryWrapper<User>().lambda().eq(User::getId, id));
    }

    @Override
    public int updateUser(User user) {
        return userMapper.update(user,new QueryWrapper<User>().lambda().eq(User::getId,user.getId()));
    }

    @Override
    public int deleteUserById(Integer id) {
        return userMapper.deleteById(id);
    }

    @Override
    public int deleteUserByIds(List<Integer> ids) {
        return userMapper.deleteBatchIds(ids);
    }

    @Override
    public int regUser(RegUser regUser) {
        String userName = regUser.getUserName();
        Boolean isExist = isExist(userName);
        if(!isExist) {
            User user = new User();
            BeanUtils.copyProperties(regUser,user);
            user.setLoginName(regUser.getUserName());
            return userMapper.insert(user);
        } else {
            return 0;
        }
    }

    @Override
    public int loginUser(LoginUser loginUser) {
        String userName = loginUser.getUserName();
        User user = userMapper.getUserByName(userName);
        if(user==null) {
            return 0;
        } else {
            if(user.getUserPassword().equals(loginUser.getUserPassword())) {
                return 1;
            }
        }
        return 0;
    }

    @Override
    public List<Integer> getRoleIdsByUserId(Integer id) {
        return userMapper.getRoleIdsByUserId(id);
    }

    @Override
    public int insertUserRoles(UserRoles userRoles) {
        Integer userId = userRoles.getUserId();
        Integer[] roleIds = userRoles.getRoleIds();
        for(Integer roleId : roleIds) {
            if(!userMapper.getRoleIdsByUserId(userId).contains(roleId)) {
                userMapper.insertUserRoles(userId, roleId);
            }
        }

        return 1;
    }

    @Override
    public int deleteUserRoles(UserRoles userRoles) {
        Integer userId = userRoles.getUserId();
        Integer[] roleIds = userRoles.getRoleIds();
        for(Integer roleId : roleIds) {
            userMapper.deleteUserRoles(userId, roleId);
        }

        return 1;
    }

    @Override
    public TreeNode getResourcesByUser(String userName) {
        TreeNode root = null;
        List<Resource> resources = null;
        if(userName.equals("admin")) {
            resources = resourceMapper.selectList(new QueryWrapper<Resource>());
        } else {
            resources = userMapper.getResourcesByUser(userName);
        }

        if(resources==null || resources.isEmpty()) {
            return null;
        }
        Map<Integer,TreeNode> map = new HashMap<>();
        for(Resource resource : resources) {
            TreeNode node = new TreeNode();
            node.setId(resource.getId());
            node.setPId(resource.getParentId());
            node.setName(resource.getResourceName());
            node.setUrl(resource.getResourceUrl());
            node.setIcon(ResourceType.getEnumByCode(resource.getResourceType()).value());
            node.setChildren(new ArrayList<>());
            map.put(resource.getId(),node);
        }


        for(Resource resource : resources) {
            if(resource.getParentId()==0) {
                root = map.get(resource.getId());
            } else {
                map.get(resource.getParentId()).getChildren().add(map.get(resource.getId()));
            }
        }
        return root;
    }
}
