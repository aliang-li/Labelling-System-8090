<%@ page language="java" import="java.util.*"
	contentType="text/html;charset=UTF-8"%>
<!DOCTYPE html>
<html>

<head>
<title>DICOM Web Viewer</title>
<meta charset="UTF-8">
<meta name="description"
	content="Medical viewer using DWV (DICOM Web Viewer) and jQery Mobile.">
<meta name="keywords"
	content="DICOM,HTML5,JavaScript,medical,imaging,DWV">
<meta name="viewport"
	content="width=device-width, initial-scale=1, user-scalable=no">


<meta name="theme-color" content="#2F3BA2" />
<meta name="viewport" content="width=device-width, initial-scale=1" />
<link rel="manifest" href="resources/manifest.json">
<link type="text/css" rel="stylesheet" href="css/style.css" />
<link type="text/css" rel="stylesheet"
	href="ext/jquery-mobile/jquery.mobile-1.4.5.min.css" />
<link type="text/css" rel="stylesheet"
	href="node_modules/nprogress/nprogress.css" />
<style type="text/css">
/* body{transform: scale(0.8);} */
.ui-popup .ui-controlgroup {
	background-color: #252525;
}

.colourLi>.ui-input-text {
	text-align: center;
}

.colourLi>.ui-input-text input {
	min-height: 2em;
	width: 7em;
	display: inline-block
}

.lwColourLi>.ui-input-text {
	text-align: center;
}

.lwColourLi>.ui-input-text input {
	min-height: 2em;
	width: 7em;
	display: inline-block
}

.ffColourLi>.ui-input-text {
	text-align: center;
}

.ffColourLi>.ui-input-text input {
	min-height: 2em;
	width: 7em;
	display: inline-block
}
/* jquery-mobile strip not visible enough */
.table-stripe tbody tr:nth-child(odd) td, .table-stripe tbody tr:nth-child(odd) th
	{
	background-color: #eeeeee; /* non-RGBA fallback  */
	background-color: rgba(0, 0, 0, 0.1);
}

.clear {
	clear: both;
}
.toolbar a{
width:58px;}
#mlTable td {
    border-bottom: 1px solid #373737; 
	font-size: 15px;
	padding: 8px 8px 8px 12px;
	/* color: black; */
	text-align:center;
}

.hide{
display:none;}
#pageMain{
	white-space: nowrap;
	width:100%;
	height:90%;
	overflow:hidden;
}
#pageMain>div{
	display:inline-block;
	white-space: normal;
	vertical-align:top; 
}
#leftPanel{
	width:250px;
}
#contentPanel{
	height:100%;
	background-color:#000000ab;
}
#contentPanel table{
	width:100%;
	height:100%;
	text-align:center;
	
}
#rightPanel{
	width:300px;
	padding-left:5px;
}
.localtion{
	width:100%;
	text-align:right;
}
.toolbar .ui-btn{
	padding:.7em 0.1em; 
}
.toolbar .ui-btn-icon-top {
    padding-top: 2.5em;
}
#changeLayout{
	 padding:.5em 0em;
}
</style>
<!-- mobile web app -->
<meta http-equiv="pragma" content="no-cache">
<meta http-equiv="Cache-Control" content="no-cache, must-revalidate">
<meta http-equiv="expires" content="Wed, 26 Feb 2008 08:21:57 GMT">
<meta name="mobile-web-app-capable" content="yes" />
<link rel="shortcut icon" sizes="16x16"
	href="resources/icons/dwv-16.png" />
<link rel="shortcut icon" sizes="32x32"
	href="resources/icons/dwv-32.png" />
<link rel="shortcut icon" sizes="64x64"
	href="resources/icons/dwv-64.png" />
<link rel="shortcut icon" sizes="128x128"
	href="resources/icons/dwv-128.png" />
<link rel="shortcut icon" sizes="256x256"
	href="resources/icons/dwv-256.png" />
<!-- apple specific -->
<meta name="apple-mobile-web-app-capable" content="yes" />
<meta name="apple-mobile-web-app-status-bar-style" content="black" />
<link rel="apple-touch-icon" sizes="16x16"
	href="resources/icons/dwv-16.png" />
<link rel="apple-touch-icon" sizes="32x32"
	href="resources/icons/dwv-32.png" />
<link rel="apple-touch-icon" sizes="64x64"
	href="resources/icons/dwv-64.png" />
<link rel="apple-touch-icon" sizes="128x128"
	href="resources/icons/dwv-128.png" />
<link rel="apple-touch-icon" sizes="256x256"
	href="resources/icons/dwv-256.png" />
<!-- Third party (dwv) -->
<script type="text/javascript" src="node_modules/i18next/i18next.min.js"></script>
<script type="text/javascript"
	src="node_modules/i18next-xhr-backend/i18nextXHRBackend.min.js"></script>
<script type="text/javascript"
	src="node_modules/i18next-browser-languagedetector/i18nextBrowserLanguageDetector.min.js"></script>
<script type="text/javascript"
	src="node_modules/jszip/dist/jszip.min.js"></script>
<script type="text/javascript" src="node_modules/konva/konva.js"></script>
<script type="text/javascript"
	src="node_modules/magic-wand-js/js/magic-wand.js"></script>
<!-- Third party (viewer) -->
<script type="text/javascript"
	src="node_modules/jquery/dist/jquery.min.js"></script>
<script type="text/javascript"
	src="ext/jquery-mobile/jquery.mobile-1.4.5.min.js"></script>
<script type="text/javascript" src="node_modules/nprogress/nprogress.js"></script>
<script type="text/javascript" src="ext/flot/jquery.flot.min.js"></script>
<!-- decoders -->
<script type="text/javascript"
	src="node_modules/dwv/decoders/pdfjs/jpx.js"></script>
<script type="text/javascript"
	src="node_modules/dwv/decoders/pdfjs/util.js"></script>
<script type="text/javascript"
	src="node_modules/dwv/decoders/pdfjs/arithmetic_decoder.js"></script>
<script type="text/javascript"
	src="node_modules/dwv/decoders/pdfjs/jpg.js"></script>
<script type="text/javascript"
	src="node_modules/dwv/decoders/rii-mango/lossless-min.js"></script>
<!-- dwv -->
<script type="text/javascript" src="node_modules/dwv/dist/dwv.js"></script>


<!-- Launch the app -->
<script type="text/javascript">
      //The location of state.json and uploadServlet
      var needStoreIf=0;
      var loadImageIf=0;
      var lastlabel="";
      var loadlabel=0;
      var sliceNow=-1;
      var jsontostore =[];
      var commentsList=[];
      
      var loadErrorForCannotOk="请耐心等待界面顶端蓝色进度条加载完毕，如两分钟还未加载完毕，请返回选择其他文件夹进行标注";
      var sliceChangeIf=0;
      var alertOnlyOnce=0;
      var loadReady=0;
      var readyApp;
      var realDicomNumber=0;
      var random = Math.random().toString();
      var loadIf ="<%=session.getAttribute("loadIf")%>";
      if (loadIf=="1"){
    	  loadIf=1;
      }else{
    	  loadIf=0;
      }
      maskUrls[parseInt(currentWindow)]="<%=session.getAttribute("resParentPath")%>"; 
      var jsonUrl="<%=session.getAttribute("jsonPath")%>"+"|"+random;
      var commentsJsonUrl="<%=session.getAttribute("commentsJsonPath")%>"+"|"+random;
      <%System.out.println(session.getAttribute("jsonPath") + "-----------index");%>
      var uploadServletUrl="http://222.24.62.190:8090/BB/UploadServlet";
      //var dicomList=["http://222.24.62.190:8090/BB/2/1.dcm"
    	//  ];
      var  dicomList=new Array();//dcm数据路径
      <%String[] res = (String[]) session.getAttribute("resPATH");
			System.out.println("resPATH++" + res.length + "-----------index");
			
			%>
     <%for (int i = 0; i < res.length; i++) {%>

          dicomList[ <%=i%> ]= "<%=res[i]%>";
    <%}%>
    <%String name = "";
	  String[] nameArray = res[0].split("/test/");
	  String[] name1 = (String[]) nameArray[1].split("/");
	  System.out.println("name1--"+name1+"-----------index");
		for (int i = 1; i < name1.length - 1; i++) {
			name = name + name1[i] + ">>";
			//System.out.println("name--"+name+"-----------index");
		}%>
  	var name="当前位置 : " + "<%=name%>";
</script>
<script type="text/javascript" src="src/register-sw.js"></script>
<script type="text/javascript" src="src/appgui.js"></script>
<script type="text/javascript" src="src/applauncher.js"></script>

<script type="text/javascript">

	function storeToJson() {
		needStoreIf = 1;
		loadImageIf = 1;
		loadReady = 1;
		//var lastlabel="";
		//var loadlabel=1;
		var comments = document.getElementById("commentsNowSlice");
		var row1 = {};
		row1.id = sliceNow;
		row1.comments = comments.value;
		var count = 0;
		for (var i = 0; i < jsontostore.length; i++) {
			if (jsontostore[i].id == sliceNow) {
				jsontostore[i].comments = comments.value;
				count = 1;
			}
		}
		if (count == 0) {
			jsontostore.push(row1);
		}
	}
	var commentsUrl = commentsJsonUrl.split("|")[0];
	$
			.getJSON(commentsUrl, function(json) {
				$.each(json, function(infoIndex, info) {
					var row1 = {};
					row1.id = info["id"];
					row1.comments = info["comments"];
					jsontostore.push(row1);
				})
			})
</script>
</head>

<body>

	<!-- Main page -->
	<div data-role="page" data-theme="b" id="main">

		<!-- pageHeader #dwvversion -->
		<div id="pageHeader" data-role="header" style="">
			<h1>
				大智慧医疗在线标注系统 <span class="dwv-version"></span>
			</h1>

			 
			<a href="javascript:"
				onclick="window.location.href='http://222.24.62.190:8090/BB/qiye_admin/HTML_model/index.jsp?param0=<%=request.getParameter("param0")%>';"
				data-icon="carat-l" class="ui-btn-left" data-transition="slide"
				data-i18n="basics.back">back</a> 
		
			<a href="#help_page"
				data-icon="carat-r" class="ui-btn-right" data-transition="slide"
				data-i18n="basics.help">Help</a>
		</div>
		<!-- /pageHeader -->
		<div align="center" style="display: none;" id="errorPage">
			<h1 align="center" style="color: red; font-size: 50px">请点击左上角返回按键</h1>
		</div>
		<!-- DWV -->
		<div id="dwv">
			<div id="pageMain" data-role="content" style="padding: 2px;">
				<div id="leftPanel">
					<div style="height:100%;width:100%">
						<table id="mlTable" style="width: 100%; border-collapse:collapse;">
						</table>
					</div>
				</div>
				<div id="contentPanel">
					<table style="width:;">
					<tr>
						<td  class="content0" align="middle">
							<!-- Layer Container -->
							<div class="layerContainer0">
								<div class="dropBox0"></div>
								<canvas id="canvas0" class="imageLayer0">Only for HTML5 compatible browsers...</canvas>
								<div class="drawDiv0"></div>
								<div class="infoLayer0">
									<div class="infotl0 info"></div>
									<div class="infotc0 infoc"></div>
									<div class="infotr0 info"></div>
									<div class="infocl0 infoc"></div>
									<div class="infocr0 infoc"></div>
									<div class="infobl0 info"></div>
									<div class="infobc0 infoc"></div>
									<div class="infobr0 info"></div>
								</div>
								<!-- /infoLayer -->
							</div>
							<!-- /layerContainer -->
						</td>
						<td id="lc2" class="hide content1" style="border-left:1px solid #252525;" align="middle">
							<div class="layerContainer1">
								<div class="dropBox1"></div>
								<canvas class="imageLayer1">Only for HTML5 compatible browsers...</canvas>
								<div class="drawDiv1"></div>
								<div class="infoLayer1">
									<div class="infotl1 info"></div>
									<div class="infotc1 infoc"></div>
									<div class="infotr1 info"></div>
									<div class="infocl1 infoc"></div>
									<div class="infocr1 infoc"></div>
									<div class="infobl1 info"></div>
									<div class="infobc1 infoc"></div>
									<div class="infobr1 info"></div>
								</div>
							</div> 
						</td>
					</tr>
					</table>
				</div>
				<div id="rightPanel">
					<div class="localtion"></div>
					<button id="changeLayout">切换布局</button>
					<div class="clear"></div>
					<!-- Toolbar -->
					<div class="toolbar" style="width: 300px;text-align:left;"></div>
					<hr color="#373737">
					<div class="commentInfo" style="width:300px;text-align:center;">
						<table border="0" style="width:100%;">
							<tr>
								<th>当前切片标注信息</th>
							</tr>
							<tr>
							<td><textarea rows="30" cols="30"
									style="background-color: rgb(101, 103, 105); color: write;"
									onchange="storeToJson()" id="commentsNowSlice">
									Correct!
								</textarea>
							</td>
							</tr>
						</table>
					</div>
					<hr color="#373737">
				</div>

				<!-- Auth popup -->
				<div data-role="popup" id="popupAuth">
					<a href="#" data-rel="back" data-role="button" data-icon="delete"
						data-iconpos="notext" class="ui-btn-right"
						data-i18n="basics.close">Close</a>
					<div style="padding: 10px 20px;">
						<h3 data-i18n="io.GoogleDrive.auth.title">Google Drive
							Authorization</h3>
						<p data-i18n="io.GoogleDrive.auth.body">
							Please authorize DWV to access your Google Drive. <br>This
							is only needed the first time you connect.
						</p>
						<button id="gauth-button" class="ui-btn"
							data-i18n="io.GoogleDrive.auth.button">Authorize</button>
					</div>
				</div>
				<!-- /popup -->

				<!-- Open popup -->
				<div data-role="popup" id="popupOpen">
					<a href="#" data-rel="back" data-role="button" data-icon="delete"
						data-iconpos="notext" class="ui-btn-right"
						data-i18n="basics.close">Close</a>
					<div style="padding: 10px 20px;">
						<h3 data-i18n="basics.open">Open</h3>
						<div id="dwv-loaderlist"></div>
					</div>
				</div>
				<!-- /popup -->


				<!-- History -->
				<div class="history" title="History" style="display: none;"></div>

			</div>		<!-- /content -->

			<div data-role="footer">
				<div data-role="navbar" class="toolList"></div>
				<!-- /navbar -->
			</div>
			<!-- /footer -->

		</div>
		<!-- /page main -->

	</div>
	<!-- /dwv -->

	<!-- Tags page -->
	<div data-role="page" data-theme="b" id="tags_page">

		<div data-role="header">
			<a href="#main" data-icon="back" data-transition="slide"
				data-direction="reverse" data-i18n="basics.back">Back</a>
			<h1 data-i18n="basics.dicomTags">DICOM Tags</h1>
		</div>
		<!-- /header -->

		<div data-role="content">
			<!-- Tags -->
			<div id="dwv-tags" title="Tags"></div>
		</div>
		<!-- /content -->

	</div>
	<!-- /page tags_page-->

	<!-- Draw list page -->
	<div data-role="page" data-theme="b" id="drawList_page">

		<div data-role="header">
			<a href="#main" data-icon="back" data-transition="slide"
				data-direction="reverse" data-i18n="basics.back">Back</a>
			<h1 data-i18n="basics.drawList">Draw list</h1>
		</div>
		<!-- /header -->

		<div data-role="content">
			<!-- DrawList -->
			<div id="dwv-drawList" title="Draw list"></div>
		</div>
		<!-- /content -->
		<div data-role="content">
			<!-- DrawList -->
			<div id="dwv-drawList" title="Draw list"></div>
		</div>
		<!-- /content -->

	</div>

	<!-- Help page -->
	<div data-role="page" data-theme="b" id="help_page">

		<div data-role="header">
			<a href="#main" data-icon="back" data-transition="slide"
				data-direction="reverse" data-i18n="basics.back">Back</a>
			<h1 data-i18n="basics.help">Help</h1>
		</div>
		<!-- /header -->

		<div data-role="content">
			<!-- Help -->
			<div id="dwv-help" title="Help"></div>
		</div>
		<!-- /content -->
    
	</div>
	<!-- /page help_page-->

</body>
<script>
	
	$(function(){
		var cliWidth = document.body.clientWidth; //浏览器宽
        var cliHeight = document.body.clientHeight;//浏览器高
        //根据浏览器宽高动态改变div的宽高
        $("#contentPanel").width(cliWidth-580);
        $("#dwv").height(cliHeight-50);
		$(window).resize(function(){
	        cliWidth = document.body.clientWidth; //浏览器宽
	        cliHeight = document.body.clientHeight;//浏览器高
	        //根据浏览器宽高动态改变div的宽高
	        $("#contentPanel").width(cliWidth-580);
	       //$("#box").height(cliheight); 
	        $("#dwv").height(cliHeight-50);
	       //console.log("cliWidth:" + cliWidth);
	       //console.log("cliHeight:"+ cliHeight);
	    })  
	    $("#changeLayout").click(function(){
	    		isToggle = 1;
	    	   console.log("改变布局！！");
	    	   $("#lc2").toggleClass("hide");
	    	   
	    	   if(document.getElementById("lc2").className.indexOf("hide") > -1){
	    	    	readyApp.fitToSize({ 'width': ($(window).width() - 600)  , 'height': $(window).height() - 147 });
	    	    }else{
	    	        readyApp.fitToSize({ 'width': ($(window).width() - 600) / 2 , 'height': $(window).height() - 147 });
	    	   }
		})
	})
</script>
</html>
