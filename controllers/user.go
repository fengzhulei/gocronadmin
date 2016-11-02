package controllers

import (
	"github.com/astaxie/beego"
	"beegoweb/models"
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
	c.SetSession("uid",4788)
	userinfo ,err := models.GetUserInfoByName("wida")
	if err != nil{
		//return
	}
	c.Data["json"] = userinfo
	c.ServeJSON()
}