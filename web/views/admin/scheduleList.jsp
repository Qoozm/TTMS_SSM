<%@ page import="com.github.pagehelper.PageInfo" %>
<%@ page import="se.ttms.model.Schedule" %>
<%@ page import="java.util.ArrayList" %>
<%@ page import="java.util.HashMap" %><%--
  Created by IntelliJ IDEA.
  User: Charley
  Date: 2017/6/5
  Time: 16:12
  To change this template use File | Settings | File Templates.
--%>
<%@ page contentType="text/html;charset=UTF-8" language="java" %>
<%@ taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core" %>
<%@ page isELIgnored="false" %>
<html class=" js csstransforms3d">
<head>
	<meta charset="utf-8">
	<meta name="renderer" content="webkit">
	<meta http-equiv="X-UA-Compatible" content="IE=edge">
	<title>演出计划列表</title>
	<link rel="stylesheet" href="../../../static/css/base.css">
	<link rel="stylesheet" href="../../../static/css/page.css">


	<!--[if lte IE 8]>
	<link href="static/css/ie8.css" rel="stylesheet" type="text/css"/>
	<![endif]-->
	<script type="text/javascript" src="http://www.uimaker.com/uploads/bs/bs27/js/jquery.min.js"></script>
	<script type="text/javascript" src="../../../static/js/main.js"></script>
	<script type="text/javascript" src="../../../static/js/datepicker/WdatePicker.js"></script>
	<script type="text/javascript" src="http://www.uimaker.com/uploads/bs/bs27/js/modernizr.js"></script>
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

		.addFeileibox {
			width: 600px;
		}

		.imgXgbox {
			width: 600px;
		}

		.aFlBtn {
			margin: 30px 0 30px 150px;
		}

		input[type=text] {
			width: 150px;
			height: 23px;
			padding: 7px;
			border: 1px solid #cdcdcd;
		}

		.aFllink {
			margin: 5px 100px;
			line-height: 39px;
			font-size: 16px;
			color: #626262;
		}

		.addFeileibox {
			width: 400px;
		}

		.layui-Btn {
			/*margin: 5px 350px;*/
			width: 117px;
			height: 42px;
			background: #00B38B;
			color: #fff;
			font-size: 16px;
			border-radius: 2px;
			-moz-border-radius: 2px;
			-webkit-border-radius: 2px;
		}

		-->
	</style>
	<script language="JavaScript">

        function searchScheduleByPlayName() {

            var playName = document.getElementById("playName").value;
            window.location.href = "/searchScheduleByPlayName?playName=" + playName + "";
        }
        var reqStudio;
        var reqPlay;
        var studioId;
        var playId;
        function initSchedule(scheduleId, stuId, pId) {

            studioId = stuId;
            playId = pId;


            var schedule = document.getElementById(scheduleId);
            var data = document.getElementById("modifyScheduleForm");
            for (var i = 0; i < schedule.cells.length - 1; ++i) {
                var tmp = schedule.cells[i].innerHTML.trim();
                data.elements[i].value = tmp;
            }
            getStudio();
            getPlay();
        }

        function getStudio() {

            var url = "/getStudioList";
            if (window.XMLHttpRequest) {
                reqStudio = new XMLHttpRequest();
            }
            else if (window.ActiveXObject) {
                reqStudio = new ActiveXObject("Microsoft.XMLHTTP");
            }
            if (reqStudio) {
                reqStudio.open("post", url, true);
                reqStudio.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
                reqStudio.onreadystatechange = completeGetStudio;
                reqStudio.send();
            }
        }

        function completeGetStudio() {

            if (reqStudio.readyState == 4 && reqStudio.status == 200) {
                var sutdios = eval("(" + reqStudio.responseText + ")");
                var langId;
                var langValue;
                var studioSelect = document.getElementById("studioSelect");
                for (var i = 0; i < sutdios.length; ++i) {
                    langId = sutdios[i].studioId;
                    langValue = sutdios[i].studioName;
                    studioSelect.options[studioSelect.options.length] = new Option(langValue, langId);
                    if (langId === studioId) {
                        studioSelect.options[studioSelect.options.length - 1].selected = true;
                    }
                }
            }
        }

        function getPlay() {

            var url = "/getPlayList";
            if (window.XMLHttpRequest) {
                reqPlay = new XMLHttpRequest();
            }
            else if (window.ActiveXObject) {
                reqPlay = new ActiveXObject("Microsoft.XMLHTTP");
            }
            if (reqPlay) {
                reqPlay.open("post", url, true);
                reqPlay.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
                reqPlay.onreadystatechange = completeGetPlay;
                reqPlay.send();
            }
        }

        function completeGetPlay() {

            if (reqPlay.readyState == 4 && reqPlay.status == 200) {
                var sutdios = eval("(" + reqPlay.responseText + ")");
                var playId1;
                var playValue;
                var playSelect = document.getElementById("playSelect");
                for (var i = 0; i < sutdios.length; ++i) {
                    playId1 = sutdios[i].playId;
                    playValue = sutdios[i].playName;
                    playSelect.options[playSelect.options.length] = new Option(playValue, playId1);
                    if (playId1 === playId) {
                        playSelect.options[playSelect.options.length - 1].selected = true;
                    }
                }
            }
        }

        function getStudio1() {

            var url = "/getStudioList";
            if (window.XMLHttpRequest) {
                reqStudio = new XMLHttpRequest();
            }
            else if (window.ActiveXObject) {
                reqStudio = new ActiveXObject("Microsoft.XMLHTTP");
            }
            if (reqStudio) {
                reqStudio.open("post", url, true);
                reqStudio.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
                reqStudio.onreadystatechange = completeGetStudio1;
                reqStudio.send();
            }
        }

        function completeGetStudio1() {

            if (reqStudio.readyState == 4 && reqStudio.status == 200) {
                var sutdios = eval("(" + reqStudio.responseText + ")");
                var langId;
                var langValue;
                var studioSelect = document.getElementById("studioSelect1");
                for (var i = 0; i < sutdios.length; ++i) {
                    langId = sutdios[i].studioId;
                    langValue = sutdios[i].studioName;
                    studioSelect.options[studioSelect.options.length] = new Option(langValue, langId);
                    if (langId === studioId) {
                        studioSelect.options[studioSelect.options.length - 1].selected = true;
                    }
                }
            }
        }

        function getPlay1() {
			getStudio1();
            var url = "/getPlayList";
            if (window.XMLHttpRequest) {
                reqPlay = new XMLHttpRequest();
            }
            else if (window.ActiveXObject) {
                reqPlay = new ActiveXObject("Microsoft.XMLHTTP");
            }
            if (reqPlay) {
                reqPlay.open("post", url, true);
                reqPlay.setRequestHeader("Content-Type", "application/x-www-form-urlencoded");
                reqPlay.onreadystatechange = completeGetPlay1;
                reqPlay.send();
            }
        }

        function completeGetPlay1() {

            if (reqPlay.readyState == 4 && reqPlay.status == 200) {
                var sutdios = eval("(" + reqPlay.responseText + ")");
                var playId1;
                var playValue;
                var playSelect = document.getElementById("playSelect1");
                for (var i = 0; i < sutdios.length; ++i) {
                    playId1 = sutdios[i].playId;
                    playValue = sutdios[i].playName;
                    playSelect.options[playSelect.options.length] = new Option(playValue, playId1);
                    if (playId1 === playId) {
                        playSelect.options[playSelect.options.length - 1].selected = true;
                    }
                }
            }
        }

	</script>
</head>

<body style="background: #f6f5fa;">

<!--content S-->
<div class="super-content RightMain" id="RightMain">

	<!--header-->
	<div class="ctab-title clearfix"><h3>演出计划列表</h3>
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
					<a href="javascript:;" onclick="getPlay1()" class="greenbtn add sp-add">添加计划</a>
					<%--<a href="javascript:;" class="greenbtn add sp-photo" id="preview">栏目图片</a>--%>
					<%--<a href="javascript:;" class="modify sp-modify" id="sp-modify">修改</a>--%>
				</div>
				<!--<div class="super-label clearfix">
								<a href="wenzhang_xinwen.html#">行业新闻<em style="display: none;"></em></a><a href="wenzhang_xinwen.html#">保险常识<em style="display: none;"></em></a>
							</div>-->
				<div class="searchBar">
					<input type="text" id="playName" name="employeeName" value="" class="form-control srhTxt"
						   placeholder="输入影片名称搜索">
					<input type="button" height="20" class="srhBtn" value="" onclick="searchScheduleByPlayName()">
				</div>
			</div>

			<div class="Mian-cont-wrap">
				<div class="defaultTab-T">
					<table border="0" cellspacing="0" cellpadding="0" class="defaultTable">
						<tbody>
						<tr>
							<th class="t_1">演出计划ID</th>
							<th class="t_2">演出厅名称</th>
							<th class="t_3">影片名称</th>
							<th class="t_4">放映时间</th>
							<th class="t_5">票　价</th>
							<%--<th class="t_6">家庭住址</th>--%>
							<%--<th class="t_7">员工类型</th>--%>
							<th class="t_9">操 作</th>
						</tr>
						</tbody>
					</table>
				</div>
				<table border="0" cellspacing="0" cellpadding="0" class="defaultTable defaultTable2">
					<tbody>
					<%
						ArrayList<Schedule> schedules = (ArrayList<Schedule>) request.getAttribute("schedules");
						HashMap<Integer, String> plays = (HashMap<Integer, String>) request.getAttribute("playsName");
						HashMap<Integer, String> studios = (HashMap<Integer, String>) request.getAttribute("studioNames");
						for (Schedule schedule : schedules) {
					%>
					<tr id="<%=schedule.getSched_id()%>">
						<td class="t_1"><%=schedule.getSched_id()%>
						</td>
						<td class="t_2"><%=studios.get(schedule.getStudio_id())%>
						</td>
						<td class="t_3"><%=plays.get(schedule.getPlay_id())%>
						</td>
						<td class="t_4"><%=schedule.getSched_time()%>
						</td>
						<td class="t_5"><%=schedule.getSched_ticket_price()%>
						</td>
						<%--<td class="t_6"><%=employee.getAddr()%>--%>
						<%--</td>--%>
						<%--<td class="t_7">--%>
						<%--<%--%>
						<%--if (employee.getAccess() == 1) {--%>
						<%--out.println("管理员");--%>
						<%--} else {--%>
						<%--out.println("售票员");--%>
						<%--}--%>
						<%--%>--%>
						<%--</td>--%>
						<td class="t_9">
							<div class="btn"><%--<a class="Top">置顶</a>--%>
								<a href="javascript:;" class="modify sp-modify" id="sp-modify"
								   onclick="initSchedule(<%=schedule.getSched_id()%>, <%=schedule.getStudio_id()%>, <%=schedule.getPlay_id()%>)">修改</a>
								<a href="/scheduleDelete?scheduleId=<%=schedule.getSched_id()%>" class="delete">删除</a>
							</div>
						</td>
					</tr>
					<%
						}
					%>
					</tbody>
				</table>
				<%--<!--pages S-->--%>
				<div class="pageSelect">
					<%
						PageInfo pageInfo = (PageInfo) request.getAttribute("pageInfo");
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
						<a class="pagenumb" href="/findEmployeeByPage?currentPage=1">首页</a>
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
						<a class="pagePre" href="/findEmployeeByPage?currentPage=${pageInfo.pageNum - 1}"><i
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
						<a href="/findEmployeeByPage?currentPage=<%=num%>" class="pagenumb cur"><%=num%>
						</a>
						<%
						} else {
						%>
						<a href="/findEmployeeByPage?currentPage=<%=num%>" class="pagenumb"><%=num%>
						</a>
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
						<a class="pagenext" href="/findEmployeeByPage?currentPage=${pageInfo.pageNum + 1}"><i
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
						<a class="pagenumb" href="/findEmployeeByPage?currentPage=${pageInfo.pages}">尾页</a>
						<%
							}
						%>
					</div>
				</div>
			</div>
		</div>
	</div>
</div>
<!--main-->

<!--content E-->

<div class="layuiBg"></div><!--公共遮罩-->
<!--点击修改弹出层-->
<div class="imgXgbox layuiBox">
	<form id="modifyScheduleForm" name="modifyScheduleForm" action="/scheduleModify" method="post" autocomplete="off">
		<div class="layer-title clearfix"><h2>修改演出计划</h2><span class="layerClose"></span></div>
		<table width="500">
			<tr>
				<td width="350">
					<div class="layer-content">
						<input type="hidden" value="" name="sched_id">
						<div class="aFllink clearfix"><span>选择演出厅：</span>
							<select style="width: 225px; height: 25px" name="studio_id" id="studioSelect" required
									lay-verify="required"></select>
						</div>
						<div class="aFllink clearfix"><span>选择影片：</span><select style="width: 225px; height: 25px"
																				name="play_id" id="playSelect"
																				required
																				lay-verify="required"></select>
						</div>
						<div class="aFllink clearfix"><span>放映时间：</span><input type="text"
																			   onfocus="WdatePicker({dateFmt:'yyyy年MM月dd日 HH时mm分ss秒'})"
																			   name="sched_time" value="">
						</div>
						<div class="aFllink clearfix"><span>票　　价：</span><input type="text" name="sched_ticket_price"
																			   value=""></div>
						<%--<div class="aFllink clearfix"><textarea name="email" cols="10" rows="1" style="margin: 1px; width: 312px; height: 80px;--%>
						<%--wrap-option: physical; line-height: 2.0; border: 1px solid #cdcdcd;resize: none"></textarea>--%>
						<%--</div>--%>
						<%--<div class="aFllink clearfix"><span>家庭住址：</span><input type="text" name="addr" value="">--%>
						<%--</div>--%>
						<%--<div class="aFllink clearfix"><span>员工类型：</span>--%>
						<%--<select style="width: 225px; height: 25px" name="access" required--%>
						<%--lay-verify="required">--%>
						<%--<option selected="true" value="1">管理员</option>--%>
						<%--<option value="0">售票员</option>--%>
						<%--</select>--%>
						<%--</div>--%>
						<%--<div class="aFllink clearfix"><span>重置密码：</span><input type="password" name="password" value="">--%>
						<%--</div>--%>

						<%--<div class="aFllink clearfix"><span>上架状态：</span><input type="text" name="status" value=""></div>--%>
						<div class="XgBtn"><input type="submit" value="保存" class="saveBtn"></div>
					</div>
				</td>
				<%--<td width="150">--%>
				<%--<div class="aFllink clearfix"><span style="align-content: space-between">影片海报: </span></div>--%>
				<%--<div class="upload-Box" style="margin: 20px 30px">--%>
				<%--<span class="uplBtn"><i class="ico-load"></i>点击上传<input id="fileImage2" class="fileImageSlect" type="file" size="30" name="image"></span>--%>
				<%--</div>--%>
				<%--</td>--%>
			</tr>
		</table>
	</form>
</div>
<!--点击添加分类弹出-->
<div class="addFeileibox layuiBox">
	<form action="/scheduleAdd" method="post" autocomplete="off" commandName="employee">
		<div class="layer-title clearfix"><h2>添加计划</h2><span class="layerClose"></span></div>
		<table width="500">
			<tr>
				<td width="350">
					<div class="layer-content">
							<div class="aFllink clearfix"><span>选择演出厅：</span>
								<select style="width: 225px; height: 25px" name="studio_id" id="studioSelect1" required
										lay-verify="required"></select>
							</div>
						<div class="aFllink clearfix"><span>选择影片：</span><select style="width: 225px; height: 25px"
																				name="play_id" id="playSelect1"
																				required
																				lay-verify="required"></select>
						</div>
						<div class="aFllink clearfix"><span>放映时间：</span><input type="text"
																			   onfocus="WdatePicker({dateFmt:'yyyy-MM-dd HH:mm:ss'})"
																			   name="sched_time" value="">
						</div>
						<div class="aFllink clearfix"><span>票　价：</span>
							<input type="text" name="sched_ticket_price"
								   value="">
						</div>
						<%--<div class="aFllink clearfix"><span>家庭住址：</span><input autocomplete="off" required--%>
																			   <%--lay-verify="required"--%>
																			   <%--pattern="*{1,30}"--%>
																			   <%--oninvalid="setCustomValidity('请输入员工家庭住址!')"--%>
																			   <%--oninput="setCustomValidity('')"--%>
																			   <%--type="text" name="addr"--%>
																			   <%--id="addr"--%>
																			   <%--value=""></div>--%>
						<%--<div class="aFllink clearfix"><span>上架状态：</span><input type="text" name="status" value=""></div>--%>
						<%--<div class="aFllink clearfix"><span>员工类型：</span><select--%>
								<%--style="width: 225px; height: 25px" name="access" required--%>
								<%--lay-verify="required">--%>
							<%--<option selected="true" value="1">管理员</option>--%>
							<%--<option value="0">售票员</option>--%>
							<%--<br>--%>

							<div class="aFlBtn"><input type="submit" lay-submit value="保存" class="layui-Btn"></div>
						</div>
					<%--</div>--%>
				</td>
				<%--<td width="150">--%>
				<%--<div class="aFllink clearfix"><span style="align-content: space-between">影片海报: </span></div>--%>
				<%--<div class="upload-Box" style="margin: 20px 30px">--%>
				<%--<span class="uplBtn"><i class="ico-load"></i>点击上传<input id="fileImage1" class="fileImageSlect" type="file" size="30" name="image"></span>--%>
				<%--</div>--%>
				<%--</td>--%>
			</tr>
		</table>
	</form>
</div>
<!--栏目管理-->
<div class="Columnbox layuiBox">
	<div class="layer-title clearfix"><h2>栏目管理</h2><span class="layerClose"></span></div>
	<div class="layer-content">
		<ul class="colu-title clearfix">
			<li class="li-1">栏目名称</li>
			<li class="li-2">英文名称</li>
			<li class="li-3">操作</li>
			<li class="li-4">同步开关</li>
		</ul>
		<div class="colu-list">
			<ul class="colu-cont clearfix active">
				<li class="li-1"><i class="ico"></i>新闻动态</li>
				<li class="li-2">life</li>
				<li class="li-3"><a href="javascript:;" class="colu-xg" data-id="xg1">修改</a></li>
				<li class="li-4"><input type="checkbox" id="checkbox_d1" class="chk_4"><label
						for="checkbox_d1"></label>
				</li>
			</ul>
			<div class="colunext" style="display: block;">
				<ul class="colu-next clearfix">
					<li class="li-1"><i class="ico"></i>行业新闻</li>
					<li class="li-2"></li>
					<li class="li-3"><a href="javascript:;" class="colu-xg" data-id="xg2">修改</a></li>
				</ul>
				<ul class="colu-next clearfix">
					<li class="li-1"><i class="ico"></i>行业新闻</li>
					<li class="li-2"></li>
					<li class="li-3"><a href="javascript:;" class="colu-xg">修改</a></li>
				</ul>
			</div>
		</div><!--新闻动态-->
		<div class="colu-list">
			<ul class="colu-cont clearfix">
				<li class="li-1"><i class="ico"></i>品尚生活</li>
				<li class="li-2">news</li>
				<li class="li-3"><a href="javascript:;" class="colu-xg">修改</a></li>
				<li class="li-4"><input type="checkbox" id="checkbox_d2" class="chk_4"><label
						for="checkbox_d2"></label>
				</li>
			</ul>
			<div class="colunext">
				<ul class="colu-next clearfix">
					<li class="li-1"><i class="ico"></i>行业新闻</li>
					<li class="li-2"></li>
					<li class="li-3"><a href="javascript:;" class="colu-xg">修改</a></li>
				</ul>
				<ul class="colu-next clearfix">
					<li class="li-1"><i class="ico"></i>行业新闻</li>
					<li class="li-2"></li>
					<li class="li-3"><a href="javascript:;" class="colu-xg">修改</a></li>
				</ul>
			</div>
		</div><!--品尚生活-->
		<div class="colu-list">
			<ul class="colu-cont clearfix">
				<li class="li-1"><i class="ico"></i>卓越联盟</li>
				<li class="li-2">allance</li>
				<li class="li-3"><a href="javascript:;" class="colu-xg">修改</a></li>
				<li class="li-4"><input type="checkbox" id="checkbox_d3" class="chk_4"><label
						for="checkbox_d3"></label>
				</li>
			</ul>
			<div class="colunext">
				<ul class="colu-next clearfix">
					<li class="li-1"><i class="ico"></i>行业新闻</li>
					<li class="li-2"></li>
					<li class="li-3"><a href="javascript:;" class="colu-xg">修改</a></li>
				</ul>
				<ul class="colu-next clearfix">
					<li class="li-1"><i class="ico"></i>行业新闻</li>
					<li class="li-2"></li>
					<li class="li-3"><a href="javascript:;" class="colu-xg">修改</a></li>
				</ul>
			</div>
		</div><!--卓越联盟-->
		<div class="colu-list">
			<ul class="colu-cont clearfix">
				<li class="li-1"><i class="ico"></i>招贤纳士</li>
				<li class="li-2">managers</li>
				<li class="li-3"><a href="javascript:;" class="colu-xg">修改</a></li>
				<li class="li-4"><input type="checkbox" id="checkbox_d4" class="chk_4" checked=""><label
						for="checkbox_d4"></label></li>
			</ul>
			<div class="colunext">
				<ul class="colu-next clearfix">
					<li class="li-1"><i class="ico"></i>行业新闻</li>
					<li class="li-2"></li>
					<li class="li-3"><a href="javascript:;" class="colu-xg">修改</a></li>
				</ul>
				<ul class="colu-next clearfix">
					<li class="li-1"><i class="ico"></i>行业新闻</li>
					<li class="li-2"></li>
					<li class="li-3"><a href="javascript:;" class="colu-xg">修改</a></li>
				</ul>
			</div>
		</div><!--招贤纳士-->
		<div class="colu-list">
			<ul class="colu-cont clearfix">
				<li class="li-1"><i class="ico"></i>客户见证</li>
				<li class="li-2">witness</li>
				<li class="li-3"><a href="javascript:;" class="colu-xg">修改</a></li>
				<li class="li-4"><input type="checkbox" id="checkbox_d5" class="chk_4" checked=""><label
						for="checkbox_d5"></label></li>
			</ul>
			<div class="colunext">
				<ul class="colu-next clearfix">
					<li class="li-1"><i class="ico"></i>行业新闻</li>
					<li class="li-2"></li>
					<li class="li-3"><a href="javascript:;" class="colu-xg">修改</a></li>
				</ul>
				<ul class="colu-next clearfix">
					<li class="li-1"><i class="ico"></i>行业新闻</li>
					<li class="li-2"></li>
					<li class="li-3"><a href="javascript:;" class="colu-xg">修改</a></li>
				</ul>
			</div>
		</div><!--客户见证-->
		<div class="colu-list">
			<ul class="colu-cont clearfix">
				<li class="li-1"><i class="ico"></i>热门产品</li>
				<li class="li-2">product</li>
				<li class="li-3"><a href="javascript:;" class="colu-xg">修改</a></li>
				<li class="li-4"><input type="checkbox" id="checkbox_d6" class="chk_4" checked=""><label
						for="checkbox_d6"></label></li>
			</ul>
			<div class="colunext">
				<ul class="colu-next clearfix">
					<li class="li-1"><i class="ico"></i>行业新闻</li>
					<li class="li-2"></li>
					<li class="li-3"><a href="javascript:;" class="colu-xg">修改</a></li>
				</ul>
				<ul class="colu-next clearfix">
					<li class="li-1"><i class="ico"></i>行业新闻</li>
					<li class="li-2"></li>
					<li class="li-3"><a href="javascript:;" class="colu-xg">修改</a></li>
				</ul>
			</div>
		</div><!--热门产品-->
		<div class="colu-list">
			<ul class="clearfix colu-cont-no">
				<li class="li-1"><i class="ico"></i>关于我们</li>
				<li class="li-2">about</li>
				<li class="li-3"><a href="javascript:;" class="colu-xg">修改</a></li>
				<li class="li-4"></li>
			</ul>
		</div><!--关于我们-->
		<div class="colu-list">
			<ul class="clearfix colu-cont-no">
				<li class="li-1"><i class="ico"></i>联系方式</li>
				<li class="li-2">contact</li>
				<li class="li-3"><a href="javascript:;" class="colu-xg">修改</a></li>
				<li class="li-4"></li>
			</ul>
		</div><!--联系方式-->

	</div>
</div>
<!--栏目管理－修改-->
<div class="ColumnXgbox layuiBox">
	<div class="layer-title clearfix"><h2>添加分类</h2><span class="layerClose"></span></div>
	<div class="layer-content">
		<div class="aFllink clearfix"><span>修改名称：</span><input type="text" value=""></div>
		<div class="aFllink clearfix"><span>英文名称：</span><input type="text" value=""></div>
		<div class="aFlBtn"><input type="button" value="保存" class="saveBtn"></div>
	</div>
</div>


<script type="text/javascript" src="../../static/js/zxxFile.js"></script>

<script>
    var params = {
        fileInput: $("#fileImage").get(0),
        upButton: $("#fileSubmit").get(0),
        url: $("#uploadForm").attr("action"),
        filter: function (files) {
            var arrFiles = [];
            for (var i = 0, file; file = files[i]; i++) {
                if (file.type.indexOf("image") == 0) {
                    if (file.size >= 512000) {
                        alert('您这张"' + file.name + '"图片大小过大，应小于500k');
                    } else {
                        arrFiles.push(file);
                    }
                } else {
                    alert('文件"' + file.name + '"不是图片。');
                }
            }
            return arrFiles;
        },
        onSelect: function (files) {
            var html = '', i = 0;
            $("#preview").html('<div class="upload_loading"></div>');
            var funAppendImage = function () {
                file = files[i];
                if (file) {
                    var reader = new FileReader()
                    reader.onload = function (e) {
                        $('.XgfileImg img').attr('src', e.target.result);
                        $('.sp-photo').addClass('cur');
                        html = html + '<div id="uploadList_' + i + '" class="upload_append_list"><p><span>' + file.name + '</span>' +
                            '<a href="javascript:" class="upload_delete" title="删除" data-index="' + i + '">删除</a>' +
                            '</div>';

                        i++;
                        funAppendImage();
                    }
                    reader.readAsDataURL(file);
                } else {
                    $("#preview").html(html);
                    if (html) {
                        //删除方法
                        $(".upload_delete").click(function () {
                            ZXXFILE.funDeleteFile(files[parseInt($(this).attr("data-index"))]);
                            $('.sp-photo').removeClass('cur').html('栏目图片');
                            return false;
                        });
                        //提交按钮显示
                        $("#fileSubmit").show();
                    } else {
                        //提交按钮隐藏
                        $("#fileSubmit").hide();
                    }
                }
            };
            funAppendImage();
        },
        onDelete: function (file) {
            $("#uploadList_" + file.index).fadeOut();
        },
        onDragOver: function () {
            $(this).addClass("upload_drag_hover");
        },
        onDragLeave: function () {
            $(this).removeClass("upload_drag_hover");
        },
        onProgress: function (file, loaded, total) {
            var eleProgress = $("#uploadProgress_" + file.index), percent = (loaded / total * 100).toFixed(2) + '%';
            eleProgress.show().html(percent);
        },
        onSuccess: function (file, response) {
            $("#uploadInf").append("<p>上传成功，图片地址是：" + response + "</p>");
        },
        onFailure: function (file) {
            $("#uploadInf").append("<p>图片" + file.name + "上传失败！</p>");
            $("#uploadImage_" + file.index).css("opacity", 0.2);
        },
        onComplete: function () {
            //提交按钮隐藏
            $("#fileSubmit").hide();
            //file控件value置空
            $("#fileImage").val("");
            $("#uploadInf").append("<p>当前图片全部上传完毕，可继续添加上传。</p>");
        }
    };
    ZXXFILE = $.extend(ZXXFILE, params);
    ZXXFILE.init();
</script>
</body>
</html>