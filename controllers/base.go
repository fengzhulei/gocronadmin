package controllers

import (
	"github.com/astaxie/beego"
	"github.com/astaxie/beego/context"
	"crypto/md5"
	"encoding/hex"
)

type baseController struct {
	beego.Controller
	JsonData map[string]interface{}
}

func (c *baseController) Init(ctx *context.Context, controllerName, actionName string, app interface{}) {
	c.Controller.Init(ctx , controllerName, actionName , app)
	c.JsonData = make(map[string]interface{})
}
func (c *baseController) md5Str(str string)  string {
	h := md5.New()
	h.Write([]byte(str))
	cipherStr := h.Sum(nil)
	return hex.EncodeToString(cipherStr)
}
