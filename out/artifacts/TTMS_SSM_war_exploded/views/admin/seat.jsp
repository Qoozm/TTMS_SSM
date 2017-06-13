<%@page import="se.ttms.model.Seat" %>
<%@ page import="se.ttms.model.Studio" %>
<%@ page import="java.util.ArrayList" %>
<%@ page language="java" contentType="text/html; charset=UTF-8"
         pageEncoding="UTF-8" %>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width; initial-scale=1.0">
    <title>座位管理</title>

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
        var url = "/seatModify?";
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
                    if (str == "yes") {
                        alert("更新成功")
                    } else {
                        alert("更新失败")
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

</head>

<body class="body">

<div id="main">
    <div class="demo">
        <h1 style="margin: 0px 0px 10px 45px">请点击座位进行编辑</h1>
        <div id="seat-map" class="seatCharts-container">
            <div class="front">屏幕</div>
            <%
                ArrayList<Seat> seatList = (ArrayList<Seat>) request.getAttribute("list");
                Studio studio = (Studio) request.getAttribute("studio");
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
                    if (seatList.get((i - 1) * col_count + j - 1).getSeatStatus() == 1) {
            %>
            <img id="<%=i+"_"+j%>" src="/static/images/seatgood.png" onclick="changeImg(this.id)">
            <span>&nbsp;</span>
            <% } else {
            %>
            <img id="<%=i +"_"+ j %>" src="/static/images/seatbad.png" onclick="changeImg(this.id)">
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
            <p>演出厅状态：
                <span>
			<%
                if (((Studio) request.getAttribute("studio")) == null) {
                    out.print("请选择演出厅");
                } else if (((Studio) request.getAttribute("studio")).getStudioFlag() == 1)
                    out.print("演出厅正常");
                else
                    out.print("演出厅损坏");
            %>
			</span>
            </p>
            <br/>
            <span>座位完好：&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span><img alt="座位"
                                                                                   src="/static/images/seatgood.png">
            <br/><br/>
            <span>座位损坏：&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;&nbsp;</span><img alt="座位"
                                                                                   src="/static/images/seatbad.png">
            <br/><br/>

            <button type="submit" onclick="updateClick()" class="layui-Btn" style="margin-left:0%; width:90px; height:24px; line-height:20px;border:1px solid #999;font-size: 14px; cursor:pointer;">
                确定修改
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

</body>
</html>