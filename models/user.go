package models

import (
	"github.com/astaxie/beego/orm"
	_ "github.com/go-sql-driver/mysql"
	"time"
)

type AdminUser struct {
	Id int
	Name string `orm:"size(100)"`
	Pwd string `orm:"size(32)"`
	Ctime time.Time
}

func init()  {
	orm.RegisterDataBase("default", "mysql", "wida:wida@/mycron?charset=utf8", 30)
	// register model
	orm.RegisterModel(new(AdminUser))
	// create table
	orm.RunSyncdb("default", false, true)
	orm.Debug = true
}

func GetUserInfoByName(name string) ( AdminUser,error) {
	o := orm.NewOrm()
	qs := o.QueryTable("admin_user")
	user := AdminUser{}
	err := qs.Filter("name",name).One(&user)
	return user,err
}

func List() []*AdminUser {
	var users []*AdminUser
	o := orm.NewOrm()
	qs := o.QueryTable("admin_user")
	qs.All(&users)
	return users
}

func AddUser(name,pwd string) (int64, error) {
	o := orm.NewOrm()
	var user AdminUser
	user.Name = name
	user.Pwd = pwd
	user.Ctime = time.Now()

	return  o.Insert(&user)
}