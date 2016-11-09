package models

import (
	"github.com/astaxie/beego/orm"
	_ "github.com/go-sql-driver/mysql"
	"time"
)

type  AdminUser struct {
	Id int
	Name string `orm:"size(100)"`
	Pwd string `orm:"size(32)"`
	Email string `orm:"size(150)"`
	Ctime time.Time
	Cron []*Cron `orm:"reverse(many)"` // 设置一对多的反向关系
}

func init()  {
	orm.RegisterDataBase("default", "mysql", "wida:wida@/mycron?charset=utf8", 30)
	// register model
	orm.RegisterModel(new(AdminUser),new(Cron),new(CronHist))
	// create table
	//orm.RunSyncdb("default", false, true)
	orm.Debug = true
}

func GetUserInfoByName(name string) ( AdminUser,error) {
	o := orm.NewOrm()
	qs := o.QueryTable("admin_user")
	user := AdminUser{}
	err := qs.Filter("name",name).One(&user)
	return user,err
}

func UserInfo(id int) ( AdminUser,error)  {
	o := orm.NewOrm()
	qs := o.QueryTable("admin_user")
	user := AdminUser{}
	err := qs.Filter("id",id).One(&user)
	return user,err

}

func ModifyUser(user AdminUser)(int64, error)  {
	o := orm.NewOrm()
	fields :=[]string{"name","email"}
	if user.Pwd != ""{
		fields = append(fields,"pwd")
	}
	return  o.Update(&user,fields...)
}

func List() []*AdminUser {
	var users []*AdminUser
	o := orm.NewOrm()
	qs := o.QueryTable("admin_user")
	qs.All(&users)
	return users
}

func DelUser(id int) (int64, error) {
	o := orm.NewOrm()
	return o.Delete(&AdminUser{Id: id})
}


func AddUser(user AdminUser) (int64, error) {
	o := orm.NewOrm()
	user.Ctime = time.Now()
	return  o.Insert(&user)
}