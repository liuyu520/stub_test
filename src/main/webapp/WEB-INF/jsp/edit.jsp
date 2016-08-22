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
    var selectedIndex=${stubs.selectedIndex};
    var server_url = "http://" + location.host+""//+"/convention";
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
    };
    var showError=function (message) {
        var $error=$('div.error');
        $error.show();
        $error.html(message);
        setTimeout(hideMessage,5000);
    };
    var showSuccess=function (message) {
        var $success=$('div.success');
        $success.show();
        $success.html(message);
        setTimeout(hideMessage,5000);
    };
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
    };
    var updateIndex=function (selectedIndex2) {
        if(selectedIndex2==window.selectedIndex){
            console.log('selectedIndex:'+window.selectedIndex);
            return;
        }
        var options = {
            url: server_url + "/stubEdit/updateIndex",
            type: "POST",
            dataType: 'json',
            data:{"index":selectedIndex2,"servletAction":$('#servletAction1').val()},
            success: function (json2) {
                if (json2.result) {
                    showSuccess("已更新当前项");
                    window.selectedIndex=selectedIndex2;
//                            alert(json2.tips);
                } else  {
                    alert(json2.errorMessage)
                }
            },
            error: function (er) {
                console.log(er)
            }
        };
        $.ajax(options);
    };
    var updateIndexThrottle=throttle3(updateIndex,200);
    var bindEvent=function ($textarea) {
        $textarea.keydown(function (event) {
//            console.log(event.keyCode)
            if ((event.keyCode == 83/*S*/||event.keyCode == 88/*X*/ )&& event.ctrlKey) {
                console.log('save');
                $('textarea').removeClass('selected');
                var $self=$(this);
                $self.addClass('selected');
                var data={"servletAction":$('#servletAction1').val(),
                    "content":$self.val(),
                    "index":$self.data('index')};
                var options = {
                    url: server_url + "/stubEdit/updateJsonOne",
                    type: "POST",
                    dataType: 'json',
                    data:data,
                    success: function (json2) {
                        if (json2.result) {
                            showSuccess("更新成功");
//                            alert(json2.tips);
                        } else  {
                            alert(json2.errorMessage)
                        }
                    },
                    error: function (er) {
                        console.log(er)
                    }
                };
                $.ajax(options);
            }
        }).click(function (event) {
            var $self=$(this);
            var selectedIndex=$self.data('index');
            updateIndexThrottle(selectedIndex);
        }).focus(function (event) {
            var $self=$(this);
            var selectedIndex=$self.data('index');
            updateIndexThrottle(selectedIndex);
        });

    };
    $(function (event) {
        bindEvent($('textarea'));
        adapterDivWidth($('textarea'),$('div.stubRange'));
    });
    //使div (class 为"stubRange")的宽度能够容得下所有的文本域
    var adapterDivWidth=function ($textareas,$div) {
        var stubRangeDivWidth=0;
        $textareas.each(function () {
            stubRangeDivWidth+=($(this).width()+3);
        });
        console.log("stubRangeDivWidth:"+stubRangeDivWidth);
        $div.css('width',(stubRangeDivWidth+126));
    };
    var addOptionTextarea=function (self) {
        var $stubRangeDiv=$('div.stubRange');
        var $textareas=$stubRangeDiv.find('textarea');
        var textareaLength=$textareas.length;
        var $textareasHTML='<textarea data-index="'+textareaLength+'" style="float: left;" name="content" cols="85" rows="28">${stub }</textarea>';
        $(self).before($textareasHTML);
        $textareas=$stubRangeDiv.find('textarea');//因为新增了一个textarea,所以需要重新获取一遍,否则$textareas不包括新增的那个
        bindEvent($($textareas.get(textareaLength)));//新增的那个textarea也得重新绑定事件
        adapterDivWidth($textareas,$stubRangeDiv);
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
<div style="height: 22px;" >
    <div class="error" >${errorMessage}</div>
    <div class="success" >${tips}</div>
</div>
<div>
    <form action="<%=path%>/stubEdit/updateJson" method="post" id="formSave" >
        <input type="hidden" id="servletAction2" name="servletAction" VALUE="${servletAction}" >
        <div style="width: 100%;overflow-y: hidden;overflow-x: auto;">
            <div class="stubRange">
                <c:forEach items="${stubs.stubs }" var="stub" varStatus="status">
                <textarea data-index="${status.index}" style="float: left;"
                          <c:if test="${stubs.selectedIndex==status.index}">class="selected"</c:if> name="content" placeholder="Ctrl+X 或者Ctrl+S 保存"
                          cols="85" rows="28">${stub }</textarea>
                </c:forEach>
                <a style="float: left" onclick="addOptionTextarea(this)" href="javascript:void(0)">添加option</a>
            </div>
        </div>
        <br>
        <%--<input type="button" class="submit" onclick="saveAction();" value="确认更新" > &nbsp;--%><input type="submit" onclick="return addAction();" value="新增" >
    </form>

</div>
</body>
</html>
