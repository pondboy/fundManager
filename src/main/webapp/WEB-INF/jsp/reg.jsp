<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<!DOCTYPE html>
<html lang="zh-CN">
<head>
    <meta charset="GB18030">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="keys" content="">
    <meta name="author" content="">
    <link rel="stylesheet" href="${APP_PATH}/bootstrap/css/bootstrap.min.css">
    <link rel="stylesheet" href="${APP_PATH}/css/font-awesome.min.css">
    <link rel="stylesheet" href="${APP_PATH}/css/login.css">
    <style>

    </style>
</head>
<body>
<nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
    <div class="container">
        <div class="navbar-header">
            <div><a class="navbar-brand" href="index.html" style="font-size:32px;">RBAC权限体验平台</a></div>
        </div>
    </div>
</nav>

    <div class="container">
        <form id="regForm" action="doReg" method="post" class="form-signin" role="form">
            <h2 class="form-signin-heading"><i class="glyphicon glyphicon-log-in"></i> 用户注册</h2>
            <div class="form-group has-success has-feedback">
                <input type="text" class="form-control" id="userName" name="userName" placeholder="请输入登录账号" autofocus>
                <span class="glyphicon glyphicon-user form-control-feedback"></span>
            </div>
            <div class="form-group has-success has-feedback">
                <input type="password" class="form-control" id="userPassword" name="userPassword" placeholder="请输入登录密码" style="margin-top:10px;">
                <span class="glyphicon glyphicon-lock form-control-feedback"></span>
            </div>
            <div class="form-group has-success has-feedback">
                <input type="text" class="form-control" id="email" name="email" placeholder="请输入邮箱地址" style="margin-top:10px;">
                <span class="glyphicon glyphicon glyphicon-envelope form-control-feedback"></span>
            </div>
            <div class="form-group has-success has-feedback">
                <select class="form-control" >
                    <option>会员</option>
                    <option>管理</option>
                </select>
            </div>
            <a class="btn btn-lg btn-success btn-block" onclick="doReg()" > 注册</a>
        </form>
    </div>
    <script src="${APP_PATH}/jquery/jquery-2.1.1.min.js"></script>
    <script src="${APP_PATH}/bootstrap/js/bootstrap.min.js"></script>
    <script src="${APP_PATH}/layer/layer.js"></script>
    <script>
        function doReg() {

            // 非空校验
            var userName = $("#userName").val();
            // 表单元素的value取值不会为null, 取值是空字符串
            if ( userName == "" ) {
                //alert("用户登录账号不能为空，请输入");
                layer.msg("用户登录账号不能为空，请输入", {time:2000, icon:5, shift:6}, function(){

                });
                return;
            }

            var userPassword = $("#userPassword").val();
            if ( userPassword == "" ) {
                //alert("用户登录密码不能为空，请输入");
                layer.msg("用户登录密码不能为空，请输入", {time:2000, icon:5, shift:6}, function(){

                });
                return;
            }

            var email = $("#email").val();
            if ( email == "" ) {
                //alert("用户登录密码不能为空，请输入");
                layer.msg("注册邮箱不能为空，请输入", {time:2000, icon:5, shift:6}, function(){

                });
                return;
            }

            var regData = $("#regForm").serializeArray();
            var regParam = {};

            for(var i =0;i<regData.length;i++)
            {
                regParam[regData[i].name] = regData[i]['value'];
            }

            // 提交表单
            //alert("提交表单");
            //$("#loginForm").submit();
            // 使用AJAX提交数据
            var loadingIndex = null;
            $.ajax({
                type : "POST",
                url  : "doReg",
                datatype :"json",
                contentType:"application/json;charsetset=UTF-8",
                data : JSON.stringify(regParam),
                beforeSend : function(){
                    loadingIndex = layer.msg('处理中', {icon: 16});
                },
                success : function(result) {
                    layer.close(loadingIndex);
                    if (result.success) {
                        layer.msg("用户注册成功，请登录", {time:1000, icon:6, shift:5}, function(){
                            window.location.href = "${APP_PATH}/login";
                        });

                    } else {
                        layer.msg("用户名已存在，请重新输入", {time:2000, icon:5, shift:6}, function(){

                        });
                    }
                }
            });
        }
    </script>
</body>
</html>