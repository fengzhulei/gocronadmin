<!DOCTYPE html>
<html>
<head>
    <meta charset="utf-8">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <title>添加任务</title>
    <meta name="keywords" content="">
    <meta name="description" content="">
    <link rel="shortcut icon" href="favicon.ico"> <link href="/static/css/bootstrap.min.css?v=3.3.6" rel="stylesheet">
    <link href="/static/css/font-awesome.css?v=4.4.0" rel="stylesheet">
    <link href="/static/css/animate.css" rel="stylesheet">
    <link href="/static/css/style.css?v=4.1.0" rel="stylesheet">
    <script type="text/javascript" >
        var page= "add";
    </script>
</head>
<body class="gray-bg">
    <div class="wrapper wrapper-content animated fadeInRight">
        <div class="row">
            <div class="col-sm-12">
                <div class="ibox float-e-margins">
                    <div class="ibox-title">
                        <h5>添加任务</h5>
                    </div>
                    <div class="ibox-content">
                        <form class="form-horizontal m-t" id="cron_add" method="post" action="/cron/add">
                            {{if .err_info}}
                            <div class="form-group">
                                <label class="col-sm-3 control-label">{{.err_info}}</label>
                            </div>
                            {{end}}
                            <div class="form-group">
                                <label class="col-sm-3 control-label">任务名称：</label>
                                <div class="col-sm-8">
                                    <input id="name" name="name" class="form-control" type="text" aria-required="true" aria-invalid="true" class="error">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3 control-label">时间调度表达式：</label>
                                <div class="col-sm-8">
                                    <input id="time" name="time" class="form-control" type="text" aria-required="true" aria-invalid="true" class="error">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3 control-label">命令行：</label>
                                <div class="col-sm-8">
                                    <input id="cmd" name="cmd" class="form-control" type="text">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3 control-label">开始时间：</label>
                                <div class="col-sm-8">
                                    <input id="stime" name="stime" class="form-control layer-date" type="text" placeholder="YYYY-MM-DD hh:mm:ss" onclick="laydate({istime: true, format: 'YYYY-MM-DD hh:mm:ss'})">
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3 control-label">结束时间：</label>
                                <div class="col-sm-8">
                                    <input id="etime" name="etime" class="form-control layer-date" type="text" placeholder="YYYY-MM-DD hh:mm:ss" onclick="laydate({istime: true, format: 'YYYY-MM-DD hh:mm:ss'})">
                                </div>
                            </div>

                            <div class="form-group">
                                <label class="col-sm-3 control-label">是否单例：</label>
                                <div class="col-sm-8">
                                    <label class="checkbox-inline">
                                        <input name="singleton" type="radio" value="1" checked >是</label>
                                    <label class="checkbox-inline">
                                        <input name="singleton" type="radio" value="0" >否</label>
                                </div>
                            </div>
                            <div class="form-group">
                                <label class="col-sm-3 control-label">前置任务：</label>
                                <div class="col-sm-4">
                                    <input id="after" name="after" class="form-control" value="0" type="text">
                                </div>
                            </div>
                            <div class="form-group">
                                <input type="hidden" name="submit" value="1"/>
                                <div class="col-sm-8 col-sm-offset-3">
                                    <button class="btn btn-primary" type="submit">提交</button>
                                </div>
                            </div>
                        </form>
                    </div>
                </div>
            </div>
        </div>
    </div>
    <!-- 全局js -->
    <script src="/static/js/jquery.min.js?v=2.1.4"></script>
    <script src="/static/js/bootstrap.min.js?v=3.3.6"></script>
    <!-- 自定义js -->
    <script src="/static/js/content.js?v=1.0.0"></script>
    <!-- jQuery Validation plugin javascript-->
    <script src="/static/js/plugins/validate/jquery.validate.min.js"></script>
    <script src="/static/js/plugins/validate/messages_zh.min.js"></script>
    <script src="/static/js/demo/form-validate-demo.js"></script>
    <!-- layerDate plugin javascript -->
    <script src="/static/js/plugins/layer/laydate/laydate.js"></script>
    <script>
        //外部js调用
        laydate({
            elem: '#hello', //目标元素。由于laydate.js封装了一个轻量级的选择器引擎，因此elem还允许你传入class、tag但必须按照这种方式 '#id .class'
            event: 'focus' //响应事件。如果没有传入event，则按照默认的click
        });

        //日期范围限制
        var start = {
            elem: '#start',
            format: 'YYYY/MM/DD hh:mm:ss',
            min: laydate.now(), //设定最小日期为当前日期
            max: '2099-06-16 23:59:59', //最大日期
            istime: true,
            istoday: false,
            choose: function (datas) {
                end.min = datas; //开始日选好后，重置结束日的最小日期
                end.start = datas //将结束日的初始值设定为开始日
            }
        };
        var end = {
            elem: '#end',
            format: 'YYYY/MM/DD hh:mm:ss',
            min: laydate.now(),
            max: '2099-06-16 23:59:59',
            istime: true,
            istoday: false,
            choose: function (datas) {
                start.max = datas; //结束日选好后，重置开始日的最大日期
            }
        };
        laydate(start);
        laydate(end);
    </script>
</body>
</html>
