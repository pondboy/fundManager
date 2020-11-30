package com.example.financialdemo.controller;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.example.financialdemo.domain.dto.PageInput;
import com.example.financialdemo.domain.dto.Result;
import com.example.financialdemo.domain.dto.UserRoles;
import com.example.financialdemo.domain.dto.Users;
import com.example.financialdemo.domain.entity.Role;
import com.example.financialdemo.domain.entity.User;
import com.example.financialdemo.service.RoleService;
import com.example.financialdemo.service.UserService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;
import java.util.stream.Collectors;

/**
 * @Auther: jinhaihao
 * @Date: 2020/5/20 10:55
 */
@Controller
@RequestMapping("user")
@Api(value = "用户管理")
public class UserController {

    @Autowired
    private UserService userService;
    @Autowired
    private RoleService roleService;

    @ApiOperation(value = "用户维护首页")
    @GetMapping("index")
    public String index() {
        return "user/index";
    }

    @ApiOperation(value = "添加用户页面")
    @GetMapping("add")
    public String add() {
        return "user/add";
    }

    @ApiOperation(value = "编辑用户页面")
    @GetMapping("edit")
    public String edit(@RequestParam("id") Integer id, Model model) {
        User user = userService.getUserById(id);
        model.addAttribute("user",user);
        return "user/edit";
    }

    @ApiOperation(value = "为用户分配角色页面")
    @GetMapping("assign")
    public String assign(@RequestParam("id") Integer id, Model model) {
        //查询所有角色
        List<Role> roles = roleService.selectRoles();
        //获取当前用户及已关联的角色
        List<Integer> ids = userService.getRoleIdsByUserId(id);
        User user = userService.getUserById(id);

        //已关联角色
        List<Role> assingedRoles = new ArrayList<>();
        //未关联角色
        List<Role> unassignRoles = new ArrayList<>();
        for(Role role : roles) {
            if(ids.contains(role.getId())) {
                assingedRoles.add(role);
            } else {
                unassignRoles.add(role);
            }
        }
        model.addAttribute("user",user);
        model.addAttribute("assingedRoles",assingedRoles);
        model.addAttribute("unassignRoles",unassignRoles);
        return "user/assign";
    }


    @ApiOperation(value = "分页查询数据(可模糊查询)")
    @PostMapping("pageQuery")
    @ResponseBody
    public Result pageQuery(@RequestBody PageInput pageInput) {
        Page<User> page = new Page<User>(pageInput.getPageNum(),pageInput.getPageSize());
        Result result = new Result();
        IPage<User> pages = userService.selectAll(page,pageInput.getQueryText());
        if(pages!=null) {
            result.setSuccess(true);
            result.setData(pages);
        } else {
            result.setSuccess(false);
        }
        return result;
    }

    @ApiOperation(value = "插入用户数据")
    @PostMapping("insert")
    @ResponseBody
    public Result insertUser(@RequestBody User user) {
        Result result = new Result();
        int i = userService.insertUser(user);
        if(i > 0) {
            result.setSuccess(true);
        } else {
            result.setSuccess(false);
        }
        return result;
    }

    @ApiOperation(value = "更新用户数据")
    @PostMapping("update")
    @ResponseBody
    public Result updateUser(@RequestBody User user) {
        Result result = new Result();
        int i = userService.updateUser(user);
        if(i > 0) {
            result.setSuccess(true);
        } else {
            result.setSuccess(false);
        }
        return result;
    }

    @ApiOperation(value = "删除用户数据（单个）")
    @GetMapping("delete")
    @ResponseBody
    public Result deleteUser(@RequestParam("id") Integer id) {
        Result result = new Result();
        int i = userService.deleteUserById(id);
        if(i > 0) {
            result.setSuccess(true);
        } else {
            result.setSuccess(false);
        }
        return result;
    }

    @ApiOperation(value = "删除用户数据（批量）")
    @PostMapping("deletes")
    @ResponseBody
    public Result deleteUsers(@RequestBody Users users) {
        Result result = new Result();
        List<Integer> ids = new ArrayList<>(Arrays.asList(users.getUserIds()));
        int i = userService.deleteUserByIds(ids);
        if(i > 0) {
            result.setSuccess(true);
        } else {
            result.setSuccess(false);
        }
        return result;
    }

    @ApiOperation(value = "给用户添加角色")
    @PostMapping("doAssign")
    @ResponseBody
    public Result doAssign(@RequestBody UserRoles userRoles) {
        Result result = new Result();

        int i = userService.insertUserRoles(userRoles);
        if(i > 0) {
            result.setSuccess(true);
        } else {
            result.setSuccess(false);
        }
        return result;
    }

    @ApiOperation(value = "给用户删除角色")
    @PostMapping("doCancel")
    @ResponseBody
    public Result doCancel(@RequestBody UserRoles userRoles) {
        Result result = new Result();

        int i = userService.deleteUserRoles(userRoles);
        if(i > 0) {
            result.setSuccess(true);
        } else {
            result.setSuccess(false);
        }
        return result;
    }


}
