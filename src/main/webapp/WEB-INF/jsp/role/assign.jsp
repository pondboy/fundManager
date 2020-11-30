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
	<link rel="stylesheet" href="${APP_PATH}/ztree/zTreeStyle.css">
	<style>
	.tree li {
        list-style-type: none;
		cursor:pointer;
	}
	table tbody tr:nth-child(odd){background:#F4F4F4;}
	table tbody td:nth-child(even){color:#C00;}
	</style>
  </head>

  <body>

    <nav class="navbar navbar-inverse navbar-fixed-top" role="navigation">
      <div class="container-fluid">
        <div class="navbar-header">
          <div><a class="navbar-brand" style="font-size:32px;" href="#">众筹平台 - 角色维护</a></div>
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
						<span><i class="glyphicon glyphicon-tasks"></i> 基金管理 <span class="badge" style="float:right">3</span></span>
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
					<li class="list-group-item tree-closed">
						<span><i class="glyphicon glyphicon-th-large"></i> 股票管理 <span class="badge" style="float:right">3</span></span>
						<ul style="margin-top:10px;display:none;">
							<li style="height:30px;">
								<a href="${APP_PATH}/stock/hold"><i class="glyphicon glyphicon-heart"></i> 持有股票池 </a>
							</li>
							<li style="height:30px;">
								<a href="${APP_PATH}/stock/option"><i class="glyphicon glyphicon-heart-empty"></i> 自选股票池 </a>
							</li>
							<li style="height:30px;">
								<a href="${APP_PATH}/stock/strategy"><i class="glyphicon glyphicon-eye-open"></i> 明日操作策略 </a>
							</li>
						</ul>
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
        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
			<div class="panel panel-default">
			  <div class="panel-heading">
				<h3 class="panel-title"><i class="glyphicon glyphicon-th"></i> 角色新增资源显示页面</h3>
			  </div>
			  <div class="panel-body">
				  <button class="btn btn-success" onclick="doAssign()">分配资源</button>
                  <ul id="resourceTree" class="ztree"></ul>
			  </div>
			</div>
        </div>
      </div>
    </div>

    <script src="${APP_PATH}/jquery/jquery-2.1.1.min.js"></script>
    <script src="${APP_PATH}/bootstrap/js/bootstrap.min.js"></script>
	<script src="${APP_PATH}/script/docs.min.js"></script>
	<script src="${APP_PATH}/layer/layer.js"></script>
	<script src="${APP_PATH}/ztree/jquery.ztree.all-3.5.min.js"></script>
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
			    
			    var setting = {
					check : {
						enable : true
					},
		    		async: {
		    			enable: true,
						type: "GET",
		    			url:"${APP_PATH}/resource/loadAssignResources?roleId=${param.id}",
		    			autoParam:["id", "name=n", "level=lv"]
		    		},
					view: {
						selectedMulti: false,
						addDiyDom: function(treeId, treeNode){
							var icoObj = $("#" + treeNode.tId + "_ico"); // tId = permissionTree_1, $("#permissionTree_1_ico")
							if ( treeNode.icon ) {
								icoObj.removeClass("button ico_docu ico_open").addClass(treeNode.icon).css("background","");
							}
                            
						}
					}
			    };

			    // 异步获取树形结构数据
			    $.fn.zTree.init($("#resourceTree"), setting);
            });
            function doAssign() {
				var treeObj = $.fn.zTree.getZTreeObj("resourceTree");
				var nodes = treeObj.getCheckedNodes(true);
				if(nodes.length==0) {
					layer.msg("请选择需要分配的资源信息", {time:1000, icon:5}, function(){

					});
				} else {
					var roleId = ${param.id};
					var resourceIds = [];
					$.each(nodes,function (i,node) {
						resourceIds[i] =  node.id;
					});
					$.ajax({
						type : "POST",
						datatype :"json",
						contentType:"application/json;charsetset=UTF-8",
						url  : "${APP_PATH}/role/assign",
						data : JSON.stringify({
							"roleId": roleId,
							"resourceIds": resourceIds
						}),
						success : function(result) {
							if ( result.success ) {
								layer.msg("角色添加资源信息成功", {time:2000, icon:6, shift:6}, function(){

								});
							} else {
								layer.msg("角色添加资源信息失败", {time:2000, icon:5, shift:6}, function(){

								});
							}
						}
					});
				}
			}
        </script>
  </body>
</html>
