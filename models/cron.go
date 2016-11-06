package models

import (
	"github.com/astaxie/beego/orm"
	_ "github.com/go-sql-driver/mysql"
	"time"
)


type Cron struct {
	Id              int
	Name 		string `orm:"size(50)"`
	Time 		string `orm:"size(50)"`
	Cmd 		string `orm:"size(255)"`
	Stime		time.Time
	Etime    	time.Time
	Status          int8
	Running         int8
	Modify          int8
	Ip              string `orm:"size(20)"`
	Singleton       int8
	After           int
	Once            int8
	User  *AdminUser `orm:"rel(fk)"`
	Ctime          time.Time
}


func CronList(uid int) []*Cron {
	var cronlist []*Cron
	o := orm.NewOrm()
	if uid > 1{
		o.QueryTable("cron").Filter("user_id",uid).RelatedSel().All(&cronlist)
	}else{
		o.QueryTable("cron").RelatedSel().All(&cronlist)
	}
	return cronlist
}

func CronInfo(id int) ( Cron,error)  {
	o := orm.NewOrm()
	qs := o.QueryTable("cron")
	cron := Cron{}
	err := qs.Filter("id",id).RelatedSel().One(&cron)
	return cron,err

}

func AddCron(cron Cron) (int64, error) {
	o := orm.NewOrm()
	return  o.Insert(&cron)
}

func ModifyCron(cron Cron,fields []string)(int64, error) {
	o := orm.NewOrm()
	return  o.Update(&cron,fields...)
}


func DelCron(id int) (int64, error) {
	o := orm.NewOrm()
	return o.Delete(&Cron{Id: id})
}