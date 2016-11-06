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

func (c *CronController) Log() {
	Id ,_ := c.GetInt("id")
	hist := models.GetCronHist(Id)
	c.Data["hist"] = hist
	c.TplName = "cron/log.tpl"
}


func (c *CronController)Add()  {
	if c.GetString("submit") != ""{
		cron := models.Cron{}
		timeLayout := "2006-01-02 15:04:05"
		loc, _ := time.LoadLocation("Local")
		Stime, _ := time.ParseInLocation(timeLayout, c.GetString("stime"), loc)
		Etime, _ := time.ParseInLocation(timeLayout, c.GetString("etime"), loc)
		singleton,_:=c.GetInt8("singleton")
		cron.Name = strings.TrimSpace(c.GetString("name"))
		cron.Time = strings.TrimSpace(c.GetString("time"))
		cron.Cmd = strings.TrimSpace(c.GetString("cmd"))
		cron.Status = 0
		cron.Running =0
		cron.Modify =0
		cron.Stime =Stime
		cron.Etime =Etime
		cron.Singleton =singleton
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
	id ,err := c.GetInt("id")
	if err != nil{
		goto GOTO
	}

	if c.GetString("submit") != "" && id > 0 {
		cron := models.Cron{Id:id}
		timeLayout := "2006-01-02 15:04:05"
		loc, _ := time.LoadLocation("Local")
		Stime, _ := time.ParseInLocation(timeLayout, c.GetString("stime"), loc)
		Etime, _ := time.ParseInLocation(timeLayout, c.GetString("etime"), loc)
		singleton,_:=c.GetInt8("singleton")
		cron.Name = strings.TrimSpace(c.GetString("name"))
		cron.Time = strings.TrimSpace(c.GetString("time"))
		cron.Cmd = strings.TrimSpace(c.GetString("cmd"))
		cron.Modify =1
		cron.Stime =Stime
		cron.Etime =Etime
		cron.Singleton = singleton
		_,err := models.ModifyCron(cron,[]string{"name","stime","etime","time","cmd","modify","singleton"})
		if err == nil{
			c.Redirect("/cron/index",302)
		}
		c.Data["err_info"] = "添加任务失败"
	}
	GOTO:
	cronInfo,err := models.CronInfo(id)
	if err != nil{
		c.Data["err_info"] = "添加任务失败"
	}
	c.Data["info"] = cronInfo
	c.TplName = "cron/modify.tpl"
}

func (c *CronController) Active()  {
	c.JsonData["status"] = 0
	id ,err := c.GetInt("id")
	if err != nil{
		c.JsonData["status"] = -1
		c.JsonData["err"] = err.Error()
	}else{
		act  := c.GetString("act")
		var status int8
		if act =="a"{
			status = 1
		}else if act =="b" {
			status =0
		}else{
			c.JsonData["status"] = -1
			c.JsonData["err"] = "参数错误"
			goto GOTO
		}
		_,err = models.ModifyCron(models.Cron{Id:id,Status:status,Modify:1},[]string{"status","modify"})
		if err != nil{
			c.JsonData["status"] = -1
			c.JsonData["err"] = err.Error()
		}
	}
	GOTO:
	c.Data["json"] = c.JsonData
	c.ServeJSON()
}

func (c *CronController) Once()  {
	c.JsonData["status"] = 0
	id ,err := c.GetInt("id")
	if err != nil{
		c.JsonData["status"] = -1
		c.JsonData["err"] = err.Error()
	}else{
		_,err = models.ModifyCron(models.Cron{Id:id,Once:1},[]string{"once"})
		if err != nil{
			c.JsonData["status"] = -1
			c.JsonData["err"] = err.Error()
		}
	}
	c.Data["json"] = c.JsonData
	c.ServeJSON()
}

func (c *CronController)Del()  {
	c.JsonData["status"] = 0
	id ,err := c.GetInt("id")
	if err != nil{
		c.JsonData["status"] = -1
		c.JsonData["err"] = err.Error()

	}else{
		info,err :=models.CronInfo(id)
		if err != nil{
			c.JsonData["status"] = -1
			c.JsonData["err"] = err.Error()
			goto GOTO
		}

		if info.Status != 0 {
			c.JsonData["status"] = -1
			c.JsonData["err"] = "只有未激活任务才能删除"
		}

		if c.JsonData["status"] == 0 {
			_ ,err =models.DelCron(id)
			if err != nil{
				c.JsonData["status"] = -1
				c.JsonData["err"] = err.Error()
			}
		}
	}
	GOTO:
	c.Data["json"] = c.JsonData
	c.ServeJSON()
}