<%@ page import="se.ttms.model.Seat" %>
<%@ page import="se.ttms.model.Studio" %>
<%@ page import="se.ttms.model.Ticket" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.HashMap" %>
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
    <title>选  座</title>
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



    <link href="/static/css/font-awesome.min.css" rel="stylesheet">
    <link href="/static/css/bootstrap.min.css" rel="stylesheet">
    <link href="/static/css/bootstrap-datetimepicker.min.css" rel="stylesheet">
    <link href="/static/css/flexslider.css" rel="stylesheet">
    <link href="/static/css/templatemo-style.css" rel="stylesheet">


    <!-- HTML5 shim and Respond.js for IE8 support of HTML5 elements and media queries -->
    <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
    <!--[if lt IE 9]>
    <!--<script src="https://oss.maxcdn.com/html5shiv/3.7.2/html5shiv.min.js"></script>-->
    <!--<script src="https://oss.maxcdn.com/respond/1.4.2/respond.min.js"></script>-->
    <![endif]-->

    <style type="text/css">
        .demo {
            width: 700px;
            margin: 40px auto 0 auto;
            min-height: 450px;
        }

        @media screen and (max-width: 360px) {
            .demo {
                width: 340px
            }
        }

        .front {
            width: 300px;
            margin: 5px 32px 45px 32px;
            background-color: #f0f0f0;
            color: #666;
            text-align: center;
            padding: 3px;
            border-radius: 5px;
        }

        .booking-details {
            float: right;
            position: relative;
            width: 200px;
            height: 450px;
        }

        .booking-details h3 {
            margin: 5px 5px 0 0;
            font-size: 16px;
        }

        .booking-details p {
            line-height: 26px;
            font-size: 16px;
            color: #999
        }

        .booking-details p span {
            color: #666
        }

        /*div.seatCharts-cell {color: #182C4E;height: 25px;width: 25px;line-height: 25px;margin: 3px;float: left;text-align: center;outline: none;font-size: 13px;}*/
        /*div.seatCharts-seat {color: #fff;cursor: pointer;-webkit-border-radius: 5px;-moz-border-radius: 5px;border-radius: 5px;}*/
        /*div.seatCharts-row {height: 35px;}*/
        /*div.seatCharts-seat.available {background-color: #B9DEA0;}*/
        /*div.seatCharts-seat.focused {background-color: #76B474;border: none;}*/
        /*div.seatCharts-seat.selected {background-color: #E6CAC4;}*/
        /*div.seatCharts-seat.unavailable {background-color: #472B34;cursor: not-allowed;}*/
        div.seatCharts-container {
            border-right: 1px dotted #adadad;
            width: 400px;
            padding: 20px;
            float: left;
        }

        /*div.seatCharts-legend {padding-left: 0px;position: absolute;bottom: 16px;}*/
        /*ul.seatCharts-legendList {padding-left: 0px;}*/
        /*.seatCharts-legendItem{float:left; width:90px;margin-top: 10px;line-height: 2;}*/
        /*span.seatCharts-legendDescription {margin-left: 5px;line-height: 30px;}*/
        /*#selected-seats {max-height: 150px;overflow-y: auto;width: 200px;}*/
        #selected-seats li {
            float: left;
            width: 72px;
            height: 26px;
            line-height: 26px;
            border: 1px solid #d3d3d3;
            background: #f7f7f7;
            margin: 6px;
            font-size: 14px;
            font-weight: bold;
            text-align: center
        }

        .body {
            background: url("/static/images/seat_bg.jpg");
            background-size: 100%;
            background-repeat: no-repeat;
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
    </style>

    <script type="text/javascript">
        var seat_id = 1;
        var url = "/pay?";
        var count = 1;
        function changeImg(id) {
            var imgName = document.getElementById(id).src;

            if (imgName == "http://localhost:8080/static/images/seatgood.png") {
                document.getElementById(id).src = "/static/images/seatbad.png";
                url = url + "&seat_id" + count + "=" + id + "_" + "0";
                count++;
            } else {
                document.getElementById(id).src = "/static/images/seatgood.png";
                url = url + "&seat_id" + count + "=" + id + "_" + "1";
                count++;
            }
        }

        function updateSeat() {
            if (window.XMLHttpRequest) {
                req = new XMLHttpRequest();
            } else if (window.ActiveXObject) {
                req = new ActiveXObject("Microsoft.XMLHTTP");
            }
            if (req) {
                req.open("get", url, true);
                req.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
                req.onreadystatechange = updateseatComplete;
                req.send(null);
            }
        }

        function updateseatComplete() {
            if (req.readyState == 4) {
                if (req.status == 200) {
                    var str = req.responseText;
                    if (str === "no") {
                        alert("购买失败")
                    } else {
                        alert(str)
                    }
                }
            }
        }

        function updateClick() {
            updateSeat();
        }

        function back() {
            <%
                session.removeAttribute("studio");
            %>
            window.history.back(-1);
        }
    </script>




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

<body  class="body">

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
    <div class="ctab-title clearfix"><h3>选择座位</h3>
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

                <div id="main">
                    <div class="demo">
                        <h1 style="margin: 0px 0px 10px 45px">请点击座位进行选座</h1>
                        <div id="seat-map" class="seatCharts-container">
                            <div class="front">屏幕</div>
                            <%
                                ArrayList<Seat> seatList = (ArrayList<Seat>) request.getAttribute("list");
                                Studio studio = (Studio) request.getAttribute("studio");
                                int seatFirstId = seatList.get(0).getId();
                                HashMap<Integer, Ticket> seatTickets = (HashMap<Integer, Ticket>) request.getAttribute("seatTickets");


                                float price = seatTickets.get(seatFirstId).getPrice();
                                session.setAttribute("seatTickets", seatTickets);
                                session.setAttribute("studio", studio);

                                if (request.getAttribute("list") != null && request.getAttribute("studio") != null) {
                                    int row_count = studio.getRowCount();
                                    int col_count = studio.getColCount();
                                    for (int i = 1; i <= row_count; i++) {
                            %>
                            <br/>
                            <span><%=i%><%
                                if (i < 10) out.print("&nbsp;&nbsp;&nbsp;");
                                else out.print("&nbsp;");
                            %></span>
                            <%
                                for (int j = 1; j <= col_count; j++) {
                                    if (seatTickets.get((i - 1) * col_count + j - 1 + seatFirstId).getStatus() != 9) {
                            %>
                            <img id="<%=i+"_"+j%>" src="/static/images/seatgood.png" onclick="changeImg(this.id)">
                            <span>&nbsp;</span>
                            <% } else {
                            %>
                            <img id="<%=i +"_"+ j %>" src="/static/images/seatbad.png" >
                            <span>&nbsp;</span>
                            <% }
                            }
                            }
                            }
                            %>
                        </div>
                        <div class="booking-details">
                            <br/>
                            <br/>
                            <br/>
                            <br/>
                            <br/>
                            <br/>
                            <p>演出厅：<span id="studioName"><%=studio.getName()%></span></p>
                            <br/>
                            <p>行　数：<span><%=studio.getRowCount()%>　行</span></p>
                            <br/>
                            <p>列　数：<span><%=studio.getColCount()%>　列</span></p>
                            <!-- 		<ul id="selected-seats"></ul> -->
                            <br/>
                            <p>票  价：
                                <span><%=price%></span>
                            </p>
                            <br/>
                            <span>未  售：&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span><img alt="座位"
                                                                                                   src="/static/images/seatgood.png">
                            <br/><br/>
                            <span>已  售：&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span><img alt="座位"
                                                                                                   src="/static/images/seatbad.png">
                            <br/><br/>

                            <button type="submit" onclick="updateClick()" class="layui-Btn" style="margin-left:0%; width:90px; height:24px; line-height:20px;border:1px solid #999;font-size: 14px; cursor:pointer;">
                                确定购买
                            </button>

                            <button id="backButton" onclick="back()" type="submit" class="layui-Btn" style="margin: auto; width:90px; height:24px; line-height:20px;border:1px solid #999;font-size: 14px; cursor:pointer;">
                                返回
                            </button>
                            <br/>
                            <div id="legend"></div>
                        </div>

                        <div style="clear:both"></div>

                    </div>
                </div>

            </div>

        </div>
    </div>
</div>
</body>
</html>