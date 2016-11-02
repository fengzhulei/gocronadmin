package controllers

import (
	"beegoweb/models"
)

type UserController struct {
	baseController
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
		c.JsonData["status"] = -1
		c.JsonData["err"] = "not user"
	}else{
		c.JsonData["status"] = 0
		c.JsonData["data"] = userinfo
	}

	c.Data["json"] = c.JsonData
	c.ServeJSON()
}