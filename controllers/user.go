package controllers

import (
	"beegoweb/models"
	"errors"
	"github.com/astaxie/beego/cache"
	"github.com/astaxie/beego/utils/captcha"
	"strings"
)
var cpt *captcha.Captcha
func init() {
	store := cache.NewMemoryCache()
	cpt = captcha.NewWithFilter("/captcha/", store)
}

type UserController struct {
	baseController
}

func (c *UserController) Index() {
	c.Data["Website"] = "beego.me"
	c.Data["Email"] = "astaxie@gmail.com"
	c.TplName = "user.tpl"
}

func (c *UserController) Login() {
	_,ok := c.GetSession("uid").(int)
	if ok {
		c.Redirect("/",302)
	}
	username :=strings.TrimSpace(c.GetString("username"))
	password :=strings.TrimSpace(c.GetString("password"))
	if  username != "" && password != "" {
		if !cpt.VerifyReq(c.Ctx.Request) {
			c.Data["errorinfo"] = errors.New("验证码错误")
			goto GOTO
		}
		user, err := c.toLogin(username, password)
		if err != nil {
			c.Data["errorinfo"] = err.Error()
			goto GOTO
		}
		c.SetSession("uid", user.Id)
		c.SetSession("username", user.Name)
		c.Redirect("/", 302)
	}
	GOTO:
	c.TplName = "login.tpl"
}

func (c *UserController) toLogin(name, pwd string) (*models.AdminUser, error) {
	userinfo, err := models.GetUserInfoByName(name)
	if err != nil {
		return nil, errors.New("not user")
	} else {
		if c.md5Str(pwd) != userinfo.Pwd {
			return nil, errors.New("pwd error")
		}
	}
	return &userinfo, nil
}


func (c *UserController)Logout()  {
	c.DestroySession()
	c.Redirect("/user/login", 302)

}