package models

import (
	"github.com/astaxie/beego/orm"
	_ "github.com/go-sql-driver/mysql"
)

type MyadminUser struct {
	Id int
	Name string `orm:"size(100)"`
	Pwd string `orm:"size(32)"`
}

func init()  {
	orm.RegisterDataBase("default", "mysql", "wida:wida@/mycron?charset=utf8", 30)
	// register model
	orm.RegisterModel(new(MyadminUser))
	// create table
	orm.RunSyncdb("default", false, true)
	orm.Debug = true
}

func GetUserInfoByName( name string) ( MyadminUser,error) {
	o := orm.NewOrm()
	o.Using("mycron")
	qs := o.QueryTable("myadmin_user")
	user := MyadminUser{}
	err := qs.Filter("name",name).One(&user)
	return user,err
}