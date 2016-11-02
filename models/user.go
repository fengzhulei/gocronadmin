package models

import (
	"github.com/astaxie/beego/orm"
	_ "github.com/go-sql-driver/mysql"
)

type AdminUser struct {
	Id int
	Name string `orm:"size(100)"`
	Pwd string `orm:"size(32)"`
}

func init()  {
	orm.RegisterDataBase("default", "mysql", "wida:wida@/mycron?charset=utf8", 30)
	// register model
	orm.RegisterModel(new(AdminUser))
	// create table
	orm.RunSyncdb("default", false, true)
	orm.Debug = true
}

func GetUserInfoByName( name string) ( AdminUser,error) {
	o := orm.NewOrm()
	qs := o.QueryTable("admin_user")
	user := AdminUser{}
	err := qs.Filter("name",name).One(&user)
	return user,err
}