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
          <div><a class="navbar-brand" style="font-size:32px;" href="#">RBAC平台 - 角色维护</a></div>
        </div>
        <div id="navbar" class="navbar-collapse collapse">
          <ul class="nav navbar-nav navbar-right">
            <li style="padding-top:8px;">
				<div class="btn-group">
				  <button type="button" class="btn btn-default btn-success dropdown-toggle" data-toggle="dropdown">
					<i class="glyphicon glyphicon-role"></i> ${loginUser.userName} <span class="caret"></span>
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
								  <a href="${APP_PATH}/user/index"><i class="glyphicon glyphicon-user"></i> 用户维护 </a>
							  </li>
							  <li style="height:30px;">
								  <a href="${APP_PATH}/role/index"><i class="glyphicon glyphicon-king"></i> 角色维护 </a>
							  </li>
							  <li style="height:30px;">
								  <a href="${APP_PATH}/resource/index"><i class="glyphicon glyphicon-lock"></i> 许可维护 </a>
							  </li>
						  </ul>
					  </li>
				  </ul>
			  </div>
		  </div>
        <div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
			<div class="panel panel-default">
			  <div class="panel-heading">
				<h3 class="panel-title"><i class="glyphicon glyphicon-th"></i> 数据列表</h3>
			  </div>
			  <div class="panel-body">
<form class="form-inline" role="form" style="float:left;">
  <div class="form-group has-feedback">
    <div class="input-group">
      <div class="input-group-addon">查询条件</div>
      <input id="queryText" class="form-control has-success" type="text" placeholder="请输入查询条件">
    </div>
  </div>
  <button id="queryBtn" type="button" class="btn btn-warning"><i class="glyphicon glyphicon-search"></i> 查询</button>
</form>
<button type="button" class="btn btn-danger" onclick="deleteUsers()" style="float:right;margin-left:10px;"><i class=" glyphicon glyphicon-remove"></i> 删除</button>
<button type="button" class="btn btn-primary" style="float:right;" onclick="window.location.href='${APP_PATH}/role/add'"><i class="glyphicon glyphicon-plus"></i> 新增</button>
<br>
 <hr style="clear:both;">
          <div class="table-responsive">
            <form id="roleForm">
            <table class="table  table-bordered">
              <thead>
                <tr >
                  <th width="30">#</th>
				  <th width="30"><input type="checkbox" id="allSelBox"></th>
                  <th>名称</th>
                  <th width="100">操作</th>
                </tr>
              </thead>
              
              <tbody id="roleData">
                  
              </tbody>
              
			  <tfoot>
			     <tr >
				     <td colspan="6" align="center">
						<ul class="pagination">

							 </ul>
					 </td>
				 </tr>

			  </tfoot>
            </table>
            </form>
          </div>
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
            var likeflg = false;
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
			    
			    pageQuery(1);
			    
			    $("#queryBtn").click(function(){
			    	var queryText = $("#queryText").val();
			    	if ( queryText == "" ) {
			    		likeflg = false;
			    	} else {
			    		likeflg = true;
			    	}
			    	
			    	pageQuery(1);
			    });
			    
			    $("#allSelBox").click(function(){
			    	var flg = this.checked;
			    	$("#roleData :checkbox").each(function(){
			    		this.checked = flg;
			    	});
			    });
            });
            
            // 分页查询
            function pageQuery( pageNum ) {
            	var loadingIndex = null;
            	
            	var jsonData = {"pageNum" : pageNum, "pageSize" : 6};
            	if ( likeflg == true ) {
            		jsonData.queryText = $("#queryText").val();
            	}
            	
            	$.ajax({
            		type : "POST",
            		url  : "${APP_PATH}/role/pageQuery",
					datatype :"json",
					contentType:"application/json;charsetset=UTF-8",
					data : JSON.stringify(jsonData),
            		beforeSend : function(){
            			loadingIndex = layer.msg('处理中', {icon: 16});
            		},
            		success : function(result) {
            			layer.close(loadingIndex);
            			if ( result.success ) {
            				// 局部刷新页面数据
            				var tableContent = "";
            				var pageContent = "";
            				
            				var rolePage = result.data;
            				var roles = rolePage.records;
            				
            				$.each(roles, function(i, role){
            	                tableContent += '<tr>';
	          	                tableContent += '  <td>'+(i+1)+'</td>';
	          					tableContent += '  <td><input type="checkbox" name="roleid" value="'+role.id+'"></td>';
	          	                tableContent += '  <td>'+role.roleName+'</td>';
	          	                tableContent += '  <td>';
	          					tableContent += '      <button type="button" onclick="goAssignPage('+role.id+')" class="btn btn-success btn-xs"><i class=" glyphicon glyphicon-check"></i></button>';
	          					tableContent += '      <button type="button" onclick="" class="btn btn-primary btn-xs"><i class=" glyphicon glyphicon-pencil"></i></button>';
								tableContent += '	  <button type="button" onclick="deleteUser('+role.id+', \''+role.roleName+'\')" class="btn btn-danger btn-xs"><i class=" glyphicon glyphicon-remove"></i></button>';
	          					tableContent += '  </td>';
	          	                tableContent += '</tr>';
            				});
            				
            				if ( pageNum > 1 ) {
            					pageContent += '<li><a href="#" onclick="pageQuery('+(pageNum-1)+')">上一页</a></li>';
            				}
            				
            				for ( var i = 1; i <= rolePage.pages; i++ ) {
            					if ( i == pageNum ) {
            						pageContent += '<li class="active"><a  href="#">'+i+'</a></li>';
            					} else {
            						pageContent += '<li ><a href="#" onclick="pageQuery('+i+')">'+i+'</a></li>';
            					}
            				}
            				
            				if ( pageNum < rolePage.pages ) {
            					pageContent += '<li><a href="#" onclick="pageQuery('+(pageNum+1)+')">下一页</a></li>';
            				}

            				$("#roleData").html(tableContent);
            				$(".pagination").html(pageContent);
            			} else {
                            layer.msg("角色信息分页查询失败", {time:2000, icon:5, shift:6}, function(){
                            	
                            });
            			}
            		}
            	});
            }

			function goUpdatePage(id) {
				window.location.href = "${APP_PATH}/role/edit?id="+id;
			}
            
            function goAssignPage(id) {
            	window.location.href = "${APP_PATH}/role/assign?id="+id;
            }

			function deleteUsers() {
				var ids = [];
				$("input[name='roleid']:checked").each(function (i) {
					ids[i] = $(this).val();
				});

				if ( ids.length == 0 ) {
					layer.msg("请选择需要删除的角色信息", {time:2000, icon:5, shift:6}, function(){

					});
				} else {
					layer.confirm("删除选择的角色信息, 是否继续",  {icon: 3, title:'提示'}, function(cindex){
						// 删除选择的用户信息
						$.ajax({
							type : "POST",
							datatype :"json",
							contentType:"application/json;charsetset=UTF-8",
							url  : "${APP_PATH}/role/deletes",
							data : JSON.stringify({
								"roleIds": ids
							}),
							success : function(result) {
								if ( result.success ) {
									pageQuery(1);
								} else {
									layer.msg("角色信息删除失败", {time:2000, icon:5, shift:6}, function(){

									});
								}
							}
						});

						layer.close(cindex);
					}, function(cindex){
						layer.close(cindex);
					});
				}
			}

			function deleteUser( id, roleName ) {
				layer.confirm("删除角色信息【"+roleName+"】, 是否继续",  {icon: 3, title:'提示'}, function(cindex){

					// 删除用户信息
					$.ajax({
						type : "GET",
						url  : "${APP_PATH}/role/delete",
						data : { id : id },
						success : function(result) {
							if ( result.success ) {
								pageQuery(1);
							} else {
								layer.msg("角色信息删除失败", {time:2000, icon:5, shift:6}, function(){

								});
							}
						}
					});

					layer.close(cindex);
				}, function(cindex){
					layer.close(cindex);
				});
			}
        </script>
  </body>
</html>
