<%--
  Created by IntelliJ IDEA.
  User: huangwei
  Date: 2016/2/18
  Time: 16:54
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions"%>
<%
    String path = request.getContextPath();
    String basePath = request.getScheme() + "://"
            + request.getServerName() + ":" + request.getServerPort()
            + path + "/";
    if (path.equals("/")) {
        path = "";
    }
%>
<html>
<head>
    <title>接口列表-stub测试</title>
    <link rel="stylesheet" type="text/css" href="<%=path%>/static/css/global.css">
    <script type="text/javascript" src="http://hbjltv.com/static/js/jquery-1.11.1.js"></script>
    <script type="text/javascript" src="http://hbjltv.com/static/js/common_util.js"></script>
</head>
<style>
    .success{
        color: green;
        font-weight: bolder;
    }
    .error{
        color:red;
        font-weight: bolder;
    }
</style>
<script type="text/javascript">

</script>
<body>
<div>
    <a target="_blank" href="<%=path%>/stubEdit/dispachInput">生成nginx脚本</a>
</div>
<div>
    <form action="<%=path%>/">
    搜索: <input type="text"  name="keyWord" VALUE="${keyWord}" style="width: 400px;" > <input type="submit" value="搜索" >
    
    </form>
    
</div>
<div>
<%-- <a target="_blank" href="<%=path%>/stubEdit/old_content">stub历史记录</a>
<br> --%>
    <c:choose>
        <c:when test="${stubPathList==null||fn:length(stubPathList)==0 }">暂无记录</c:when>
        <c:otherwise>



    <ul>
    <table class="stubList" border="1">
        <tr>
            <th>接口路径</th>
            <th>操作</th>
        </tr>
        <c:forEach varStatus="status" items="${stubPathList }" var="stubPath">


            <tr>
                <td><a target="_blank" href="<%=path %>/stub${stubPath}">${stubPath }</a></td>
                <td><a target="_blank" href="<%=path %>/stubEdit/search?servletAction=${stubPath }" >编辑</a>
                    &nbsp;&nbsp;
                    <a target="_blank" href="<%=path %>/stubEdit/dispachInput?targetUrl=${stubPath }" >生成nginx 脚本</a></td>
            </tr>
        </c:forEach>
    </table>

    </ul>
        </c:otherwise>
    </c:choose>
</div>
</body>
</html>
