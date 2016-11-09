<!DOCTYPE html>
<html>
<head>
  <meta charset="utf-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <meta name="renderer" content="webkit">
  <title>任务管理后台-gocronadmin</title>
  <meta name="keywords" content="">
  <meta name="description" content="">
  <!--[if lt IE 9]>
  <meta http-equiv="refresh" content="0;ie.html" />
  <![endif]-->
  <link rel="shortcut icon" href="favicon.ico"> <link href="/static/css/bootstrap.min.css?v=3.3.6" rel="stylesheet">
  <link href="/static/css/font-awesome.min.css?v=4.4.0" rel="stylesheet">
  <link href="/static/css/animate.css" rel="stylesheet">
  <link href="/static/css/style.css?v=4.1.0" rel="stylesheet">
</head>

<body class="fixed-sidebar full-height-layout gray-bg" style="overflow:hidden">
<div id="wrapper">
  <!--左侧导航开始-->
  <nav class="navbar-default navbar-static-side" role="navigation">
    <div class="nav-close"><i class="fa fa-times-circle"></i>
    </div>
    <div class="sidebar-collapse">
      <ul class="nav" id="side-menu">
        <li class="nav-header">
          <div class="dropdown profile-element">
            <a data-toggle="dropdown" class="dropdown-toggle" href="#">
                                <span class="clear">
                                    <span class="block m-t-xs" style="font-size:20px;">
                                        <i class="fa fa-area-chart"></i>
                                        <strong class="font-bold">gocronadmin</strong>
                                    </span>
                                </span>
            </a>
          </div>
          <div class="logo-element">gocron</div>
        </li>
        <li class="hidden-folded padder m-t m-b-sm text-muted text-xs">
          <span class="ng-scope">系统菜单</span>
        </li>
        <li>
          <a href="#">
            <i class="fa fa fa-bar-chart-o"></i>
            <span class="nav-label">用户管理</span>
            <span class="fa arrow"></span>
          </a>
          <ul class="nav nav-second-level">
            <li>
              <a class="J_menuItem" href="/user/index">用户列表</a>
            </li>
            <li>
              <a class="J_menuItem" href="/user/add">添加用户</a>
            </li>
          </ul>
        </li>
        <li class="line dk"></li>
        <li class="hidden-folded padder m-t m-b-sm text-muted text-xs">
          <span class="ng-scope">任务管理</span>
        </li>
        <li>
          <a href="#"><i class="fa fa-table"></i> <span class="nav-label">任务管理</span><span class="fa arrow"></span></a>
          <ul class="nav nav-second-level">
            <li><a class="J_menuItem" href="/cron/index">任务列表</a>
            </li>
            <li><a class="J_menuItem" href="/cron/add">添加任务</a>
            </li>
          </ul>
        </li>
      </ul>
    </div>
  </nav>
  <!--左侧导航结束-->
  <!--右侧部分开始-->
  <div id="page-wrapper" class="gray-bg dashbard-1">
    <div class="row border-bottom">
      <nav class="navbar navbar-static-top" role="navigation" style="margin-bottom: 0">
        <div class="navbar-header"><a class="navbar-minimalize minimalize-styl-2 btn btn-info " href="#"><i class="fa fa-bars"></i> </a>
          <form role="search" class="navbar-form-custom" method="post" action="search_results.html">
            <div class="form-group">
              <!--<input type="text" placeholder="请输入您需要查找的内容 …" class="form-control" name="top-search" id="top-search">-->
            </div>
          </form>
        </div>
        <ul class="nav navbar-top-links navbar-right">
          <li class="dropdown">
            <a class="right_info" href="javascript:;">
               <span class="label label-warning">{{.name}}</span>
            </a>
          </li>
          <li class="dropdown">
            <a class="right_info" href="/user/logout">
              <span class="label label-primary">退出</span>
            </a>
          </li>
        </ul>
      </nav>
    </div>
    <div class="row J_mainContent" id="content-main">
      <iframe id="J_iframe" width="100%" height="100%" src="/cron/index" frameborder="0" data-id="center" seamless></iframe>
    </div>
  </div>
  <!--右侧部分结束-->
</div>
<!-- 全局js -->
<script src="/static/js/jquery.min.js?v=2.1.4"></script>
<script src="/static/js/bootstrap.min.js?v=3.3.6"></script>
<script src="/static/js/plugins/metisMenu/jquery.metisMenu.js"></script>
<script src="/static/js/plugins/slimscroll/jquery.slimscroll.min.js"></script>
<script src="/static/js/plugins/layer/layer.min.js"></script>
<!-- 自定义js -->
<script src="/static/js/hAdmin.js?v=4.1.0"></script>
<script type="text/javascript" src="/static/js/index.js"></script>
<!-- 第三方插件 -->
<script src="/static/js/plugins/pace/pace.min.js"></script>
</body>
</html>