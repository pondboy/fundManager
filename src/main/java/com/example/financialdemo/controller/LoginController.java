package com.example.financialdemo.controller;

import com.example.financialdemo.domain.dto.LoginUser;
import com.example.financialdemo.domain.dto.RegUser;
import com.example.financialdemo.domain.dto.Result;
import com.example.financialdemo.domain.dto.TreeNode;
import com.example.financialdemo.domain.entity.Resource;
import com.example.financialdemo.service.UserService;
import io.swagger.annotations.ApiOperation;
import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.stereotype.Controller;
import org.springframework.web.bind.annotation.*;
import javax.servlet.http.HttpSession;
import java.util.List;


/**
 * @Auther: jinhaihao
 * @Date: 2020/5/19 10:26
 */
@Controller
public class LoginController {

    @Autowired
    private UserService userService;

    @ApiOperation(value = "后台首页")
    @RequestMapping("main")
    public String index() {
        return "main";
    }

    @ApiOperation(value = "访问注册页面")
    @GetMapping("reg")
    public String reg() {
        return "reg";
    }

    @ApiOperation(value = "访问登录页面")
    @GetMapping("login")
    public String login() {
        return "login";
    }

    @ApiOperation(value = "注册用户")
    @PostMapping("doReg")
    @ResponseBody
    public Result doReg(@RequestBody RegUser user) {
        int i = userService.regUser(user);
        Result result = new Result();
        if(i>0) {
            result.setSuccess(true);
        } else {
            result.setSuccess(false);
        }
        return result;
    }

    @ApiOperation(value = "用户登录")
    @PostMapping("doLogin")
    @ResponseBody
    public Result doLogin(@RequestBody LoginUser user, HttpSession session) {
        int i = userService.loginUser(user);

        Result result = new Result();
        if(i==1) {
            session.setAttribute("loginUser",user);
            TreeNode root = userService.getResourcesByUser(user.getUserName());
            session.setAttribute("root",root);
            result.setSuccess(true);
        } else {
            result.setSuccess(false);
        }
        return result;
    }


    @ApiOperation(value = "退出登录")
    @GetMapping("logout")
    public String logout(HttpSession session) {
        session.invalidate();
        return "redirect:login";
    }
}
