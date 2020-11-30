package com.example.financialdemo.service;


import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.example.financialdemo.domain.dto.LoginUser;
import com.example.financialdemo.domain.dto.RegUser;
import com.example.financialdemo.domain.dto.TreeNode;
import com.example.financialdemo.domain.dto.UserRoles;
import com.example.financialdemo.domain.entity.Resource;
import com.example.financialdemo.domain.entity.User;

import java.util.List;

/**
 * @Auther: jinhaihao
 * @Date: 2020/5/13 5:31
 */
public interface UserService {

    public Boolean isExist(String userName);

    public IPage<User> selectAll(Page page, String queryText);

    public int insertUser(User user);

    public User getUserById(Integer id);

    public int updateUser(User user);

    public int deleteUserById(Integer id);

    public int deleteUserByIds(List<Integer> ids);

    public int regUser(RegUser regUser);

    public int loginUser(LoginUser loginUser);

    public List<Integer> getRoleIdsByUserId(Integer id);

    public int insertUserRoles(UserRoles userRoles);

    public int deleteUserRoles(UserRoles userRoles);

    public TreeNode getResourcesByUser(String userName);
}
