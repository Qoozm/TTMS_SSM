<%@ page import="com.github.pagehelper.PageInfo" %>
<%@ page import="se.ttms.model.DataDict" %>
<%@ page import="se.ttms.model.Play" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.HashMap" %><%--
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
    <title>影片列表</title>
    <link rel="stylesheet" href="/static/css/base.css" type="text/css">
    <link rel="stylesheet" href="/static/css/page.css" type="text/css">


    <!--[if lte IE 8]>
    <link href="static/css/ie8.css" rel="stylesheet" type="text/css"/>
    <![endif]-->
    <script type="text/javascript" src="/static/js/jquery.min.js"></script>
    <script type="text/javascript" src="/static/js/main.js"></script>
    <script type="text/javascript" src="/static/js/modernizr.js"></script>
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

        function initPlay(playId) {

            var play = document.getElementById(playId);
            var data = document.getElementById("modifyPlayForm");
            for (var i = 0; i < play.cells.length - 2; ++i) {
                var tmp = play.cells[i].innerHTML.trim();
                if (i == 7 || i == 2 || i== 3) {
                    var playStatus = data.elements[i].options;
                    for (var j = 0; j < playStatus.length; j++) {
                        if (playStatus[j].innerHTML == tmp) {
                            playStatus[j].selected = true;
                            break;
                        }
                    }
                }
                else {
                    data.elements[i].value = tmp;
                }
            }
            document.getElementById("mimage").src = play.cells[9].innerHTML.trim();
        }

        var reqLang;
        function getLang() {

            getType();
            var url = "/playLang";
            if (window.XMLHttpRequest) {
                reqLang = new XMLHttpRequest();
            }
            else if (window.ActiveXObject) {
                reqLang = new ActiveXObject("Microsoft.XMLHTTP");
            }
            if (reqLang) {
                reqLang.open("post", url, true);
                reqLang.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
                reqLang.onreadystatechange = completeLang;
                reqLang.send();
            }
        }
        
        function completeLang() {

            if (reqLang.readyState == 4 && reqLang.status == 200) {

                var langs = eval("(" + reqLang.responseText + ")");
                var langId;
                var langValue;
                var mlangSelect = document.getElementById("mLang");
                var alangSelect = document.getElementById("aLang");
                for (var i = 0; i < langs   .length; ++i) {
                    langId = langs[i].langId;
                    langValue = langs[i].langValue;
                    mlangSelect.options[mlangSelect.options.length] = new Option(langValue, langId);
                    alangSelect.options[alangSelect.options.length] = new Option(langValue, langId);
                }
            }
        }

        var reqType;
        function getType() {

            var url = "/playType";
            if (window.XMLHttpRequest) {
                reqType = new XMLHttpRequest();
            }
            else if (window.ActiveXObject) {
                reqType = new ActiveXObject("Microsoft.XMLHTTP");
            }
            if (reqType) {
                reqType.open("post", url, true);
                reqType.setRequestHeader("Content-Type","application/x-www-form-urlencoded");
                reqType.onreadystatechange = completeType;
                reqType.send();
            }
        }

        function completeType() {

            if (reqType.readyState == 4 && reqType.status == 200) {

                var types = eval("(" + reqType.responseText + ")");
                var typeId;
                var typeValue;
                var mtypeSelect = document.getElementById("mType");
                var atypeSelect = document.getElementById("aType");
                for (var i = 0; i < types.length; ++i) {
                    typeId = types[i].typeId;
                    typeValue = types[i].typeValue;
                    mtypeSelect.options[mtypeSelect.options.length] = new Option(typeValue, typeId);
                    atypeSelect.options[atypeSelect.options.length] = new Option(typeValue, typeId);
                }
            }
        }

    </script>
</head>

<body style="background: #f6f5fa;"  onload="getLang()">

<!--content S-->
<div class="super-content RightMain" id="RightMain">

    <!--header-->
    <div class="ctab-title clearfix"><h3>影片列表</h3>
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
                    <a href="javascript:;" class="greenbtn add sp-add">添加影片</a>
                    <%--<a href="javascript:;" class="greenbtn add sp-photo" id="preview">栏目图片</a>--%>
                    <%--<a href="javascript:;" class="modify sp-modify" id="sp-modify">修改</a>--%>
                </div>

                <div class="searchBar">
                    <input type="text" id="playName" name="playName" value="" class="form-control srhTxt" placeholder="输入影片名称搜索">
                    <input type="button" height="20" class="srhBtn" value="" onclick="searchByPlayName()">
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
                            <th class="t_1">影片ID</th>
                            <th class="t_2">影片名称</th>
                            <th class="t_3">影片类型</th>
                            <th class="t_4">语  言</th>
                            <th class="t_5">影片介绍</th>
                            <th class="t_6">影片时长</th>
                            <th class="t_7">建议售价</th>
                            <th class="t_8">上架状态</th>
                            <th class="t_9">操  作</th>
                            <th hidden></th>
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
                        ArrayList<Play> plays = (ArrayList<Play>) request.getAttribute("plays");
                        HashMap<Integer, DataDict> dictMap = (HashMap<Integer, DataDict>) request.getAttribute("dictMap");

                        for (Play play : plays) {

                    %>
                    <tr id="<%=play.getId()%>">
                        <td class="t_1"><%=play.getId()%>
                        </td>
                        <td class="t_2"><%=play.getName()%>
                        </td>
                        <td class="t_3"><%=dictMap.get(play.getTypeId()).getValue()%>
                        </td>
                        <td class="t_4"><%=dictMap.get(play.getLangId()).getValue()%>
                        </td>
                        <td class="t_5"><%=play.getIntroduction()%>
                        </td>
                        <td class="t_6"><%=play.getLength()%>
                        </td>
                        <td class="t_7"><%=play.getTicketPrice()%>
                        </td>
                        <%
                            int status = play.getStatus();
                            if (status == 0)  {
                        %>
                        <td class="t_8">待安排演出
                        </td>
                        <%
                            }
                            else if (status == 1) {
                        %>
                        <td class="t_8">已安排演出
                        </td>
                        <%
                            }
                            else {
                        %>
                        <td class="t_8">已下线
                        </td>
                        <%
                            }
                        %>
                        <td class="t_9">
                            <div class="btn"><%--<a class="Top">置顶</a>--%>
                                <a href="javascript:;" class="modify sp-modify" id="sp-modify" onclick="initPlay(<%=play.getId()%>)">修改</a>
                                <a href="/playDelete?playId=<%=play.getId()%> " class="delete">删除</a>
                            </div>
                        </td>
                        <td hidden><%=play.getImage()%></td>
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
                        <a class="pagenumb" href="/findPlayByPage?currentPage=1">首页</a>
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
                        <a class="pagePre" href="/findPlayByPage?currentPage=${pageInfo.pageNum - 1}"><i
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
                        <a href="/findPlayByPage?currentPage=<%=num%>" class="pagenumb cur"><%=num%></a>
                        <%
                        } else {
                        %>
                        <a href="/findPlayByPage?currentPage=<%=num%>" class="pagenumb"><%=num%></a>
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
                        <a class="pagenext" href="/findPlayByPage?currentPage=${pageInfo.pageNum + 1}"><i
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
                        <a class="pagenumb" href="/findPlayByPage?currentPage=${pageInfo.pages}">尾页</a>
                        <%
                            }
                        %>


                    </div>
                </div>
                <c:if test="${tip != null}">
                    <i class="ico-error"></i>
                        <span class="errorword">${tip}</span>
                </c:if>
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
    <form id="modifyPlayForm" name="modifyPlayForm" action="/playModify" enctype="multipart/form-data" method="post" autocomplete="off">
        <div class="layer-title clearfix"><h2>修改影片信息</h2><span class="layerClose"></span></div>
        <table width="500">
            <tr>
                <td width="350">
                    <div class="layer-content">
                        <div><input type="text" name="id" value="" hidden></div>
                        <div class="aFllink clearfix"><span>影片名称：</span><input required lay-verify="required" autofocus autocomplete="off"  name="name"  type="text" value="" pattern="^*{1,30}$"  oninvalid="setCustomValidity('请输入影片名称!')" oninput="setCustomValidity('')"> </div>
                        <div class="aFllink clearfix"><span>影片类型：</span>
                            <select id="mType" name = "typeId" style="width: 225px; height: 25px" required lay-verify="required">
                            </select>
                        </div>
                        <div class="aFllink clearfix"><span>影片语言：</span>
                            <select id="mLang" name = "langId" style="width: 225px; height: 25px" required lay-verify="required">
                            </select></div>
                        <div class="aFllink clearfix"><span>影片介绍：</span></div>
                        <div class="aFllink clearfix"><textarea name="introduction" cols="10" rows="1" style="margin: 1px; width: 312px; height: 80px;
                                wrap-option: physical; line-height: 2.0; border: 1px solid #cdcdcd;resize: none" ></textarea></div>
                        <div class="aFllink clearfix"><span>影片时长：</span><input autocomplete="off"  required lay-verify="required" pattern="^(1|2)([0-9]){2}$"  oninvalid="setCustomValidity('请输入影片时长(100~299)')" oninput="setCustomValidity('')" type="text" name="length" value=""></div>
                        <div class="aFllink clearfix"><span>建议售价：</span><input type="text" autocomplete="off"  required lay-verify="required" pattern="^[0-9]+(\.[0-9]{1})?$"  oninvalid="setCustomValidity('请输入建议售价(0~120RMB)')" oninput="setCustomValidity('')" name="ticketPrice" value=""></div>
                        <div class="aFllink clearfix"><span>上架状态：</span> <select id = "mPlayStatus" style="width: 225px; height: 25px" name="status" required lay-verify="required">
                            <option value="0">待安排演出</option>
                            <option value="1">已安排演出</option>
                            <option value="-1">已下线</option>
                        </select>
                        </div>
                        <div class="aFlBtn"><input type="submit" lay-submit value="保存" class="layui-Btn"></div>
                    </div>
                </td>
                <td width="150">
                    <div class="subxc-list">
                        <div class="img" ><img style="background-size: contain; background-repeat: no-repeat; background-position: center center" id="mimage" src=""><div class="bg" style="display: none;"><input autocomplete="off" type="file" id="mImageFile" accept="image/png,image/gif,image/jpeg" name="playImage" value="上传"></div></div>
                        <p>影片海报</p>
                        <p id="test-file-info" hidden></p>
                    </div>
                </td>
            </tr>
        </table>
    </form>
</div>
<!--点击添加分类弹出-->
<div class="addFeileibox layuiBox">
    <form action="/playAdd" method="post" autocomplete="off" enctype="multipart/form-data" commandName="play">
        <div class="layer-title clearfix"><h2>添加影片</h2><span class="layerClose"></span></div>
        <table width="500">
            <tr>
                <td width="350">
                    <div class="layer-content">
                        <div class="aFllink clearfix"><span>影片名称：</span><input required lay-verify="required" autofocus autocomplete="off"  name="name" id="mName" type="text" value="" pattern="^*{1,30}$"  oninvalid="setCustomValidity('请输入影片名称!')" oninput="setCustomValidity('')"> </div>
                        <div class="aFllink clearfix"><span>影片类型：</span>
                            <select id="aType" name = "typeId" style="width: 225px; height: 25px" required lay-verify="required">
                            </select>
                        </div>
                        <div class="aFllink clearfix"><span>影片语言：</span>
                            <select id="aLang" name = "langId" style="width: 225px; height: 25px" required lay-verify="required">
                            </select></div>
                        <div class="aFllink clearfix"><span>影片介绍：</span></div>
                        <div class="aFllink clearfix"><textarea name="introduction" id="" cols="10" rows="1" style="margin: 1px; width: 312px; height: 80px;
                                wrap-option: physical; line-height: 2.0; border: 1px solid #cdcdcd;resize: none" ></textarea></div>
                        <div class="aFllink clearfix"><span>影片时长：</span><input autocomplete="off"  required lay-verify="required" pattern="^(1|2)([0-9]){2}$"  oninvalid="setCustomValidity('请输入影片时长(100~299)')" oninput="setCustomValidity('')" type="text" name="length" id="mLength" value=""></div>
                        <div class="aFllink clearfix"><span>建议售价：</span><input type="text" autocomplete="off"  required lay-verify="required" pattern="^[0-9]+(\.[0-9]{1})?$"  oninvalid="setCustomValidity('请输入建议售价(0~120RMB)')" oninput="setCustomValidity('')" name="ticketPrice" id="mTicketPrice" value=""></div>
                        <div class="aFllink clearfix"><span>上架状态：</span> <select style="width: 225px; height: 25px" name="status" required lay-verify="required">
                            <option selected value="0">待安排演出</option>
                            <option value="1">已安排演出</option>
                            <option value="-1">已下线</option>
                        </select>
                        </div>
                        <div class="aFlBtn"><input type="submit" lay-submit value="保存" class="layui-Btn"></div>
                    </div>
                </td>
                <td width="150">
                    <div class="subxc-list">
                        <div class="img"><img style="background-size: contain; background-repeat: no-repeat; background-position: center center" id="aimage" src=""><div class="bg" style="display: none;"><input autocomplete="off" type="file" id="aImageFile" accept="image/png,image/gif,image/jpeg" name="playImage" value="上传"></div></div>
                        <p>影片海报</p>
                        <p id="addimageinfo" hidden></p>
                    </div>
                </td>
            </tr>
        </table>
    </form>
</div>



<script type="text/javascript" src="/static/js/zxxFile.js"></script>
<script>

    var
        fileInput = document.getElementById('mImageFile'),
        info = document.getElementById('test-file-info'),
        preview = document.getElementById('mimage');
    // 监听change事件:
    fileInput.addEventListener('change', function () {
        // 清除背景图片:
        preview.src = '';
        // 检查文件是否选择:
        if (!fileInput.value) {
            info.innerHTML = '没有选择文件';
            return;
        }
        // 获取File引用:
        var file = fileInput.files[0];
        // 获取File信息:
        info.innerHTML = '文件: ' + file.name + '<br>' +
            '大小: ' + file.size + '<br>' +
            '修改: ' + file.lastModifiedDate;
        if (file.type !== 'image/jpeg' && file.type !== 'image/png' && file.type !== 'image/gif') {
            alert('不是有效的图片文件!');
            return;
        }
        // 读取文件:
        var reader = new FileReader();
        reader.onload = function(e) {
            var
                data = e.target.result; // 'data:image/jpeg;base64,/9j/4AAQSk...(base64编码)...'
            preview.style.backgroundImage = 'url(' + data + ')';
        };
        // 以DataURL的形式读取文件:
        reader.readAsDataURL(file);
    });

    var
        afileInput = document.getElementById('aImageFile'),
        ainfo = document.getElementById('test-file-info'),
        apreview = document.getElementById('aimage');
    // 监听change事件:
    afileInput.addEventListener('change', function () {
        // 清除背景图片:
        apreview.src = '';
        // 检查文件是否选择:
        if (!afileInput.value) {
            ainfo.innerHTML = '没有选择文件';
            return;
        }
        // 获取File引用:
        var file = afileInput.files[0];
        // 获取File信息:
        ainfo.innerHTML = '文件: ' + file.name + '<br>' +
            '大小: ' + file.size + '<br>' +
            '修改: ' + file.lastModifiedDate;
        if (file.type !== 'image/jpeg' && file.type !== 'image/png' && file.type !== 'image/gif') {
            alert('不是有效的图片文件!');
            return;
        }
        // 读取文件:
        var reader = new FileReader();
        reader.onload = function(e) {
            var
                data = e.target.result;
            apreview.style.backgroundImage = 'url(' + data + ')';
        };
        // 以DataURL的形式读取文件:
        reader.readAsDataURL(file);
    });

</script>

</body>
</html>
