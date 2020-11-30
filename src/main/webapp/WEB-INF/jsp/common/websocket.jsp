<%@page pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<ul style="padding-left:0px;" class="list-group">
    <script>
		var  websocket = null;
		if('WebSocket' in window) {
			websocket = new websocket('ws://');
		} else {
			alert('该浏览器不支持websocket1');
		}

		websocket.onopen = function (event) {
			console.log('建立连接');
		}

		websocket.onclose = function (event) {
			console.log('关闭连接');
		}

		websocket.onmessage = function (event) {
			console.log('收到消息：'+event.data);
		}

		websocket.onerror = function (event) {
			alert('webscoket通信发生错误！');
		}

		window.onbeforeunload = function () {
			websocket.close();
		}
	</script>
</ul>