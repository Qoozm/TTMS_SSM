<%@ page import="com.github.pagehelper.PageInfo" %>
<%@ page import="se.ttms.model.Employee" %>
<%@ page import="se.ttms.model.Sale" %>
<%@ page import="java.util.ArrayList" %>
<%--
  Created by IntelliJ IDEA.
  User: Charley
  Date: 2017/6/7
  Time: 17:26
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib uri="http://java.sun.com/jsp/jstl/core" prefix="c" %>
<%@ page isELIgnored="false" %>
<html class=" js csstransforms3d">
<head>
    <meta charset="utf-8">
    <meta name="renderer" content="webkit">
    <meta http-equiv="X-UA-Compatible" content="IE=edge">
    <title>个人销售列表</title>
    <link rel="stylesheet" href="/static/css/base.css" type="text/css">
    <link rel="stylesheet" href="/static/css/page.css" type="text/css">


    <!--[if lte IE 8]>
    <link href="/static/css/ie8.css" rel="stylesheet" type="text/css"/>
    <![endif]-->
    <script type="text/javascript" src="/static/js/jquery.min.js"></script>
    <script type="text/javascript" src="/static/js/main.js"></script>
    <script type="text/javascript" src="/static/js/modernizr.js"></script>
    <!--[if IE]>
    <script src="http://libs.useso.com/js/html5shiv/3.7/html5shiv.min.js"></script>
    <![endif]-->

    <style type="text/css">
        <!--

        .defaultTable .t_2 {
            width: 10%;
            text-align: center;
        }

        .defaultTable .t_3 {
            width: 30%;
            text-align: center;
        }

        .defaultTable .t_4 {
            width: 10%;
            text-align: center;
        }

        .defaultTable .t_5 {
            width: 10%;
            text-align: center;
        }

        .defaultTable .t_6 {
            width: 10%;
            text-align: center;
            padding-left: 1%;
            position: relative;
        }

        .defaultTable .t_7 {
              width: 10%;
              text-align: center;
        }

        .defaultTable .t_8 {
            width: 20%;
            text-align: center;
        }


        .searchBar .srhTxt {
            border: 1px solid #d8d8d8;
            height: 35px;
            padding: 6px 34px 6px 6px;
            width: 207px;
        }

        .addFeileibox { width: 800px;}

        .imgXgbox {
            width: 800px;
        }

        .aFlBtn {
            margin: 3px 0 30px 200px;
        }

        input[type=text] {
            width: 150px;
            height: 23px;
            padding: 7px;
            border: 1px solid #cdcdcd;
        }

        .aFllink {
            margin: 5px 80px;
            line-height: 39px;
            font-size: 16px;
            color: #626262;
        }

        .layui-Btn {
            width: 117px;
            height: 42px;
            background: #00B38B;
            color: #fff;
            font-size: 16px;
            border-radius: 2px;
            -moz-border-radius: 2px;
            -webkit-border-radius: 2px;
        }

        .errorword {
            color: #FF0000;
        }

        -->
    </style>
    <script language="JavaScript">

        function searchByPlayName() {

            var playName = document.getElementById("playName").value;
            window.location.href = "/searchByPlayName?playName=" + playName;
        }

    </script>
</head>

<body style="background: #f6f5fa;">

<!--content S-->
<div class="super-content RightMain" id="RightMain">

    <div class="super-header clearfix">
        <h2>售票员后台界面</h2>
        <div class="head-right">
            <i class="ico-user"></i>当前用户：
            <div class="userslideDown">
                <a href="javascript:;" class="superUser">${employee.name}<i class="ico-tri"></i></a>
                <div class="slidedownBox">
                    <ul>
                        <li><a href="/views/common/change_pwd.jsp">修改密码</a></li>
                        <li><a href="/logout">退出</a></li>
                    </ul>
                </div>
            </div>
        </div>
    </div>


    <!--header-->
    <div class="ctab-title clearfix"><h3>个人销售表单</h3>
        <!--<a href="javascript:;" class="sp-column"><i class="ico-mng"></i>栏目管理</a>--></div>
    <div class="superCtab">


        <div class="ctab-Mian-cont">
            <div class="Mian-cont-btn clearfix">
                <div class="operateBtn">
                    <%--<a href="wenzhang_xinwen_fabu.html" class="greenbtn publish">发布文章</a>--%>
                    <%--<a href="javascript:;" class="greenbtn add sp-add">添加影片</a>--%>
                    <%--<a href="javascript:;" class="greenbtn add sp-photo" id="preview">栏目图片</a>--%>
                    <%--<a href="javascript:;" class="modify sp-modify" id="sp-modify">修改</a>--%>
                </div>

                <div class="searchBar">
                    <%--<input type="text" id="playName" name="playName" value="" class="form-control srhTxt" placeholder="输入影片名称搜索">--%>
                    <%--<input type="button" height="20" class="srhBtn" value="" onclick="searchByPlayName()">--%>
                </div>
            </div>
            <!--<div class="super-label clearfix">
                <a href="wenzhang_xinwen.html#">行业新闻<em style="display: none;"></em></a><a href="wenzhang_xinwen.html#">保险常识<em style="display: none;"></em></a>
            </div>-->

            <div class="Mian-cont-wrap">
                <div class="defaultTab-T">
                    <table border="0" cellspacing="0" cellpadding="0" class="defaultTable">
                        <tbody>
                        <tr>
                            <th class="t_1" hidden>销售ID</th>
                            <th class="t_2">员工名称</th>
                            <th class="t_3">销售时间</th>
                            <th class="t_4">实付</th>
                            <th class="t_5">找零</th>
                            <th class="t_6">类型</th>
                            <th class="t_7">状态</th>
                            <th class="t_8">操作</th>
                        </tr>
                        </tbody>
                    </table>
                </div>
                <table border="0" cellspacing="0" cellpadding="0" class="defaultTable defaultTable2">
                    <tbody>
                    <%
                        PageInfo pageInfo = (PageInfo) request.getAttribute("pageInfo");
                        int currentPage = pageInfo.getPageNum();
                        int perPageCount = pageInfo.getPageSize();
                        int allPageCount = pageInfo.getPages();
                        ArrayList<Sale> sales = (ArrayList<Sale>) request.getAttribute("sales");
                        Employee employee = (Employee) request.getAttribute("employee");
                        for (Sale sale : sales) {

                    %>
                    <tr id="<%=sale.getId()%>">
                        <td class="t_1" hidden><%=sale.getId()%>
                        </td>
                        <td class="t_2"><%=employee.getName()%>
                        </td>
                        <td class="t_3"><%=sale.getTime()%>
                        </td>
                        <td class="t_4"><%=sale.getPayment()%>
                        </td>
                        <td class="t_5"><%=sale.getChange()%>
                        </td>

                        <c:choose>
                            <c:when test="<%=sale.getType() == 1%>">
                                <td class="t_6">销售单</td>
                            </c:when>
                            <c:otherwise>
                                <td class="t_6">退款单</td>
                            </c:otherwise>
                        </c:choose>

                        <c:choose>
                            <c:when test="<%=sale.getStatus() == 1%>">
                                <td class="t_7">已付款</td>
                            </c:when>
                            <c:otherwise>
                                <td class="t_7">待付款</td>
                            </c:otherwise>
                        </c:choose>

                        <td class="t_8">
                            <div class="btn"><%--<a class="Top">置顶</a>--%>
                                <a href="/findSaleItem?currentPage=1&saleId=<%=sale.getId()%>&backSalePage=<%=currentPage%>" class="modify sp-modify" <%--id="sp-modify"--%>>详情</a>
                            </div>
                        </td>
                    </tr>
                    <%
                        }
                    %>
                    </tbody>
                </table>
                <!--pages S-->
                <div class="pageSelect">
                    <span>共 <b><%=allPageCount%></b> 条 每页 <b><%=perPageCount%></b>条   <b><%=currentPage%></b>/<%=allPageCount%></span>
                    <div class="pageWrap">


                        <%--首页--%>
                        <%
                            if (pageInfo.getPageNum() == 1) {

                        %>
                        <a class="pagenumb" href="#">首页</a>
                        <%
                        } else {
                        %>
                        <a class="pagenumb" href="/findSaleByPage?currentPage=1">首页</a>
                        <%
                            }
                        %>
                        <%--上一页--%>
                        <%
                            if (pageInfo.getPageNum() == 1) {
                        %>
                        <a class="pagePre" href="#"><i class="ico-pre">&nbsp;</i></a>
                        <%
                        } else {
                        %>
                        <a class="pagePre" href="/findSaleByPage?currentPage=${pageInfo.pageNum - 1}"><i
                                class="ico-pre">&nbsp;</i></a>
                        <%
                            }
                        %>

                        <%
                            int[] nums = pageInfo.getNavigatepageNums();
                            for (int num : nums) {
                        %>
                        <%
                            if (num == pageInfo.getPageNum()) {
                        %>
                        <a href="/findSaleByPage?currentPage=<%=num%>" class="pagenumb cur"><%=num%></a>
                        <%
                        } else {
                        %>
                        <a href="/findSaleByPage?currentPage=<%=num%>" class="pagenumb"><%=num%></a>
                        <%
                                }
                            }
                        %>

                        <%--下一页--%>
                        <%
                            if (pageInfo.isIsLastPage()) {
                        %>
                        <a class="pagenext" href="#"><i class="ico-next">&nbsp;</i></a>
                        <%
                        } else {
                        %>
                        <a class="pagenext" href="/findSaleByPage?currentPage=${pageInfo.pageNum + 1}"><i
                                class="ico-next">&nbsp;</i></a>
                        <%
                            }
                        %>
                        <%--尾页--%>
                        <%
                            if (pageInfo.isIsLastPage()) {
                        %>
                        <a class="pagenumb" href="#">尾页</a>
                        <%
                        } else {
                        %>
                        <a class="pagenumb" href="/findSaleByPage?currentPage=${pageInfo.pages}">尾页</a>
                        <%
                            }
                        %>
                    </div>
                </div>
                <!--pages E-->
            </div>

        </div>
    </div>
</div>
</body>
</html>