package controllers

import (
	"gocronadmin/models"
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
	email := strings.TrimSpace(c.GetString("email"))
	confirm_password :=strings.TrimSpace(c.GetString("confirm_password"))
	if  username != "" && password != "" && password == confirm_password {
		 user := models.AdminUser{Name:username,Email:email,Pwd:c.md5Str(password)}
		_,err:=models.AddUser(user)
		if err == nil{
			c.Redirect("/user/index",302)
		}
		c.Data["err_info"] = "添加用户失败"

	}
	c.TplName = "user/user_add.tpl"
}


func (c *UserController)Modify()()  {
	id ,err := c.GetInt("id")
	var user models.AdminUser
	username :=strings.TrimSpace(c.GetString("username"))
	password :=strings.TrimSpace(c.GetString("password"))
	email := strings.TrimSpace(c.GetString("email"))
	confirm_password :=strings.TrimSpace(c.GetString("confirm_password"))
	if  username != "" && email != ""{
		if password != "" {
			if  password == confirm_password{
				user = models.AdminUser{Id:id,Name:username,Email:email,Pwd:c.md5Str(password)}
			}else{
				c.Data["err_info"] = "两次密码不匹配"
			}
		}else{
			user = models.AdminUser{Id:id,Name:username,Email:email}
		}
		_,err:=models.ModifyUser(user)
		if err == nil{
			c.Redirect("/user/index",302)
		}
		c.Data["err_info"] = "修改用户失败"
		user,err = models.UserInfo(id)
		c.TplName="user/user_modify.tpl"
		return
	}

	if err != nil{
		c.Data["err_info"] = "修改用户失败"
		goto GOTO
	}
	user,err = models.UserInfo(id)
	if err != nil{
		c.Data["err_info"] = "修改用户失败"
		goto GOTO
	}
	c.Data["user"] = user
	GOTO:
	c.TplName="user/user_modify.tpl"
}

func (c *UserController)Del()  {
	c.JsonData["status"] = 0
	id ,err := c.GetInt("id")
	if err != nil{
		c.JsonData["status"] = -1
		c.JsonData["err"] = err.Error()
	}
	_ ,err =models.DelUser(id)
	if err != nil{
		c.JsonData["status"] = -1
		c.JsonData["err"] = err.Error()
	}
	c.Data["json"] = c.JsonData
	c.ServeJSON()
}

func (c *UserController)Logout()  {
	c.DestroySession()
	c.Redirect("/user/login", 302)

}