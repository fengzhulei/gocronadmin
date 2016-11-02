package routers

import (
	"beegoweb/controllers"
	"github.com/astaxie/beego"
	"github.com/astaxie/beego/context"
)



func init() {
	//登录过滤器
	var FiterLogin  = func(ctx * context.Context) {
		_,ok := ctx.Input.Session("uid").(int)
		if !ok && ctx.Request.RequestURI != "/user/login"{
			ctx.Redirect(302,"/user/login")
		}
	}
	beego.InsertFilter("/*",beego.BeforeRouter,FiterLogin)
	beego.Router("/", &controllers.MainController{})
	beego.AutoRouter(&controllers.UserController{})
}
