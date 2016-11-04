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
	users := models.List()
	c.Data["users"] = users
	c.TplName = "user/user_list.tpl"
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
	c.TplName = "user/login.tpl"
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


func (c *UserController)Add()  {

	username :=strings.TrimSpace(c.GetString("username"))
	password :=strings.TrimSpace(c.GetString("password"))
	confirm_password :=strings.TrimSpace(c.GetString("confirm_password"))
	if  username != "" && password != "" && password == confirm_password {
		_,err:=models.AddUser(username,c.md5Str(password))
		if err == nil{
			c.Redirect("/user/index",302)
		}
		c.Data["err_inf"] = "添加用户失败"

	}
	c.TplName = "user/user_add.tpl"
}


func (c *UserController)Logout()  {
	c.DestroySession()
	c.Redirect("/user/login", 302)

}