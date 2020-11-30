package com.example.financialdemo.controller;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.example.financialdemo.domain.dto.*;
import com.example.financialdemo.domain.entity.Role;
import com.example.financialdemo.domain.entity.User;
import com.example.financialdemo.service.RoleService;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;


/**
 * @Auther: jinhaihao
 * @Date: 2020/5/14 20:46
 */
@Controller
@RequestMapping("/role")
public class RoleController {

    @Autowired
    private RoleService roleService;

    @ApiOperation(value = "角色维护首页")
    @GetMapping("index")
    public String index() {
        return "role/index";
    }

    @ApiOperation(value = "添加角色页面")
    @GetMapping("add")
    public String add() {
        return "role/add";
    }

    @ApiOperation(value = "添加角色资源页面")
    @GetMapping("assign")
    public String assign() {
        return "role/assign";
    }


    @ApiOperation(value = "分页查询数据(可模糊查询)")
    @PostMapping("pageQuery")
    @ResponseBody
    public Result pageQuery(@RequestBody PageInput pageInput) {
        Page<Role> page = new Page<>(pageInput.getPageNum(),pageInput.getPageSize());
        Result result = new Result();
        IPage<Role> pages = roleService.selectAll(page,pageInput.getQueryText());
        if(pages!=null) {
            result.setSuccess(true);
            result.setData(pages);
        } else {
            result.setSuccess(false);
        }
        return result;
    }

    @ApiOperation(value = "插入角色数据")
    @PostMapping("insert")
    @ResponseBody
    public Result insertUser(@RequestBody Role role) {
        Result result = new Result();
        int i = roleService.insertRole(role);
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
        int i = roleService.deleteUserById(id);
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
    public Result deleteUsers(@RequestBody Roles roles) {
        Result result = new Result();
        List<Integer> ids = new ArrayList<>(Arrays.asList(roles.getRoleIds()));
        int i = roleService.deleteUserByIds(ids);
        if(i > 0) {
            result.setSuccess(true);
        } else {
            result.setSuccess(false);
        }
        return result;
    }

    @ApiOperation(value = "删除用户数据（批量）")
    @PostMapping("assign")
    @ResponseBody
    public Result assignResourceByRole(@RequestBody RoleResources roleResources) {
        Result result = new Result();
        int i = roleService.assignRoleResources(roleResources);
        if(i > 0) {
            result.setSuccess(true);
        } else {
            result.setSuccess(false);
        }
        return result;
    }

}
