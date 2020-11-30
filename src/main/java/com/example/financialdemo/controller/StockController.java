package com.example.financialdemo.controller;

import com.baomidou.mybatisplus.core.metadata.IPage;
import com.baomidou.mybatisplus.extension.plugins.pagination.Page;
import com.example.financialdemo.domain.dto.DeleteIds;
import com.example.financialdemo.domain.dto.Fund;
import com.example.financialdemo.domain.dto.PageInput;
import com.example.financialdemo.domain.dto.Result;
import com.example.financialdemo.domain.entity.FundOption;
import com.example.financialdemo.domain.entity.FundRadical;
import com.example.financialdemo.domain.entity.FundSteady;
import com.example.financialdemo.domain.enums.Type;
import com.example.financialdemo.service.FundOptionService;
import com.example.financialdemo.service.FundRadicalService;
import com.example.financialdemo.service.FundSteadyService;
import io.swagger.annotations.Api;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.ui.Model;
import org.springframework.web.bind.annotation.*;

import java.util.ArrayList;
import java.util.Arrays;
import java.util.List;

/**
 * @Auther: jinhaihao
 * @Date: 2020/5/17 14:28
 */
@Controller
@RequestMapping("/stock")
@Api(value = "基金管理")
public class StockController {

    @Autowired
    private FundSteadyService fundSteadyService;
    @Autowired
    private FundRadicalService fundRadicalService;
    @Autowired
    private FundOptionService fundOptionService;

    @ApiOperation(value = "基金管理首页")
    @GetMapping("index")
    public String index() {
        return "stock/index";
    }

    @ApiOperation(value = "稳健型基金显示页面")
    @GetMapping("radical")
    public String radical() {
        return "fund/radical";
    }

    @ApiOperation(value = "激进型基金显示页面")
    @GetMapping("steady")
    public String steady() {
        return "fund/steady";
    }

    @ApiOperation(value = "自选基金池显示页面")
    @GetMapping("option")
    public String option() {
        return "fund/option";
    }

    @ApiOperation(value = "稳健型基金新增页面")
    @GetMapping("add")
    public String add(@RequestParam("addType")String addType, Model model) {
        model.addAttribute("addType",addType);
        return "fund/add";
    }

    @ApiOperation(value = "自选基金添加页面")
    @GetMapping("addFund")
    public String add(@RequestParam("fundCode")String fundCode, @RequestParam("addType")String type, Model model) {
        model.addAttribute("fundCode",fundCode);
        model.addAttribute("addType",type);
        return "fund/add";
    }

    @ApiOperation(value = "基金金额编辑页面")
    @GetMapping("edit")
    public String edit(@RequestParam("fundId")String fundId, Model model) {
        model.addAttribute("fundId",fundId);
        return "fund/edit";
    }

    @ApiOperation(value = "分页查询数据(可模糊查询)")
    @PostMapping("pageQuery")
    @ResponseBody
    public Result pageQuery(@RequestBody PageInput pageInput) {
        IPage pages = null;
        Result result = new Result();
        if(pageInput.getType().equals(Type.STEADY.code())) {
            Page<FundSteady> page = new Page<FundSteady>(pageInput.getPageNum(),pageInput.getPageSize());
            pages = fundSteadyService.pageQuery(page,pageInput.getQueryText());
        }
        if(pageInput.getType().equals(Type.RADICAL.code())) {
            Page<FundRadical> page = new Page<FundRadical>(pageInput.getPageNum(),pageInput.getPageSize());
            pages = fundRadicalService.pageQuery(page,pageInput.getQueryText());
        }
        if(pageInput.getType().equals(Type.OPTION.code())) {
            Page<FundOption> page = new Page<FundOption>(pageInput.getPageNum(),pageInput.getPageSize());
            pages = fundOptionService.pageQuery(page,pageInput.getQueryText());
        }

        if(pages!=null) {
            result.setSuccess(true);
            result.setData(pages);
        } else {
            result.setSuccess(false);
        }
        return result;
    }

    @ApiOperation(value = "删除基金数据（单个）")
    @GetMapping("delete")
    @ResponseBody
    public Result deleteUser(@RequestParam("id") Integer id,@RequestParam("type") String type) {
        Result result = new Result();
        int i = 0;
        if(type.equals(Type.STEADY.code())) {
            i = fundSteadyService.deleteFundById(id);
        }
        if(type.equals(Type.RADICAL.code())) {
            i = fundRadicalService.deleteFundById(id);
        }
        if(type.equals(Type.OPTION.code())) {
            i = fundOptionService.deleteFundById(id);
        }
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
    public Result deleteUsers(@RequestBody DeleteIds deleteIds) {
        Result result = new Result();
        String type = deleteIds.getType();
        List<Integer> ids = new ArrayList<>(Arrays.asList(deleteIds.getFundIds()));
        int i = 0;
        if(type.equals(Type.STEADY.code())) {
            i = fundSteadyService.deleteFundByIds(ids);
        }
        if(type.equals(Type.RADICAL.code())) {
            i = fundRadicalService.deleteFundByIds(ids);
        }
        if(type.equals(Type.OPTION.code())) {
            i = fundOptionService.deleteFundByIds(ids);
        }
        if(i > 0) {
            result.setSuccess(true);
        } else {
            result.setSuccess(false);
        }
        return result;
    }

    @ApiOperation(value = "增加基金数据")
    @PostMapping("insert")
    @ResponseBody
    public Result insert(@RequestBody Fund fund) {
        Result result = new Result();
        int i = 0;
        if(fund.getType().equals(Type.STEADY.code())) {
            i = fundSteadyService.insertFund(fund);
        }
        if(fund.getType().equals(Type.RADICAL.code())) {
            i = fundRadicalService.insertFund(fund);
        }
        if(fund.getType().equals(Type.OPTION.code())) {
            i = fundOptionService.insertFund(fund);
        }
        if(i > 0) {
            result.setSuccess(true);
        } else {
            result.setSuccess(false);
        }
        return result;
    }
}
