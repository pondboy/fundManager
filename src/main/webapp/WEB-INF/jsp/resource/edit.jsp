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
            <div><a class="navbar-brand" style="font-size:32px;" href="#">RBAC平台 - 用户维护</a></div>
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
							<span><i class="glyphicon glyphicon glyphicon-tasks"></i> 权限管理 <span class="badge" style="float:right">3</span></span>
							<ul style="margin-top:10px;display:none;">
								<li style="height:30px;">
									<a href="${APP_PATH}/user/index"><i class="glyphicon glyphicon-user"></i> 用户维护</a>
								</li>
								<li style="height:30px;">
									<a href="${APP_PATH}/role/index"><i class="glyphicon glyphicon-king"></i> 角色维护</a>
								</li>
								<li style="height:30px;">
									<a href="${APP_PATH}/resource/index"><i class="glyphicon glyphicon-lock"></i> 许可维护</a>
								</li>
							</ul>
						</li>
					</ul>
				</div>
			</div>
		 </div>
        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
				<ol class="breadcrumb">
				  <li><a href="#">首页</a></li>
				  <li><a href="#">资源列表</a></li>
				  <li class="active">更新</li>
				</ol>
			<div class="panel panel-default">
              <div class="panel-heading">资源数据<div style="float:right;cursor:pointer;" data-toggle="modal" data-target="#myModal"><i class="glyphicon glyphicon-question-sign"></i></div></div>
			  <div class="panel-body">
				<form role="form">
					<div class="form-group">
						<label for="resourceName">资源名称</label>
						<input type="text" class="form-control" id="resourceName" value="${resource.resourceName}" placeholder="请输入资源名称">
					</div>
					<div class="form-group">
						<label for="resourceUrl">资源路径</label>
						<input type="text" class="form-control" id="resourceUrl" value="${resource.resourceUrl}" placeholder="请输入资源路径">
					</div>
					<div class="form-group" >
						<label >资源类型</label>
						<select class="form-control" id="select" name="select">
							<option ${resource.resourceType eq '0'?'selected':''} value="0">菜单</option>
							<option ${resource.resourceType eq '1'?'selected':''} value="1">按钮</option>
						</select>
					</div>
				  <button id="insertBtn" type="button" class="btn btn-success"><i class="glyphicon glyphicon-plus"></i> 更新 </button>
				</form>
			  </div>
			</div>
        </div>
      </div>
    </div>
	<div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel" aria-hidden="true">
	  <div class="modal-dialog">
		<div class="modal-content">
		  <div class="modal-header">
			<button type="button" class="close" data-dismiss="modal"><span aria-hidden="true">&times;</span><span class="sr-only">Close</span></button>
			<h4 class="modal-title" id="myModalLabel">帮助</h4>
		  </div>
		  <div class="modal-body">
			<div class="bs-callout bs-callout-info">
				<h4>测试标题1</h4>
				<p>测试内容1，测试内容1，测试内容1，测试内容1，测试内容1，测试内容1</p>
			  </div>
			<div class="bs-callout bs-callout-info">
				<h4>测试标题2</h4>
				<p>测试内容2，测试内容2，测试内容2，测试内容2，测试内容2，测试内容2</p>
			  </div>
		  </div>
		  <!--
		  <div class="modal-footer">
			<button type="button" class="btn btn-default" data-dismiss="modal">Close</button>
			<button type="button" class="btn btn-primary">Save changes</button>
		  </div>
		  -->
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

			    	var resourceName = $("#resourceName").val();
			    	if ( resourceName == "" ) {
                        layer.msg("资源名不能为空，请输入", {time:2000, icon:5, shift:6}, function(){
                        	
                        });
                        return;
			    	}

					var resourceUrl = $("#resourceUrl").val();
					if ( resourceUrl == "" ) {
						layer.msg("资源路径不能为空，请输入", {time:2000, icon:5, shift:6}, function(){

						});
						return;
					}

					var resourceType = $("#select option:selected").val();
			    	
			    	var loadingIndex = null;
			    	$.ajax({
			    		type : "POST",
						datatype :"json",
						contentType:"application/json;charsetset=UTF-8",
			    		url  : "${APP_PATH}/resource/update",
			    		data : JSON.stringify({
							"id": ${resource.id},
							"parentId": ${resource.parentId},
							"resourceName" : resourceName,
							"resourceUrl" : resourceUrl,
							"resourceType" : resourceType
						}),
			    		beforeSend : function() {
			    			loadingIndex = layer.msg('处理中', {icon: 16});
			    		},
			    		success : function(result) {
			    			layer.close(loadingIndex);
			    			if ( result.success ) {
		                        layer.msg("资源信息保存成功", {time:1000, icon:6}, function(){
		                        	window.location.href = "${APP_PATH}/resource/index";
		                        });
			    			} else {
		                        layer.msg("资源信息保存失败，请重新操作", {time:2000, icon:5, shift:6}, function(){
		                        	
		                        });
			    			}
			    		}
			    	});
			    });
            });
        </script>
  </body>
</html>
