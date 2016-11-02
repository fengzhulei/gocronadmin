package controllers

import (
	"github.com/astaxie/beego"
)

type UserController struct {
	beego.Controller
}

func (c *UserController) Index() {
	c.Data["Website"] = "beego.me"
	c.Data["Email"] = "astaxie@gmail.com"
	c.TplName = "user.tpl"
}

func (c * UserController) Login()  {
	var ret = make(map[string]interface{})
	ret["ret"] = 1
	c.Data["json"] = ret
	c.ServeJSON()
}