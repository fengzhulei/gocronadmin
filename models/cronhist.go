package models

import (
	"github.com/astaxie/beego/orm"
	_ "github.com/go-sql-driver/mysql"
	"time"
)

type CronHist struct {
	Id              int
	Cid             int
	ProcessId 	int
	Step            int8
	Time          time.Time
	Ret            string `orm:"size(255)"`
}

func GetCronHist(cid int) []*CronHist {
	var cronHist []*CronHist
	o := orm.NewOrm()
	o.QueryTable("cron_hist").Filter("cid",cid).OrderBy("-id").Limit(20).All(&cronHist)
	return cronHist
}
