<%@page pageEncoding="UTF-8"%>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<ul style="padding-left:0px;" class="list-group">
    <c:forEach items="${root.children}" var="node">
        <c:if test="${empty node.children}">
			<li class="list-group-item tree-closed" >
				<a href="${APP_PATH}${node.url}"><i class="${node.icon}"></i> ${node.name}</a>
			</li>        
        </c:if>
        <c:if test="${not empty node.children}">
			<li class="list-group-item tree-closed">
				<span><a href="${APP_PATH}${node.url}"><i class="${node.icon}"></i>${node.name}</a><span class="badge" style="float:right">${node.children.size()}</span></span>
				<ul style="margin-top:10px;display:none;">
					<c:forEach items="${node.children}" var="child">
					<li style="height:30px;">
						<a href="${APP_PATH}${child.url}"><i class="${child.icon}"></i> ${child.name}</a> 
					</li>
					</c:forEach>
				</ul>
			</li>
        </c:if>
    </c:forEach>
</ul>