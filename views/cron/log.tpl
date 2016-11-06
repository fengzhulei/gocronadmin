<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>任务历史</title>
    <meta name="keywords" content="">
    <meta name="description" content="">
    <link rel="shortcut icon" href="favicon.ico">
    <link href="/static/css/bootstrap.min.css?v=3.3.6" rel="stylesheet">
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
                    <h5>最近执行记录(10次)</h5>
                </div>
                <div class="ibox-content">
                    <table class="table table-striped table-bordered table-hover dataTables-example">
                        <thead>
                        <tr>
                            <th>ID</th>
                            <th>进程ID</th>
                            <th>步骤</th>
                            <th>时间</th>
                            <th>结果</th>
                        </tr>
                        </thead>
                        <tbody>
                        {{range .hist}}
                        <tr class="gradeX">
                            <td>{{.Id}}</td>
                            <td>{{.ProcessId}}</td>
                            <td>{{.Step}}</td>
                            <td>{{date .Time "Y-m-d H:i:s"}}</td>
                            <td>{{.Ret}}</td>
                        {{end}}
                        </tbody>
                        <tfoot>
                        <tr>
                            <th>ID</th>
                            <th>进程ID</th>
                            <th>步骤</th>
                            <th>时间</th>
                            <th>结果</th>
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
<!--<script src="/static/js/plugins/dataTables/jquery.dataTables.js"></script>-->
<!--<script src="/static/js/plugins/dataTables/dataTables.bootstrap.js"></script>-->
<!-- 自定义js -->
<script src="/static/js/content.js?v=1.0.0"></script>
<!-- Page-Level Scripts -->
<script>
    $(document).ready(function () {
        $('.dataTables-example').dataTable();
        /* Init DataTables */
        var oTable = $('#editable').dataTable();
    });
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
