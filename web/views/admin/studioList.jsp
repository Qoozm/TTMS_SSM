<%@ page import="com.github.pagehelper.PageInfo" %>
<%@ page import="se.ttms.model.Studio" %>
<%@ page import="java.util.ArrayList" %>
<%--
  Created by IntelliJ IDEA.
  User: Charley
  Date: 2017/6/5
  Time: 16:12
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
    <title>演出厅列表</title>
    <link rel="stylesheet" href="../../static/css/base.css" type="text/css">
    <link rel="stylesheet" href="../../static/css/page.css" type="text/css">


    <!--[if lte IE 8]>
    <link href="static/css/ie8.css" rel="stylesheet" type="text/css"/>
    <![endif]-->
    <script type="text/javascript" src="../../static/js/jquery.min.js"></script>
    <script type="text/javascript" src="../../static/js/main.js"></script>
    <script type="text/javascript" src="../../static/js/modernizr.js"></script>
    <!--[if IE]>
    <script src="http://libs.useso.com/js/html5shiv/3.7/html5shiv.min.js"></script>
    <![endif]-->

    <style type="text/css">
        <!--
        .defaultTable .t_1 {
            width: 10%;
            text-align: center;
            padding-left: 1%;
            position: relative;
        }

        .defaultTable .t_2 {
            width: 10%;
            text-align: center;
        }

        .defaultTable .t_3 {
            width: 10%;
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
            width: 10%;
            text-align: center;
        }

        .defaultTable .t_9 {
            width: 20%;
            text-align: center;
        }

        .searchBar .srhTxt {
            border: 1px solid #d8d8d8;
            height: 35px;
            padding: 6px 34px 6px 6px;
            width: 207px;
        }

        .addFeileibox { width: 500px;}

        .imgXgbox {
            width: 500px;
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

        function searchByStudioName() {

            var studioName = document.getElementById("studioName").value;
            window.location.href = "/searchByStudioName?studioName=" + studioName;
        }

        function initStudio(studioId) {

            var studio = document.getElementById(studioId);
            var data = document.getElementById("modifyStudioForm");
            for (var i = 0; i < studio.cells.length - 1; ++i) {
                var tmp = studio.cells[i].innerHTML.trim();
                if (i == 5) {
                    var studioStaus = data.elements[i].options;
                    for (var j = 0; j < studioStaus.length; j++) {
                        if (studioStaus[j].innerHTML == tmp) {
                            studioStaus[j].selected = true;
                            break;
                        }
                    }
                }
                else {
                    data.elements[i].value = tmp;
                }
            }
        }

    </script>
</head>

<body style="background: #f6f5fa;"  onload="getLang()">

<!--content S-->
<div class="super-content RightMain" id="RightMain">

    <!--header-->
    <div class="ctab-title clearfix"><h3>演出厅列表</h3>
        <!--<a href="javascript:;" class="sp-column"><i class="ico-mng"></i>栏目管理</a>--></div>
    <div class="superCtab">

        <%--<div class="ctab-Main">
            <div class="ctab-Main-title">
                <ul class="clearfix">
                    <li class="cur"><a href="wenzhang_xinwen.html">新闻动态</a></li>
                    <li><a href="wenzhang_pinshang.html">品尚生活</a></li>
                    <li><a href="wenzhang_zhuoyue.html">卓越联盟</a></li>
                    <li><a href="wenzhang_zhaoxian.html">招贤纳士</a></li>
                    <li><a href="wenzhang_kehu.html">客户见证</a></li>
                    <li><a href="wenzhang_remen.html">热门产品</a></li>
                    <li><a href="wenzhang_aboutus.html">关于我们</a></li>
                    <li><a href="wenzhang_lianxi.html">联系方式</a></li>
                </ul>
            </div>--%>

        <div class="ctab-Mian-cont">
            <div class="Mian-cont-btn clearfix">
                <div class="operateBtn">
                    <%--<a href="wenzhang_xinwen_fabu.html" class="greenbtn publish">发布文章</a>--%>
                    <a href="javascript:;" class="greenbtn add sp-add">添加演出厅</a>
                    <%--<a href="javascript:;" class="greenbtn add sp-photo" id="preview">栏目图片</a>--%>
                    <%--<a href="javascript:;" class="modify sp-modify" id="sp-modify">修改</a>--%>
                </div>

                <div class="searchBar">
                    <input type="text" id="studioName" value="" class="form-control srhTxt" placeholder="输入演出厅名称搜索">
                    <input type="button" height="20" class="srhBtn" value="" onclick="searchByStudioName()">
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
                            <th class="t_1">演出厅ID</th>
                            <th class="t_2">演出厅名称</th>
                            <th class="t_3">座位行数</th>
                            <th class="t_4">座位列数</th>
                            <th class="t_5">演出厅介绍</th>
                            <th class="t_6">演出厅状态</th>
                            <th class="t_9">操  作</th>
                        </tr>
                        </tbody>
                    </table>
                </div>
                <table border="0" cellspacing="0" cellpadding="0" class="defaultTable defaultTable2">
                    <tbody>
                    <%
                        PageInfo pageInfo = (PageInfo) request.getAttribute("pageInfo");
                        ArrayList<Studio> studios = (ArrayList<Studio>) request.getAttribute("studios");

                        for (Studio studio : studios) {

                    %>
                    <tr id="<%=studio.getID()%>">
                        <td class="t_1"><%=studio.getID()%>
                        </td>
                        <td class="t_2"><%=studio.getName()%>
                        </td>
                        <td class="t_3"><%=studio.getRowCount()%>
                        </td>
                        <td class="t_4"><%=studio.getColCount()%>
                        </td>
                        <td class="t_5"><%=studio.getIntroduction()%>
                        </td>
                        <%
                            int status = studio.getStudioFlag();
                            if (status == 0)  {
                        %>
                            <td class="t_8">座位损坏不能用
                            </td>
                        <%
                        } else if (status == 1) {%>
                            <td class="t_8">座位可用
                            </td>
                        <%
                        }
                            else {
                        %>
                            <td class="t_8">演出厅未生成
                            </td>
                        <%
                            }
                        %>
                        <td class="t_9">
                            <div class="btn"><%--<a class="Top">置顶</a>--%>
                                <a href="javascript:;" class="modify sp-modify" id="sp-modify" onclick="initStudio(<%=studio.getID()%>)">修改</a>
                                <a href="/studioDelete?studioId=<%=studio.getID()%> " class="delete">删除</a>
                                <a href="/searchSeatByStudioId?studioId=<%=studio.getID()%>&currentPage=${pageInfo.pageNum}" class="export-a">座位管理</a>
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
                    <%
                        pageInfo = (PageInfo) request.getAttribute("pageInfo");
                    %>
                    <span>共 <b><%=pageInfo.getTotal()%></b> 条  每页 <b><%=pageInfo.getSize()%></b> 条   共<b><%=pageInfo.getPages()%></b>页</span>
                    <div class="pageWrap">
                        <%--首页--%>
                        <%
                            if (pageInfo.getPageNum() == 1) {

                        %>
                        <a class="pagenumb" href="#">首页</a>
                        <%
                        } else {
                        %>
                        <a class="pagenumb" href="/findStudioByPage?currentPage=1">首页</a>
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
                        <a class="pagePre" href="/findStudioByPage?currentPage=${pageInfo.pageNum - 1}"><i
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
                        <a href="/findStudioByPage?currentPage=<%=num%>" class="pagenumb cur"><%=num%></a>
                        <%
                        } else {
                        %>
                        <a href="/findStudioByPage?currentPage=<%=num%>" class="pagenumb"><%=num%></a>
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
                        <a class="pagenext" href="/findStudioByPage?currentPage=${pageInfo.pageNum + 1}"><i
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
                        <a class="pagenumb" href="/findStudioByPage?currentPage=${pageInfo.pages}">尾页</a>
                        <%
                            }
                        %>
                    </div>
                </div>
            <c:if test="${tip != null}">
                    <i class="ico-error"></i>
                    <span class="errorword">${tip}</span>
            </c:if>
            </div>

                <!--pages E-->
            </div>

        </div>
    </div>
</div>
<!--main-->

</div>
<!--content E-->

<div class="layuiBg" ></div><!--公共遮罩-->
<!--点击修改弹出层-->
<div class="imgXgbox layuiBox">
    <form id="modifyStudioForm" action="/studioModify" method="post" autocomplete="off">
        <div class="layer-title clearfix"><h2>修改演出厅信息</h2><span class="layerClose"></span></div>
        <table width="500">
            <tr>
                <td width="350">
                    <div class="layer-content">
                        <div><input type="hidden" value="1" name="id"></div>
                        <div class="aFllink clearfix"><span>演出厅名称：</span><input required lay-verify="required" autofocus autocomplete="off"  name="name" type="text" value="" pattern="^*{1,30}$"  oninvalid="setCustomValidity('请输入影片名称!')" oninput="setCustomValidity('')"> </div>
                        <div class="aFllink clearfix"><span>座位总行数：</span><input required lay-verify="required" autofocus autocomplete="off"  name="rowCount" type="text" value="" pattern="^([1-9]|10){1}$"  oninvalid="setCustomValidity('请输入座位行数(1-10)!')" oninput="setCustomValidity('')"> </div>
                        <div class="aFllink clearfix"><span>座位总行数：</span><input required lay-verify="required" autofocus autocomplete="off"  name="colCount" type="text" value="" pattern="^([1-9]|10){1}$"  oninvalid="setCustomValidity('请输入座位列数(1-10)!')" oninput="setCustomValidity('')"> </div>
                        <div class="aFllink clearfix"><span>演出厅介绍：</span></div>
                        <div class="aFllink clearfix"><textarea name="introduction" cols="10" rows="1" style="margin: 1px; width: 312px; height: 80px;
                                wrap-option: physical; line-height: 2.0; border: 1px solid #cdcdcd;resize: none" ></textarea></div>

                        <div class="aFllink clearfix"><span>演出厅状态：</span>
                            <select style="font-size: 10px; width: 225px; height: 25px" name="studioFlag" required lay-verify="required">
                                <option selected value="0">座位损坏不能用</option>
                                <option value="1">座位可用</option>
                                <option value="-1">演出厅未生成</option>
                            </select>
                        </div>

                        <div class="aFlBtn"><input type="submit" lay-submit value="保存" class="layui-Btn"></div>
                    </div>
                </td>
            </tr>
        </table>
    </form>
</div>
<!--点击添加分类弹出-->
<div class="addFeileibox layuiBox">
    <form action="/studioAdd" method="post" autocomplete="off">
        <div class="layer-title clearfix"><h2>添加演出厅</h2><span class="layerClose"></span></div>
        <table width="500">
            <tr>
                <td width="350">
                    <div class="layer-content">
                        <div class="aFllink clearfix"><span>演出厅名称：</span><input required lay-verify="required" autofocus autocomplete="off"  name="name" type="text" value="" pattern="^*{1,30}$"  oninvalid="setCustomValidity('请输入影片名称!')" oninput="setCustomValidity('')"> </div>
                        <div class="aFllink clearfix"><span>座位总行数：</span><input required lay-verify="required" autofocus autocomplete="off"  name="rowCount" type="text" value="" pattern="^([1-9]|10){1}$"  oninvalid="setCustomValidity('请输入座位行数(1-10)!')" oninput="setCustomValidity('')"> </div>
                        <div class="aFllink clearfix"><span>座位总行数：</span><input required lay-verify="required" autofocus autocomplete="off"  name="colCount" type="text" value="" pattern="^([1-9]|10){1}$"  oninvalid="setCustomValidity('请输入座位列数(1-10)!')" oninput="setCustomValidity('')"> </div>
                        <div class="aFllink clearfix"><span>演出厅介绍：</span></div>
                        <div class="aFllink clearfix"><textarea name="introduction" id="" cols="10" rows="1" style="margin: 1px; width: 312px; height: 80px;
                                wrap-option: physical; line-height: 2.0; border: 1px solid #cdcdcd;resize: none" ></textarea></div>

                        <div class="aFllink clearfix"><span>演出厅状态：</span>
                            <select style="font-size: 10px; width: 225px; height: 25px" name="studioFlag" required lay-verify="required">
                                <option selected value="0">座位损坏不能用</option>
                                <option value="1">座位可用</option>
                                <option value="-1">演出厅未生成</option>
                            </select>
                        </div>

                        <div class="aFlBtn"><input type="submit" lay-submit value="保存" class="layui-Btn"></div>
                    </div>
                </td>
            </tr>
        </table>
    </form>
</div>

</body>
</html>
