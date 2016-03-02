<%--
  Created by IntelliJ IDEA.
  User: Administrator
  Date: 2016/3/2
  Time: 8:59
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
    <title>nginx dispach</title>
    <link rel="stylesheet" type="text/css" href="<%=path%>/static/css/global.css">
    <script type="text/javascript" src="http://hbjltv.com/static/js/jquery-1.11.1.js"></script>
    <script type="text/javascript" src="http://hbjltv.com/static/js/common_util.js"></script>
    <script type="text/javascript">
        var generateNginx= function () {
            var targetUrl=$('input[name=targetUrl]');
            var targetUrlVal=targetUrl.val();
            if(!targetUrlVal){
                alert("请输入目标接口");
                targetUrl.focus();
                return;
            }
            var options = {
                url: "<%=path%>/nginx_dispatch_json" ,
                type: "POST",
                data:{targetUrl:targetUrlVal,
                    stubUrl:$('input[name=stubUrl]').val()},
                dataType: 'json',
                success: function (json2) {
                    if (json2.cmd) {
                        $('textarea').val(json2.cmd).focus();
                        $correct=$('span.correct');
                        $correct.text('成功');
                        $correct.show('normal');
                        setTimeout(hideMessage,5000);
                    } else {
                        alert("失败")
                    }
                },
                error: function (er) {
                    console.log(er)
                }
            };
            $.ajax(options);
        }
        $(function () {
            var targetUrl=$('input[name=targetUrl]');
            var targetUrlVal=targetUrl.val();
            if(!targetUrlVal){
                targetUrl.focus();
            }
        });
        var hideMessage= function () {
            $('span.error').hide();
            $('span.correct').hide('normal');
        };
    </script>
    <style>
        input[type=text]{
            width: 600px;
        }
    </style>
</head>
<body>
<div>
    <form action="">
        <table>
            <tr>
                <td>
                    <label for="">目标接口</label>
                </td>
                <td>
                    <input type="text" name="targetUrl" value="${targetUrl}"  >
                </td>
            </tr>
            <tr>
                <td>
                    <label for="">stub ip</label>
                </td>
                <td>
                    <input type="text" name="stubUrl" placeholder="www.yhskyc.com/"  >
                </td>
            </tr>
            <tr>
                <td colspan="1" style="text-align: center;" >
                    <input type="button" onclick="generateNginx();" value="生成nginx脚本" >
                </td>
                <td><span class="correct" >${tips}</span></td>
            </tr>
            <tr>
                <td colspan="2" >
                    <textarea name="" id="" cols="90" rows="5"></textarea>
                </td>

            </tr>
        </table>
    </form>
    
</div>
</body>
</html>
