<%--
  Created by IntelliJ IDEA.
  User: colin
  Date: 2017/6/4
  Time: 23:03
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<!--输出,条件,迭代标签库-->
<%@ page isELIgnored="false" %>
<!--支持EL表达式，不设的话，EL表达式不会解析-->
<html>
<head>
    <meta charset="UTF-8">
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>用户登录</title>
    <link rel="stylesheet" href="/static/css/base.css"/>
    <link rel="stylesheet" href="/static/css/login.css"/>
</head>
<body>
<script>if (window != top) top.location.href = location.href</script>
<div class="superlogin"></div>
<div class="loginBox">
    <div class="logo"><img src="/static/images/logo_login.png"/></div>
    <div class="loginMain">
        <div class="tabwrap">
            <form action="/index" method="post">
                <table border="0" cellspacing="0" cellpadding="0">
                    <tr>
                        <td class="title">用户名：</td>
                        <td><input type="text" class="form-control txt" value="${employee.no}" name="no"/></td>
                    </tr>
                    <tr>
                        <td class="title">密 码：</td>
                        <td><input type="password" class="form-control txt" value="${employee.password}" name="password"/></td>
                    </tr>
                    <tr>
                        <td class="title">验证码：</td>
                        <td><input type="text" class="form-control txt txt2" name="verificationCode"/><span class="yzm">

                        <img src="/verificationCode" onclick="location.href = '/login'"></span></td>
                    </tr>
                    <tr class="errortd">
                        <td>&nbsp;</td>
                        <c:if test="${info != null}">
                            <td><i class="ico-error"></i>
                                <span class="errorword">${info}</span></td>
                        </c:if>
                    </tr>
                    <tr>
                        <td>&nbsp;</td>
                        <td><input type="submit" class="loginbtn" value="登录"/><input type="reset"
                                                                                     class="resetbtn"
                                                                                     value="重置"/>
                        </td>
                    </tr>
                    <%--<tr>--%>
                        <%--<td>&nbsp;</td>--%>
                        <%--<td class="forgetpsw"><a href="login_forgetb.html">忘记密码？</a></td>--%>
                    <%--</tr>--%>
                </table>
            </form>
        </div>
    </div>
</div>
<div class="footer">Copyright © 2015-2016 uimaker All Rights Reserved.</div>
</body>
</html>
