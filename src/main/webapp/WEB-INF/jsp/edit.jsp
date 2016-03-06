<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2016/2/18
  Time: 16:54
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
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
        $('#servletAction2').val($('#servletAction1').val());
        var action=$('#formSave').attr('action');
        console.log(action);
        //var a="a/b/c/d";console.log(a);var index=a.lastIndexOf('/');console.log(a.substring(0,index+1))  output:a/b/c/
        var index=action.lastIndexOf('/')
        $('#formSave').attr('action',action.substring(0,index+1)+"save");
    }
    var saveAction=function(){
    	$('#servletAction2').val($('#servletAction1').val());
        var options = {
            type: "POST",
            dataType: 'json',
            success: function (json2) {
                if (json2.result) {
                    var $success=$('div.success');
                    $success.show();
                    $success.html("更新成功");
                    setTimeout(hideMessage,5000);
                } else {
                    pleaseLoginFirst();
                    hideLoadPanel();
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
    编辑的接口: <input type="text" id="servletAction1" name="servletAction" VALUE="${servletAction}" style="width: 400px;" > <input type="submit" value="搜索" >
    
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
        <textarea name="content" id="content" cols="85" rows="30">${content }</textarea>
        <br>
        <input type="button" class="submit" onclick="saveAction();" value="确认更新" > &nbsp;<input type="submit" onclick="addAction();" value="新增" >
    </form>

</div>
</body>
</html>
