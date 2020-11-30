package com.example.financialdemo.controller;

import com.baomidou.mybatisplus.extension.api.R;
import com.example.financialdemo.domain.dto.Result;
import com.example.financialdemo.domain.dto.TreeNode;
import com.example.financialdemo.domain.entity.Resource;
import com.example.financialdemo.domain.enums.ResourceType;
import com.example.financialdemo.service.ResourceService;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.HashMap;
import java.util.List;
import java.util.Map;


/**
 * @Auther: jinhaihao
 * @Date: 2020/5/14 20:46
 */
@Controller
@RequestMapping("/resource")
public class ResourceController {

    @Autowired
    private ResourceService resourceService;

    @ApiOperation(value = "资源维护首页")
    @GetMapping("index")
    public String index() {
        return "resource/index";
    }

    @ApiOperation(value = "资源增加页面")
    @GetMapping("add")
    public String add(@RequestParam("id")Integer id, Model model) {
        model.addAttribute("parentId",id);
        return "resource/add";
    }

    @ApiOperation(value = "资源增加页面")
    @GetMapping("edit")
    public String edit(@RequestParam("id")Integer id, Model model) {
        Resource resource = resourceService.getResourceById(id);
        model.addAttribute("resource",resource);
        return "resource/edit";
    }

    @ApiOperation(value = "基于角色获取已添加资源数据")
    @GetMapping("loadAssignResources")
    @ResponseBody
    public Object loadAssignResources(@RequestParam("roleId")Integer roleId) {
        return resourceService.loadAssignResources(roleId);
    }

    @ApiOperation(value = "获取全部资源数据")
    @PostMapping("loadResources")
    @ResponseBody
    public Object loadResources() {
        return resourceService.loadResources();
    }

    @ApiOperation(value = "添加资源数据")
    @PostMapping("insert")
    @ResponseBody
    public Result insert(@RequestBody Resource resource) {
        int i = resourceService.insertResource(resource);
        Result result = new Result();
        if(i>0) {
            result.setSuccess(true);
        } else {
            result.setSuccess(false);
        }

        return result;
    }

    @ApiOperation(value = "更新资源数据")
    @PostMapping("update")
    @ResponseBody
    public Result update(@RequestBody Resource resource) {
        int i = resourceService.updateResource(resource);
        Result result = new Result();
        if(i>0) {
            result.setSuccess(true);
        } else {
            result.setSuccess(false);
        }

        return result;
    }

    @ApiOperation(value = "删除资源数据")
    @GetMapping("delete")
    @ResponseBody
    public Result delete(@RequestParam("id") Integer id) {
        int i = resourceService.deleteResource(id);
        Result result = new Result();
        if(i>0) {
            result.setSuccess(true);
        } else {
            result.setSuccess(false);
        }
        return result;
    }

}
