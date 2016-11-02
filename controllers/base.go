package controllers

import (
	"github.com/astaxie/beego"
	"github.com/astaxie/beego/context"
)

type baseController struct {
	beego.Controller
	JsonData map[string]interface{}
}

func (c *baseController) Init(ctx *context.Context, controllerName, actionName string, app interface{}) {
	c.Controller.Init(ctx , controllerName, actionName , app)
	c.JsonData = make(map[string]interface{})
}