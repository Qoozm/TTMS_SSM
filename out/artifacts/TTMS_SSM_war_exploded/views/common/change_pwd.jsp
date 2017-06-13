<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%--
  Created by IntelliJ IDEA.
  User: Charley
  Date: 2017/6/8
  Time: 15:22
  To change this template use File | Settings | File Templates.
--%>

<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ page isELIgnored="false" %>
<html class=" js csstransforms3d"><head>
    <meta charset="utf-8">
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>修改密码</title>
    <link rel="stylesheet" href="/static/css/base.css">
    <link rel="stylesheet" href="/static/css/page.css">
    <!--[if lte IE 8]>
    <link href="static/css/ie8.css" rel="stylesheet" type="text/css"/>
    <![endif]-->
    <script type="text/javascript" src="/static/js/jquery.min.js"></script>
    <script type="text/javascript" src="/static/js/main.js"></script>
    <script type="text/javascript" src="/static/js/modernizr.js"></script>
    <!--[if IE]>
    <script src="http://libs.useso.com/js/html5shiv/3.7/html5shiv.min.js"></script>
    <![endif]-->
    <script language="JavaScript">

        function checkpwd() {

            var new_pwd = document.getElementById("new_pwd").value;
            var rnew_pwd = document.getElementById("rnew_pwd").value;
            if (new_pwd != rnew_pwd) {
                alert("两次密码不一致！");
                return false;
            }
        }

    </script>
    <style type="text/css">
        
        .errorBox {
            color: #e62337;
        }
    </style>

</head>

<body style="background: #f6f5fa;">
<!--content S-->
<div class="super-content">
    <div class="superCtab">
        <div class="publishArt">
            <h4>修改密码</h4>

            <form id="change_psw_form" method="post" action="/pwdChange" autocomplete="on">

                <div class="pubMain">
                    <h5 class="pubtitle">旧密码</h5>
                    <div class="pub-txt-bar">
                        <input id="old_pwd" name="old_pwd" type="password"  required="required" oninvalid="setCustomValidity('请输入原密码')"
                               oninput="setCustomValidity('')" class="shuruTxt shuruTxt2">
                    </div>
                    <h5 class="pubtitle">新密码<span>（数字、字母、下划线组合，最少6个字符）</span></h5>
                    <div class="pub-txt-bar">
                        <input type="password" name="new_pwd" pattern="^[\u4E00-\u9FA5A-Za-z0-9_]{6,}$" required="required" oninvalid="setCustomValidity('请输入正确密码格式')"
                               oninput="setCustomValidity('')" id="new_pwd" class="shuruTxt shuruTxt2">
                    </div>
                    <h5 class="pubtitle">确认密码</h5>
                    <div class="pub-txt-bar">
                        <input type="password" pattern="^[\u4E00-\u9FA5A-Za-z0-9_]{6,}$" required="required" oninvalid="setCustomValidity('请输入正确密码格式')"
                               oninput="setCustomValidity('')" id="rnew_pwd" class="shuruTxt shuruTxt2">
                    </div>
                    <div class="pub-btn">
                        <input type="submit" value="确定" onclick="return checkpwd();" class="saveBtn">
                        <input type="reset"  value="重置" class="resetBtn">
                    </div>
                    <c:if test="${status != null}">
                        <b class="error"></b><div class="errorBox">${status}</div>
                    </c:if>
                </div>

            </form>

        </div>

    </div>
    <!--main-->

</div>
<!--content E-->

</body></html>

