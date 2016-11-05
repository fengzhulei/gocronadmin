package controllers

import (
	"beegoweb/models"
	"time"
	"strings"
)


type CronController struct {
	baseController
}

func (c *CronController) Index() {
	uid ,_ := c.GetSession("uid").(int)
	list := models.CronList(uid)
	c.Data["list"] = list
	c.TplName = "cron/index.tpl"
}


func (c *CronController)Add()  {
	if c.GetString("submit") != ""{
		cron := models.Cron{}
		timeLayout := "2006-01-02 15:04:05"
		loc, _ := time.LoadLocation("Local")
		Stime, _ := time.ParseInLocation(timeLayout, c.GetString("stime"), loc)
		Etime, _ := time.ParseInLocation(timeLayout, c.GetString("etime"), loc)
		cron.Name = strings.TrimSpace(c.GetString("name"))
		cron.Time = strings.TrimSpace(c.GetString("time"))
		cron.Cmd = strings.TrimSpace(c.GetString("cmd"))
		cron.Status = 0
		cron.Running =0
		cron.Modify =0
		cron.Stime =Stime
		cron.Etime =Etime
		cron.User = &models.AdminUser{Id:c.GetSession("uid").(int)}
		cron.Ctime = time.Now()
		_,err := models.AddCron(cron)
		if err == nil{
			c.Redirect("/cron/index",302)
		}
		c.Data["err_info"] = "添加任务失败"
	}
	c.TplName = "cron/add.tpl"
}


func (c *CronController)Modify()()  {
	c.TplName = "cron/modify.tpl"
}

func (c *CronController)Del()  {

}