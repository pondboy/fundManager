<%@page pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html lang="zh-CN">
  <head>
    <meta charset="UTF-8">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <meta name="viewport" content="width=device-width, initial-scale=1">
    <meta name="description" content="">
    <meta name="author" content="">

	<link rel="stylesheet" href="${APP_PATH}/bootstrap/css/bootstrap.min.css">
	<link rel="stylesheet" href="${APP_PATH}/css/font-awesome.min.css">
	<link rel="stylesheet" href="${APP_PATH}/css/main.css">
	<link rel="stylesheet" href="${APP_PATH}/css/doc.min.css">
	<style>
	.tree li {
        list-style-type: none;
		cursor:pointer;
	}
	</style>
  </head>

  <body>

  <nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
	  <div class="container-fluid">
		  <div class="navbar-header">
			  <div><a class="navbar-brand" style="font-size:32px;" href="#">资金管理平台</a></div>
		  </div>
		  <div id="navbar" class="navbar-collapse collapse">
			  <ul class="nav navbar-nav navbar-right">
				  <li style="padding-top:8px;">
					  <div class="btn-group">
						  <button type="button" class="btn btn-default btn-success dropdown-toggle" data-toggle="dropdown">
							  <i class="glyphicon glyphicon-user"></i> ${loginUser.userName} <span class="caret"></span>
						  </button>
						  <ul class="dropdown-menu" role="menu">
							  <li><a href="#"><i class="glyphicon glyphicon-cog"></i> 个人设置</a></li>
							  <li><a href="#"><i class="glyphicon glyphicon-comment"></i> 消息</a></li>
							  <li class="divider"></li>
							  <li><a href="${APP_PATH}/logout"><i class="glyphicon glyphicon-off"></i> 退出系统</a></li>
						  </ul>
					  </div>
				  </li>
				  <li style="margin-left:10px;padding-top:8px;">
					  <button type="button" class="btn btn-default btn-danger">
						  <span class="glyphicon glyphicon-question-sign"></span> 帮助
					  </button>
				  </li>
			  </ul>
			  <form class="navbar-form navbar-right">
				  <input type="text" class="form-control" placeholder="Search...">
			  </form>
		  </div>
	  </div>
  </nav>

  <div class="container-fluid">
	  <div class="row">
		  <div class="col-sm-3 col-md-2 sidebar">
			  <div class="tree">
				  <ul style="padding-left:0px;" class="list-group">
					  <li class="list-group-item tree-closed" >
						  <a href="${APP_PATH}/main"><i class="glyphicon glyphicon-dashboard"></i> 控制面板</a>
					  </li>
					  <li class="list-group-item tree-closed">
						  <span><i class="glyphicon glyphicon glyphicon-tasks"></i> 基金管理 <span class="badge" style="float:right">3</span></span>
						  <ul style="margin-top:10px;">
							  <li style="height:30px;">
								  <a href="${APP_PATH}/fund/steady"><i class="glyphicon glyphicon-align-left"></i> 稳健型基金配置 </a>
							  </li>
							  <li style="height:30px;">
								  <a href="${APP_PATH}/fund/radical"><i class="glyphicon glyphicon-align-right"></i> 激进型基金配置 </a>
							  </li>
							  <li style="height:30px;">
								  <a href="${APP_PATH}/fund/option"><i class="glyphicon glyphicon-align-center"></i> 自选基金池 </a>
							  </li>
						  </ul>
					  </li>
				  </ul>
			  </div>
		  </div>
        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
				<ol class="breadcrumb">
				  <li><a href="#">首页</a></li>
				  <li><a href="#">数据列表</a></li>
				  <li class="active">新增</li>
				</ol>
			<div class="panel panel-default">
              <div class="panel-heading">表单数据<div style="float:right;cursor:pointer;" data-toggle="modal" data-target="#myModal"><i class="glyphicon glyphicon-question-sign"></i></div></div>
			  <div class="panel-body">
				<form role="form">
				    <div class="form-group">
					    <label for="fundCode">基金代码</label>
					    <input type="text" class="form-control" id="fundCode" value="${fundCode}" placeholder="请输入基金代码">
				    </div>
					<div class="form-group">
						<label for="investment">投入基金额度</label>
						<input type="text" class="form-control" id="investment" placeholder="请输入基金金额">
					</div>
				  <button id="insertBtn" type="button" class="btn btn-success"><i class="glyphicon glyphicon-plus"></i> 新增</button>
				</form>
			  </div>
			</div>
        </div>
      </div>
    </div>

    <script src="${APP_PATH}/jquery/jquery-2.1.1.min.js"></script>
    <script src="${APP_PATH}/bootstrap/js/bootstrap.min.js"></script>
	<script src="${APP_PATH}/script/docs.min.js"></script>
	<script src="${APP_PATH}/layer/layer.js"></script>
        <script type="text/javascript">
            $(function () {
			    $(".list-group-item").click(function(){
				    if ( $(this).find("ul") ) {
						$(this).toggleClass("tree-closed");
						if ( $(this).hasClass("tree-closed") ) {
							$("ul", this).hide("fast");
						} else {
							$("ul", this).show("fast");
						}
					}
				});
			    
			    $("#insertBtn").click(function() {

			    	var fundCode = $("#fundCode").val();
			    	if ( fundCode == "" ) {
                        layer.msg("基金代码不能为空，请输入", {time:2000, icon:5, shift:6}, function(){
                        	
                        });
                        return;
			    	}

					var investment = $("#investment").val();
					if ( investment == "" ) {
						layer.msg("基金金额不能为空，请输入", {time:2000, icon:5, shift:6}, function(){

						});
						return;
					}

					var type  = "${addType}";
			    	
			    	var loadingIndex = null;
			    	$.ajax({
						type : "POST",
						datatype :"json",
						contentType:"application/json;charsetset=UTF-8",
						url  : "${APP_PATH}/fund/insert",
			    		data : JSON.stringify(
			    				{
									"fundCode" : fundCode,
									"investment" : investment,
									"type" : type
			    				}
						),
			    		beforeSend : function() {
			    			loadingIndex = layer.msg('处理中', {icon: 16});
			    		},
			    		success : function(result) {
			    			layer.close(loadingIndex);
			    			if ( result.success ) {
		                        layer.msg("基金信息添加成功", {time:1000, icon:6}, function(){
		                        	window.location.href = "${APP_PATH}/fund/"+type;
		                        });
			    			} else {
		                        layer.msg("基金信息添加失败，请确定输入的基金代码或基金名称正确，并重新操作", {time:2000, icon:5, shift:6}, function(){
		                        	
		                        });
			    			}
			    		}
			    	});
			    });
            });
        </script>
  </body>
</html>
