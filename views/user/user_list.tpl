<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>用户列表</title>
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
                            <th>用户名</th>
                            <th>Email</th>
                            <th>平台</th>
                            <th>操作</th>
                        </tr>
                        </thead>
                        <tbody>
                        {{range .users}}
                        <tr class="gradeX">
                            <td>{{.Id}}</td>
                            <td>{{.Name}}</td>
                            <td>{{.Email}}</td>
                            <td>{{date .Ctime "Y-m-d H:i:s"}}</td>
                            <td>
                                <a class="btn btn-primary btn-rounded" href="/user/modify?id={{.Id}}">修改</a>
                                <a class="btn btn-success btn-rounded" href="javascript:;" onclick="user_del({{.Id}})">删除</a>
                            </td>
                        </tr>
                        {{end}}
                        </tbody>
                        <tfoot>
                        <tr>
                            <th>ID</th>
                            <th>用户名</th>
                            <th>Email</th>
                            <th>平台</th>
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
    var user_del = function (id) {
        if (confirm("你确认要删除该用户吗？")){
            $.post("/user/del",{"id":id},function(data){
                if (data.status ==0){
                    location.reload()
                }else{
                    alert(data.err)
                }

            })
        }
        return false
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
