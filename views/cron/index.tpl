<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>任务列表</title>
    <meta name="keywords" content="">
    <meta name="description" content="">
    <link rel="shortcut icon" href="favicon.ico"> <link href="/static/css/bootstrap.min.css?v=3.3.6" rel="stylesheet">
    <link href="/static/css/font-awesome.css?v=4.4.0" rel="stylesheet">
    <!-- Data Tables -->
    <link href="/static/css/plugins/dataTables/dataTables.bootstrap.css" rel="stylesheet">
    <link href="/static/css/animate.css" rel="stylesheet">
    <link href="/static/css/style.css?v=4.1.0" rel="stylesheet">
</head>

<body class="gray-bg">
<div class="wrapper wrapper-content animated fadeInRight">
    <div class="row">
        <div class="col-sm-12">
            <div class="ibox float-e-margins">
                <div class="ibox-title">
                    <h5>基本 <small>分类，查找</small></h5>
                </div>
                <div class="ibox-content">
                    <table class="table table-striped table-bordered table-hover dataTables-example">
                        <thead>
                        <tr>
                            <th>ID</th>
                            <th>任务名</th>
                            <th>用户</th>
                            <th>时间调度表达式</th>
                            <th>命令</th>
                            <th>开始时间</th>
                            <th>结束时间</th>
                            <th>运行状态</th>
                            <th>是否单例</th>
                            <th>前置任务</th>
                            <th>状态</th>
                            <th>操作</th>
                        </tr>
                        </thead>
                        <tbody>
                        {{range .list}}
                        <tr class="gradeX">
                            <td>{{.Id}}</td>
                            <td>{{.Name}}</td>
                            <td>{{.User.Name}}</td>
                            <td>{{.Time}}</td>
                            <td>{{.Cmd}}</td>
                            <td>{{date .Stime "Y-m-d H:i:s"}}</td>
                            <td>{{date .Etime "Y-m-d H:i:s"}}</td>
                            <td>{{if .Running}}<a class="btn btn-danger btn-rounded" href="javascript:;">Running</a>{{else}}<a class="btn btn-default btn-rounded" href="javascript:;">Waiting</a>{{end}}</td>
                            <td>{{if .Singleton}}<button class="btn btn-info btn-circle" type="button"><i class="fa fa-check"></i></button>{{else}}<button class="btn btn-warning btn-circle" type="button"><i class="fa fa-times"></i></button>{{end}}</td>
                            <td>{{if .After}}{{.After}}{{else}}无{{end}}</td>
                            <td>{{if .Status}}
                                <a class="btn btn-danger btn-rounded" href="javascript:;" onclick="active_cron({{.Id}},'b')">已激活</a>
                                {{else}}
                                <a class="btn btn-default btn-rounded" href="javascript:;"  onclick="active_cron({{.Id}},'a')">未激活</a>
                                {{end}}</td>
                            <td>
                                <a class="btn btn-primary btn-rounded" href="/cron/modify?id={{.Id}}">修改</a>
                                <a class="btn btn-info btn-rounded" href="/cron/log?id={{.Id}}">查看日志</a>
                                <a class="btn btn-warning btn-rounded" href="javascript:;" onclick="cron_run_once({{.Id}})">立即执行一次</a>
                                <a class="btn btn-success btn-rounded" href="javascript:;" onclick="cron_del({{.Id}})">删除</a>
                            </td>
                        </tr>
                        {{end}}
                        </tbody>
                        <tfoot>
                        <tr>
                            <th>ID</th>
                            <th>任务名</th>
                            <th>用户</th>
                            <th>时间调度表达式</th>
                            <th>命令</th>
                            <th>开始时间</th>
                            <th>结束时间</th>
                            <th>运行状态</th>
                            <th>是否单例</th>
                            <th>前置任务</th>
                            <th>状态</th>
                            <th>操作</th>
                        </tr>
                        </tfoot>
                    </table>

                </div>
            </div>
        </div>
    </div>
</div>
<!-- 全局js -->
<script src="/static/js/jquery.min.js?v=2.1.4"></script>
<script src="/static/js/bootstrap.min.js?v=3.3.6"></script>
<script src="/static/js/plugins/jeditable/jquery.jeditable.js"></script>
<!-- Data Tables -->
<script src="/static/js/plugins/dataTables/jquery.dataTables.js"></script>
<script src="/static/js/plugins/dataTables/dataTables.bootstrap.js"></script>
<!-- 自定义js -->
<script src="/static/js/content.js?v=1.0.0"></script>
<!-- Page-Level Scripts -->
<script>
    $(document).ready(function () {
        $('.dataTables-example').dataTable();
        /* Init DataTables */
        var oTable = $('#editable').dataTable();
    });
    var cron_del = function (id) {
        if (confirm("你确认要删除该任务吗？")){
            $.post("/cron/del",{"id":id},function(data){
                if (data.status ==0){
                    location.reload()
                }else{
                    alert(data.err)
                }
            })
        }
        return false
    }

    var active_cron = function(id,act){
        info = status == "a"?"你确认要激活这个任务吗？":"你确认要下架该任务吗？";
        if (confirm(info)){
            $.post("/cron/active",{"id":id,"act":act},function(data){
                if (data.status ==0){
                    location.reload()
                }else{
                    alert(data.err)
                }
            })
        }
    }

    var cron_run_once = function(id,act){
        if (confirm("你确认要马上执行一次该任务吗？")){
            $.post("/cron/once",{"id":id},function(data){
                if (data.status ==0){
                    location.reload()
                }else{
                    alert(data.err)
                }
            })
        }
    }

    function fnClickAddRow() {
        $('#editable').dataTable().fnAddData([
            "Custom row",
            "New row",
            "New row",
            "New row",
            "New row"]);
    }
</script>
</body>
</html>
