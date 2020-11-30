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
				  </ul>
			  </div>
			  <div class="tree">
				  <%@include file="/WEB-INF/jsp/common/menu.jsp"%>
			  </div>
		  </div>

		<div class="col-sm-9 col-sm-offset-3 col-md-10 col-md-offset-2 main">
			<div class="panel panel-default">
				<div class="panel-heading">
					<h3 class="panel-title"><i class="glyphicon glyphicon-th"></i> 首页展示 </h3>
				</div>
			<div class="panel-body">
			<div class="row placeholders">
				<div class="col-xs-6 col-sm-3 placeholder">
					<img data-src="holder.js/200x200/auto/sky" class="img-responsive" alt="Generic placeholder thumbnail">
					<h4>Label</h4>
					<span class="text-muted">Something else</span>
				</div>
				<div class="col-xs-6 col-sm-3 placeholder">
					<img data-src="holder.js/200x200/auto/vine" class="img-responsive" alt="Generic placeholder thumbnail">
					<h4>Label</h4>
					<span class="text-muted">Something else</span>
				</div>
				<div class="col-xs-6 col-sm-3 placeholder">
					<img data-src="holder.js/200x200/auto/sky" class="img-responsive" alt="Generic placeholder thumbnail">
					<h4>Label</h4>
					<span class="text-muted">Something else</span>
				</div>
				<div class="col-xs-6 col-sm-3 placeholder">
					<img data-src="holder.js/200x200/auto/vine" class="img-responsive" alt="Generic placeholder thumbnail">
					<h4>Label</h4>
					<span class="text-muted">Something else</span>
				</div>
			</div>
			<div id="main" style="width: 600px;height:400px;"></div>
		</div>
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
		var myChart = echarts.init(document.getElementById('main'));

		// 指定图表的配置项和数据
		var option = {
			title: {
				text: 'ECharts 入门示例'
			},
			tooltip: {},
			legend: {
				data:['销量']
			},
			xAxis: {
				data: ["衬衫","羊毛衫","雪纺衫","裤子","高跟鞋","袜子"]
			},
			yAxis: {},
			series: [{
				name: '销量',
				type: 'bar',
				data: [5, 20, 36, 10, 10, 20]
			}]
		};

		// 使用刚指定的配置项和数据显示图表。
		myChart.setOption(option);
	</script>
  </body>
</html>
