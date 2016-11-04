<!DOCTYPE html>
<html lang="en">
  <head>
    <meta charset="utf-8">
    <title>登入 - 管理后台</title>
    <meta content="IE=edge,chrome=1" http-equiv="X-UA-Compatible">
    <meta name="viewport" content="width=device-width, initial-scale=1.0">
    <meta name="description" content="">
    <meta name="author" content="">
	<link rel="stylesheet" href="/static/js/lib/bootstrap/css/bootstrap.css">
    <link rel="stylesheet" href="/static/css/stylesheets_default/theme.css">
    <link rel="stylesheet" href="/static/css/font-awesome/css/font-awesome.css">
	<link rel="stylesheet" href="/static/css/other.css">
    <script src="/static/js/lib/jquery-1.8.1.min.js" ></script>
	<script src="/static/js/other.js" ></script>
    <style type="text/css">
        #line-chart {
            height:300px;
            width:800px;
            margin: 0px auto;
            margin-top: 1em;
        }
        .brand { font-family: georgia, serif; }
        .brand .first {
            color: #ccc;
            font-style: italic;
        }
        .brand .second {
            color: #fff;
            font-weight: bold;
        }
        .captcha img{
            height:40px;
        }
    </style>

    <!-- Le HTML5 shim, for IE6-8 support of HTML5 elements -->
    <!--[if lt IE 9]>
      <script src="http://html5shim.googlecode.com/svn/trunk/html5.js"></script>
    <![endif]-->
  </head>
  <body class="simple_body">
  <!--<![endif]-->
    <div class="navbar">
        <div class="navbar-inner">
                <ul class="nav pull-right">
                </ul>
                <a class="brand" href="/"><span class="first"></span> <span class="second">MyAdmin</span></a>
        </div>
    </div>
<div>
<div class="container-fluid">
    <div class="row-fluid">
    <div class="dialog">
		{{if .errorinfo}}{{.errorinfo}}{{end}}
        <div class="block">
            <p class="block-heading">登入</p>
            <div class="block-body">
                <form name="loginForm" method="post" action="/user/login">
                    <label>账号</label>
                    <input type="text" class="span12" name="username" value="" required="true" autofocus="true">
                    <label>密码</label>
                    <input type="password" class="span12" name="password" value = "" required="true" >
                   <label>验证码</label>
                   {{create_captcha}}
                     <input type="text" name="captcha" class="span4" placeholder="输入验证码" autocomplete="off" required="required">
					 <input type="hidden" class="span12" name="submit" value="1">
					 <input type="submit" class="btn btn-primary pull-right" name="loginSubmit" value="登入"/></div>
                </form>
            </div>
        </div>
        <p class="pull-right" style=""><a href="/" target="blank"></a></p>
    </div>
</div>
</div>
</div>
</body>
</html>