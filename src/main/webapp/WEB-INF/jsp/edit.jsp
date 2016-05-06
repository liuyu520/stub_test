<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2016/2/18
  Time: 16:54
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ taglib prefix="fn" uri="http://java.sun.com/jsp/jstl/functions" %>
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
    <title>编辑${servletAction}-stub测试</title>
    <link rel="stylesheet" type="text/css" href="<%=path%>/static/css/global.css">
    <script type="text/javascript" src="http://hbjltv.com/static/js/jquery-1.11.1.js"></script>
    <script type="text/javascript" src="http://hbjltv.com/static/js/common_util.js"></script>
    <script type="text/javascript" src="http://hbjltv.com/static/js/jquery.form.js"></script>
    <script type="text/javascript" src="<%=path%>/static/js/stub.js"></script>
    <script type="text/javascript">
        $(function () {
            $('input[name=servletAction]').focus();
        })
    </script>
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
    var hideMessage= function () {
        $('div.error').hide();
        $('div.success').hide();
    };
   /* $(function () {
        setTimeout(hideMessage,5000);
    });*/
    var addAction= function () {
        var servletActionPath=$('#servletAction1').val();
        if(!servletActionPath){
            showError("请输入接口路径");
            return false;
        }
        $('#servletAction2').val(servletActionPath);
        var action=$('#formSave').attr('action');
        console.log(action);
        //var a="a/b/c/d";console.log(a);var index=a.lastIndexOf('/');console.log(a.substring(0,index+1))  output:a/b/c/
        var index=action.lastIndexOf('/')
        $('#formSave').attr('action',action.substring(0,index+1)+"save");
        return true;
    }
    var showError=function (message) {
        var $error=$('div.error');
        $error.show();
        $error.html(message);
        setTimeout(hideMessage,5000);
    }
    var showSuccess=function (message) {
        var $success=$('div.success');
        $success.show();
        $success.html(message);
        setTimeout(hideMessage,5000);
    }
    var saveAction=function(){
        var servletActionPath=$('#servletAction1').val();
        if(!servletActionPath){
            showError("请输入接口路径");
            return;
        }
    	$('#servletAction2').val(servletActionPath);
        var options = {
            type: "POST",
            dataType: 'json',
            success: function (json2) {
                if (json2.result) {
                    showSuccess("更新成功");
                } else {
                    console.log(json2);
//                    hideLoadPanel();
                    showError(json2.errorMessage);
                }
            }
            ,
            error: function (er) {
                console.log(er);
                alert(er.responseText);
            }
        };
        //采用Ajax 提交表单,页面不会跳转

        $('#formSave').ajaxSubmit(options);
    }
</script>
<body>
<div>
    <form action="<%=path%>/stubEdit/search">
    ${action}的接口: <input type="text" id="servletAction1" name="servletAction" VALUE="${servletAction}" style="width: 400px;" placeholder="/api/v1/appstore/queryOrgBuyProductInfo" > <input type="submit" value="搜索" >
    
    </form>
    
</div>
<a target="_blank" href="<%=path%>/">stub接口列表</a>&nbsp;&nbsp;<a target="_blank" href="<%=path%>/old_content">stub历史记录</a>
<br>
访问地址: <a target="_blank" href="${url}">${url}</a>
<div class="error" >${errorMessage}</div>
<div class="success" >${tips}</div>
<div>
    <form action="<%=path%>/stubEdit/updateJson" method="post" id="formSave" >
        <input type="hidden" id="servletAction2" name="servletAction" VALUE="${servletAction}" >
        <div class="stubRange">
            <c:forEach items="${stubs.stubs }" var="stub" varStatus="status">
                <textarea data-index="${status.index}" style="float: left;width:500px;"
                          <c:if test="${stubs.selectedIndex==status.index}">class="selected"</c:if> name="content"
                          cols="85" rows="28">${stub }</textarea>
            </c:forEach>

        </div>
        <br>
        <input type="button" class="submit" onclick="saveAction();" value="确认更新" > &nbsp;<input type="submit" onclick="return addAction();" value="新增" >
    </form>

</div>
</body>
</html>
