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
	  </div>

	<div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
		<div class="panel panel-default">
			<div class="panel-heading">
				<h3 class="panel-title"><i class="glyphicon glyphicon-th"></i> 基金首页展示 </h3>
			</div>
		<div class="panel-body">
		<div id="fundIndex" style="width: 1000px;height:600px;"></div>
	</div>
	</div>
	</div>
	  </div>
	<script src="${APP_PATH}/jquery/jquery-2.1.1.min.js"></script>
	<script src="${APP_PATH}/bootstrap/js/bootstrap.min.js"></script>
	<script src="${APP_PATH}/script/docs.min.js"></script>
	<script src="${APP_PATH}/echarts/echarts.min.js"></script>
	<script type="text/javascript">
		$(function () {
			$(".list-group-item").click(function(){
				// jquery对象的回调方法中的this关键字为DOM对象
				// $(DOM) ==> JQuery
				if ( $(this).find("ul") ) { // 3 li
					$(this).toggleClass("tree-closed");
					if ( $(this).hasClass("tree-closed") ) {
						$("ul", this).hide("fast");
					} else {
						$("ul", this).show("fast");
					}
				}
			});
		});

		// 基于准备好的dom，初始化echarts实例
		var myChart = echarts.init(document.getElementById('fundIndex'));

		myChart.setOption({
			backgroundColor: '#D8D8D8',
			textStyle: {
				color: 'rgba(255, 255, 255, 0.3)'
			},
			series : [
				{
					name: '访问来源',
					type: 'pie',
					radius: '76%',
					data:[
						{value:400, name:'搜索引擎'},
						{value:335, name:'直接访问'},
						{value:310, name:'邮件营销'},
						{value:274, name:'联盟广告'},
						{value:235, name:'视频广告'}
					],
					roseType: 'angle',

					itemStyle: {
						emphasis: {
							shadowBlur: 200,
							shadowColor: 'rgba(0, 0, 0, 0.5)'
						}
					},
					label: {
						normal: {
							textStyle: {
								color: 'rgba(0, 0, 0, 0.3)'
							}
						}
					},
					labelLine: {
						normal: {
							lineStyle: {
								color: 'rgba(0, 0, 0, 0.3)'
							}
						}
					}

				}
			]
		});

	</script>
  </body>
</html>
